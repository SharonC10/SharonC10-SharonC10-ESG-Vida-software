import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/view/Profile/pages/main/page.dart';
import 'package:ESGVida/view/Profile/pages/settings/page.dart';
import 'package:flutter/material.dart';

class ProfilePageEnum {
  final String label;
  final Widget Function() builder;

  const ProfilePageEnum._({
    required this.label,
    required this.builder,
  });

  static final MAIN = ProfilePageEnum._(
    label: LanguageGlobalVar.Profile,
    builder: () => const MainPage(),
  );
  static final SETTINGS = ProfilePageEnum._(
    label: LanguageGlobalVar.MY_SETTINGS,
    builder: () => const SettingsPage(),
  );
}
