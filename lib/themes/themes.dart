
import 'package:coffinder/color_schemes.g.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(useMaterial3: true, colorScheme: lightColorScheme).copyWith(
  appBarTheme: const AppBarTheme(
    elevation: 5
  )
);

final darkTheme = ThemeData(useMaterial3: true, colorScheme: darkColorScheme).copyWith(
  appBarTheme: const AppBarTheme(
    elevation: 5
  )
);