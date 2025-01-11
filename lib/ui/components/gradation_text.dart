import 'package:flutter/material.dart';

import '../../core/custom_theme.dart';

class GradationText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  // final Color startColor;
  // final Color endColor;

  const GradationText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            ExThemeConfig.color.textGraduationStart,
            ExThemeConfig.color.textGraduationEnd
          ], // グラデーションの色
          begin: Alignment.centerLeft, // グラデーションの開始位置
          end: Alignment.centerRight, // グラデーションの終了位置
        ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height));
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: Colors.white,
        ),
      ),
    );
  }
}
