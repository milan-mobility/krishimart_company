# Flutter GetX Project Architecture and AI Screen-Creation Rules

> **File location:** Save this file as `AGENTS.md` in the project root, at the same level as `pubspec.yaml`.
>
> These rules are mandatory for every AI assistant, developer, or code-generation tool working in this Flutter project.

## 1. Primary Objective

Maintain a predictable, scalable, and reusable Flutter structure using GetX. Every new screen must follow the same file naming, folder placement, controller separation, widget separation, styling, assets, routing, and business-logic rules.

The word `home` below is only an example. Replace it with the actual screen or feature name.

## 2. Required Project Structure

```text
project_root/
├── AGENTS.md
├── pubspec.yaml
├── assets/
│   ├── png/
│   ├── svg/
│   └── fonts/
└── lib/
    ├── app/
    │   ├── app.dart
    ├── data/
    │   ├── models/
    │   ├── repository/
    │   ├── services/
    │   ├── local/
    │   └── remote/
    ├── gen/
    ├── helpers/
    │   ├── app_colors.dart
    │   ├── styles.dart
    │   ├── app_constants.dart
    │   └── extensions/
    ├── routes/
    │   ├── app_pages.dart
    │   └── app_routes.dart
    ├── translations/
    │   ├── app_translations.dart
    │   └── translation_keys.dart
    ├── utils/
    ├── view/
    │   ├── base/
    │   └── screens/
    │       └── home/
    │           ├── controller/
    │           │   └── home_controller.dart
    │           ├── widgets/
    │           │   ├── people_list_widget.dart
    │           │   └── people_list_row.dart
    │           └── home_screen.dart
    └── main.dart
```

## 3. Mandatory Screen Naming and Placement

For a screen named `Home`:

- Folder: `lib/view/screens/home/`
- Screen file: `home_screen.dart`
- Screen class: `HomeScreen`
- Controller file: `home_controller.dart`
- Controller class: `HomeController extends GetxController`
- Screen widgets: `lib/view/screens/home/widgets/`

Use `snake_case` for files and folders. Use `PascalCase` for Dart classes.

Examples:

| Screen name | Folder | Screen file | Screen class | Controller class |
|---|---|---|---|---|
| Home | `home/` | `home_screen.dart` | `HomeScreen` | `HomeController` |
| User Profile | `user_profile/` | `user_profile_screen.dart` | `UserProfileScreen` | `UserProfileController` |
| Order Details | `order_details/` | `order_details_screen.dart` | `OrderDetailsScreen` | `OrderDetailsController` |

## 4. Screen-Class Rule

A screen must be stateless.

For screens that use a GetX controller, prefer `GetView<ControllerType>`. `GetView` is a stateless widget and provides typed controller access.

```dart
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : const HomeContentWidget(),
      ),
    );
  }
}
```

A screen without a controller may extend `StatelessWidget`.

Do not use `StatefulWidget` unless a Flutter API absolutely requires local lifecycle state. Before creating one, verify that the state cannot be managed by GetX.

## 5. Controller Rules

Every screen-specific controller must be stored inside the screen's `controller` folder.

```text
lib/view/screens/home/controller/home_controller.dart
```

Required class format:

```dart
class HomeController extends GetxController {
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    // Business flow belongs here.
  }
}
```

Controller requirements:

1. All screen business logic must be inside the controller.
2. API calls must not be made directly from a screen or widget.
3. Database, cache, and remote access must go through classes inside `data/repository`, `data/services`, `data/local`, or `data/remote`.
4. The controller coordinates repositories, updates observable state, validates input, and handles the screen flow.
5. A controller must not build widgets or return `Widget` objects.
6. Avoid passing `BuildContext` into the controller.
7. Use meaningful method names such as `loadPeople`, `submitForm`, `refreshOrders`, and `selectCategory`.
8. Dispose workers, streams, text controllers, animation controllers, and other resources in `onClose`.
9. Keep observable state private when practical and expose only what the UI needs.
10. Do not place unrelated feature logic in a screen controller.

## 6. Widget-Separation Rules

Every meaningful sub-widget must be placed in a separate file inside the screen's `widgets` folder.

```text
lib/view/screens/home/widgets/
```

Examples:

```text
home_header_widget.dart
home_summary_card.dart
people_list_widget.dart
people_list_row.dart
empty_people_widget.dart
home_loading_widget.dart
```

Mandatory rules:

1. Do not create sub-widget classes inside `home_screen.dart`.
2. Do not create private widget classes such as `_Header`, `_Body`, or `_Card` in the same file.
3. Do not create large helper methods such as `_buildHeader()`, `_buildPeopleList()`, or `_buildSummaryCard()` that return widgets.
4. Create a dedicated widget class and file instead.
5. Keep one main public widget class per file.
6. Pass only the required values and callbacks through constructors.
7. A screen-specific widget stays inside that screen's `widgets` folder.
8. A widget used by multiple screens must be moved to `lib/view/base/`.
9. Prefer small `Obx` sections around only the changing widget instead of wrapping the entire screen.
10. Use `const` constructors wherever possible.

