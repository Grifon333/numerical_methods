import 'package:flutter/material.dart';
import 'package:numerical_methods/Theme/app_colors.dart';

class AppTextStyle {
  static const title = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 24,
      color: AppColors.title,
      shadows: [
        Shadow(
          offset: Offset(-1, -1),
          color: Colors.black,
        ),
        Shadow(
          offset: Offset(1, -1),
          color: Colors.black,
        ),
        Shadow(
          offset: Offset(-1, 1),
          color: Colors.black,
        ),
        Shadow(
          offset: Offset(1, 1),
          color: Colors.black,
        )
      ]
  );
  static const labaLabel = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}