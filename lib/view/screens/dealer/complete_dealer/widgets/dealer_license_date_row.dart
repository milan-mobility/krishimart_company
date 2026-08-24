import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:krishi_mart/helpers/app_responsive.dart';
import 'package:krishi_mart/view/screens/dealer/complete_dealer/widgets/dealer_license_date_field.dart';

class DealerLicenseDateRow extends StatelessWidget {
  const DealerLicenseDateRow({
    required this.issueDateController,
    required this.expireDateController,
    required this.onIssueDateSelected,
    required this.onExpireDateSelected,
    required this.issueDate,
    super.key,
  });

  final TextEditingController issueDateController;
  final TextEditingController expireDateController;
  final ValueChanged<DateTime> onIssueDateSelected;
  final ValueChanged<DateTime> onExpireDateSelected;
  final DateTime? issueDate;

  @override
  Widget build(final BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: DealerLicenseDateField(
            label: 'Issue Date',
            hintText: 'Select issue date',
            controller: issueDateController,
            onDateSelected: onIssueDateSelected,
            isExpiryDate: false,
          ),
        ),
        Gap(AppResponsive.value(12, tablet: 16)),
        Expanded(
          child: DealerLicenseDateField(
            label: 'Expire Date',
            hintText: 'Select expire date',
            controller: expireDateController,
            onDateSelected: onExpireDateSelected,
            isExpiryDate: true,
            firstDate: issueDate?.add(const Duration(days: 1)),
          ),
        ),
      ],
    );
  }
}
