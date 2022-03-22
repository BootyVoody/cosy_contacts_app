import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'package:cosy_contacts/internal/style/colors.dart';

final _appColors = _AppColors();

class AppTheme {
  final colors = _appColors;

  static final materialTheme = _appThemeData;

  static AppTheme watch(BuildContext context) => context.watch<AppTheme>();

  static AppTheme read(BuildContext context) => context.read<AppTheme>();
}

final Map<int, Color> _primaryColorShades = {
  50: _appColors.primary.withOpacity(.1),
  100: _appColors.primary.withOpacity(.2),
  200: _appColors.primary.withOpacity(.3),
  300: _appColors.primary.withOpacity(.4),
  400: _appColors.primary.withOpacity(.5),
  500: _appColors.primary.withOpacity(.6),
  600: _appColors.primary.withOpacity(.7),
  700: _appColors.primary.withOpacity(.8),
  800: _appColors.primary.withOpacity(.9),
  900: _appColors.primary,
};

final _appThemeData = ThemeData(
  primarySwatch: MaterialColor(_appColorCode, _primaryColorShades),
);