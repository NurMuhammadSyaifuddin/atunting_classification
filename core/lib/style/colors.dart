
// colors
import 'dart:ui';

import 'package:flutter/material.dart';

const Color kRichBlack = Color(0xFF000814);
const Color firstBlue = Color(0xFF1565C0);
const Color secondBlue = Color(0xFF1976D2);
const Color kMikadoYellow = Color(0xFFffc300);
const Color kDavysGrey = Color(0xFF4B5358);
const Color kGrey = Color(0xFF303030);
const Color thirdBlue = Color(0xFF1E88E5);
const Color fourthBlue = Color(0xFF0D47A1);

const kColorScheme = ColorScheme(
  primary: firstBlue,
  primaryContainer: thirdBlue,
  secondary: secondBlue,
  secondaryContainer: Colors.white,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.red,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);