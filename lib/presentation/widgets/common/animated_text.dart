import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/animated_text_utils.dart';

class AnimatedText extends StatelessWidget {
  final List<String> texts;
  final AnimationType animationType;
  final TextStyle? style;
  final TextAlign textAlign;
  final double? height;

  const AnimatedText({
    Key? key,
    required this.texts,
    this.animationType = AnimationType.typewriter,
    this.style,
    this.textAlign = TextAlign.start,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (animationType) {
      case AnimationType.typewriter:
        return AnimatedTextUtils.buildTypewriterAnimatedText(
          texts: texts,
          style: style,
          textAlign: textAlign,
          textHeight: height,
        );
      case AnimationType.rotate:
        return AnimatedTextUtils.buildRotatingText(
          texts: texts,
          style: style,
          textAlign: textAlign,
        );
      case AnimationType.colorize:
        return AnimatedTextUtils.buildColorizeAnimatedText(
          texts: texts,
          colorizeColors: [
            AppColors.primary,
            AppColors.primaryDark,
            AppColors.primaryLight,
            AppColors.primary,
          ],
          style: style,
          textAlign: textAlign,
        );
      case AnimationType.wavy:
        return AnimatedTextUtils.buildWavyAnimatedText(
          texts: texts,
          style: style,
          textAlign: textAlign,
        );
    }
  }
}

enum AnimationType {
  typewriter,
  rotate,
  colorize,
  wavy,
}
