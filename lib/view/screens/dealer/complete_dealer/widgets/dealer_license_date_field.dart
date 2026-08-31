import 'package:flutter/material.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_profile_text_field.dart';

class DealerLicenseDateField extends StatelessWidget {
  const DealerLicenseDateField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.onDateSelected,
    required this.isExpiryDate,
    this.firstDate,
    this.isReadOnly = false,
    super.key,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<DateTime> onDateSelected;
  final bool isExpiryDate;
  final DateTime? firstDate;
  final bool isReadOnly;

  @override
  Widget build(final BuildContext context) {
    return DealerProfileTextField(
      label: label,
      hintText: hintText,
      controller: controller,
      readOnly: true,
      onTap: isReadOnly ? null : () => _selectDate(context),
      suffixIcon: const Icon(Icons.calendar_today_outlined),
    );
  }

  Future<void> _selectDate(final BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime minimumDate = firstDate ?? DateTime(1900);
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: minimumDate,
      lastDate: DateTime(today.year + 100),
      initialDate: today.isBefore(minimumDate) ? minimumDate : today,
    );
    if (selectedDate != null) {
      onDateSelected(selectedDate);
    }
  }
}
