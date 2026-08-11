import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_mart/gen/assets.gen.dart';
import 'package:krishi_mart/view/screens/user_role/widgets/role_benefit_item.dart';

class RoleBenefitsSection extends StatelessWidget {
  const RoleBenefitsSection({super.key});

  @override
  Widget build(final BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RoleBenefitItem(
          icon: SvgPicture.asset(Assets.svg.icTrust),
          title: 'Trusted',
          description: '100% Original Products',
        ),
        RoleBenefitItem(
          icon: SvgPicture.asset(Assets.svg.icQuality),
          title: 'Quality',
          description: 'Best Quality Assurance',
        ),
        RoleBenefitItem(
          icon: Image.asset(Assets.png.icSupport.path, fit: BoxFit.contain),
          title: 'Support',
          description: '24/7 Dealer Support',
        ),
      ],
    );
  }
}