## 7. List and Grid Row Rules

Any widget representing one item in a list, grid, table, carousel, or repeated layout must have its own row/item/tile file.

Examples:

```text
people_list_row.dart       -> PeopleListRow
order_list_item.dart       -> OrderListItem
product_grid_tile.dart     -> ProductGridTile
notification_list_row.dart -> NotificationListRow
```

Example:

```dart
class PeopleListRow extends StatelessWidget {
  const PeopleListRow({
    required this.person,
    required this.onTap,
    super.key,
  });

  final PersonModel person;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        person.name,
        style: Styles.titleMedium,
      ),
    );
  }
}
```

The parent list widget is also separate:

```dart
class PeopleListWidget extends StatelessWidget {
  const PeopleListWidget({
    required this.people,
    required this.onPersonTap,
    super.key,
  });

  final List<PersonModel> people;
  final ValueChanged<PersonModel> onPersonTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: people.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final person = people[index];
        return PeopleListRow(
          person: person,
          onTap: () => onPersonTap(person),
        );
      },
    );
  }
}
```
## 9. Routing Rules

All named routes must be declared in `lib/routes/app_routes.dart`.

```dart
abstract final class AppRoutes {
  static const String home = '/home';
  static const String userProfile = '/user-profile';
}
```

All GetX pages must be registered in `lib/routes/app_pages.dart`.

```dart
class AppPages {
  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
  ];
}
```

Use `Get.toNamed`, `Get.offNamed`, or `Get.offAllNamed` for navigation. Do not introduce direct `MaterialPageRoute` navigation when a named route is suitable.

## 10. Colors and Typography

### Colors

All application colors must come from:

```text
lib/helpers/app_colors.dart
```

Do not hardcode colors in screens or widgets.

Not allowed:

```dart
color: const Color(0xFFE75A5A)
color: Colors.red
```

Required:

```dart
color: AppColors.primary
```

### Typography

All font families, font weights, font sizes, and reusable text styles must come from:

```text
lib/helpers/styles.dart
```

Do not repeatedly create inline `TextStyle` objects.

Not allowed:

```dart
Text(
  'Title',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
)
```

Required:

```dart
Text(
  'Title'.tr,
  style: Styles.titleLarge,
)
```

When a design requires a new reusable color or text style, add it to `app_colors.dart` or `styles.dart` first and then use it in the screen.

## 11. Asset Rules

Assets must be stored only in these folders:

```text
assets/png/
assets/svg/
assets/fonts/
```

Rules:

1. PNG, JPG, and WEBP images go in `assets/png/` unless a separate image folder already exists.
2. SVG files go in `assets/svg/`.
3. Font files go in `assets/fonts/`.
4. Register all required folders and fonts in `pubspec.yaml`.
5. Do not place assets inside `lib/`.
6. Reuse an existing asset before adding a duplicate.
7. Use generated asset references from `lib/gen/` when the project already supports generation.
8. Do not manually edit generated files inside `lib/gen/`.

## 12. Data-Layer Rules

Use the data layer as follows:

```text
lib/data/models/       -> Request, response, entity, and view-data models
lib/data/repository/   -> Repository classes that coordinate data sources
lib/data/services/     -> Shared services such as API, storage, notifications
lib/data/local/        -> Local database, cache, and preferences implementations
lib/data/remote/       -> Remote API clients and remote data sources
```

Rules:

- Every model must be placed in its own file.
- Use typed models instead of passing unstructured maps through the UI.
- Repository methods must return clear typed results.
- UI widgets must not parse JSON.
- Screens must not know API endpoints, headers, database queries, or storage keys.
- The controller calls the repository; the repository communicates with local or remote data sources.

## 13. Helpers, Utilities, and Global Widgets

### `lib/helpers/`

Use for application-level definitions and helpers closely related to the app, including:

- `app_colors.dart`
- `styles.dart`
- `app_constants.dart`
- extensions
- formatters shared throughout the app

### `lib/utils/`

Use for general reusable utilities such as:

- validators
- debouncer
- date helpers
- number helpers
- permission helpers
- file helpers

### `lib/view/base/`

Use only for UI components shared by multiple screens, such as:

```text
app_button.dart
app_text_field.dart
app_loader.dart
app_empty_view.dart
app_error_view.dart
app_dialog.dart
```

Do not place a screen-specific widget in `view/base`.

## 14. Translation Rules

The project contains a `translations` directory, so user-visible text must not be hardcoded when localization is enabled.

Not allowed:

```dart
const Text('People')
```

Required:

```dart
Text(TranslationKeys.people.tr)
```

Add new keys to the translation-key file and provide values for every supported language. Internal logs, enum values, API fields, and developer-only messages do not need translation.

## 15. UI and Reactive-State Rules

