import 'package:flutter/material.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.grey.shade300,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
          primary: Colors.orange,
          secondary: Colors.tealAccent.shade700,
          brightness: Brightness.dark,
        )
        .copyWith(background: Colors.grey.shade300),
  );

  final darkTheme = ThemeData.dark().copyWith(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.teal.shade500,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
          primary: Colors.orange,
          secondary: Colors.tealAccent,
          brightness: Brightness.light,
        )
        .copyWith(background: Colors.grey.shade800),
  );
}
