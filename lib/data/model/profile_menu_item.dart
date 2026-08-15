import 'package:flutter/material.dart';

enum ProfileMenuAction {
  changeLanguage,
  privacyPolicy,
  termsAndConditions,
  helpAndSupport,
  logout,
  deleteAccount,
}

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.labelKey,
    required this.icon,
    required this.action,
    this.isDestructive = false,
  });

  final String labelKey;
  final IconData icon;
  final ProfileMenuAction action;
  final bool isDestructive;
}
