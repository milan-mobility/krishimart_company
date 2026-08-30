enum FromScreen { signup, login, passcode, forgot }

enum UserType { farmer, dealer, company }

enum AppLanguage {
  english('English', 'en'),
  gujarati('Gujarati(ગુજરાતી)', 'gu'),
  hindi('Hindi(हिन्दी)', 'hi');

  const AppLanguage(this.languageName, this.languageCode);

  final String languageName;
  final String languageCode;
}

enum SettingItem {
  enableFingerprint('assets/svg/ic_fingerprint.svg', 'Enable Fingerprint'),
  changeLanguage('assets/svg/ic_change_language.svg', 'Change Language'),
  hotItsWork('assets/svg/ic_how_work.svg', 'How it works?'),
  termAndCondition('assets/svg/ic_term.svg', 'Terms & Conditions'),
  privacyPolicy('assets/svg/ic_privacy.svg', 'Privacy Policy'),
  rateApp('assets/svg/ic_rate.svg', 'Rate App'),
  shareApp('assets/svg/ic_share_app.svg', 'Share App'),
  logout('assets/svg/ic_logout.svg', 'Logout'),
  deleteAccount('assets/svg/ic_delete_account.svg', 'Delete Account');

  const SettingItem(this.icon, this.name);

  final String icon;
  final String name;
}