1. Keep `build` methods simple and readable.
2. Use `Obx` only around the smallest section that depends on an observable.
3. Do not wrap an entire screen in `Obx` when only one label or list changes.
4. Always design loading, empty, error, and success states when the screen loads data.
5. Use `RefreshIndicator` when refresh is part of the design.
6. Use `SafeArea` where needed.
7. Respect keyboard insets and smaller screens.
8. Avoid fixed sizes that can overflow; use `Expanded`, `Flexible`, `LayoutBuilder`, and constraints appropriately.
9. Do not place calculations, filtering, sorting, validation, or API decisions inside `build`.
10. Do not mutate observable values directly from a complex widget flow when a named controller method can express the action.

Preferred:

```dart
onChanged: controller.onSearchChanged
```

Avoid:

```dart
onChanged: (value) {
  controller.searchText.value = value;
  controller.people.assignAll(
    controller.allPeople.where((item) => item.name.contains(value)),
  );
}
```

## 16. File and Import Rules

1. Use the package name from `pubspec.yaml` for package imports.
2. Avoid long relative imports such as `../../../../helpers/styles.dart`.
3. Keep imports ordered: Dart, Flutter, packages, project files.
4. Remove unused imports.
5. Use one main public class per file.
6. File names must match the class purpose.
7. Do not create duplicate helper, color, style, model, or widget files when an equivalent already exists.
8. Do not manually modify files generated by Flutter, build_runner, localization generation, or asset generation.

## 17. New-Screen Creation Workflow for AI

Whenever asked to create a new screen from scratch, the AI must perform this sequence:

1. Read this `AGENTS.md` file before generating code.
2. Inspect the existing project structure, theme, routes, translations, models, repositories, and base widgets.
3. Convert the screen name to `snake_case` for files/folders and `PascalCase` for classes.
4. Create the feature folder under `lib/view/screens/<screen_name>/`.
5. Create `<screen_name>_screen.dart`.
6. Create `controller/<screen_name>_controller.dart`.
7. Create `binding/<screen_name>_binding.dart` when the screen has a controller.
8. Break each meaningful UI section into a separate file under `widgets/`.
9. Create a separate row/item/tile file for every repeated list or grid item.
10. Use existing `AppColors`, `Styles`, translation keys, assets, and base widgets.
11. Add new reusable styles or colors only to the central helper files.
12. Add or reuse typed models inside `data/models`.
13. Add data-access code inside repositories or services, never in the UI.
14. Register the route in `app_routes.dart` and `app_pages.dart`.
15. Keep all business logic in the controller.
16. Format the generated Dart files.
17. Run `flutter analyze` and fix issues introduced by the new screen.
18. Verify that the code contains no hardcoded colors, repeated text styles, nested widget classes, widget-building helper methods, or API calls in UI files.

## 18. Required Output When AI Creates a Screen

The AI should clearly provide or create:

```text
lib/view/screens/<screen_name>/<screen_name>_screen.dart
lib/view/screens/<screen_name>/controller/<screen_name>_controller.dart
lib/view/screens/<screen_name>/binding/<screen_name>_binding.dart
lib/view/screens/<screen_name>/widgets/<section_widget>.dart
lib/view/screens/<screen_name>/widgets/<list_row_or_item>.dart
```

It must also update, when applicable:

```text
lib/routes/app_routes.dart
lib/routes/app_pages.dart
lib/helpers/app_colors.dart
lib/helpers/styles.dart
lib/translations/translation_keys.dart
lib/translations/...language files...
pubspec.yaml
```

Do not provide only one large screen file when the design contains multiple sections.

## 19. Prohibited Patterns

The following patterns are not allowed:

- Business logic inside a screen or widget
- API calls inside `build`
- Controller creation inside `build`
- Multiple sub-widget classes in the screen file
- `_buildHeader()`, `_buildCard()`, or similar widget-returning helper methods
- Hardcoded color values
- Repeated inline `TextStyle`
- Hardcoded user-visible strings when translations are active
- JSON parsing inside widgets
- Direct database or shared-preference access inside widgets
- A single oversized screen file containing the entire design
- Duplicating a global widget inside a screen folder
- Moving a screen-specific widget into `view/base`
- Editing generated files in `lib/gen`
- Adding dependencies without checking whether the project already contains an equivalent package

## 20. Definition of Done

A new screen is complete only when:

- Naming and folder placement follow this document.
- The screen is stateless.
- The controller extends `GetxController`.
- Business logic is inside the controller.
- Data access is separated through repositories/services.
- Screen sections are split into separate widget files.
- Repeated rows/items have separate files.
- Shared widgets are placed in `view/base`.
- Colors come from `AppColors`.
- Typography comes from `Styles`.
- Assets use the approved asset directories.
- Route and binding are registered.
- User-facing text uses translation keys when localization is enabled.
- Loading, empty, error, and success states are handled when relevant.
- The code is formatted and passes `flutter analyze` without new errors.

## 21. Final Instruction to AI

Follow these rules exactly. Before creating any new file, search the project for an existing equivalent. Preserve the existing architecture and naming. When a requested design conflicts with this document, keep the visual requirement but implement it using this architecture. Do not place convenience code in the screen file merely to reduce the number of files.
