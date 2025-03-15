import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AnimatedTextUtils {
  static Widget buildTypewriterAnimatedText({
    required List<String> texts,
    TextStyle? style,
    int speed = 40,
    double? textHeight,
    TextAlign textAlign = TextAlign.start,
  }) {
    return SizedBox(
      height: textHeight,
      child: AnimatedTextKit(
        animatedTexts: texts.map((text) {
          return TypewriterAnimatedText(
            text,
            textStyle: style ?? AppTextStyles.h3,
            speed: Duration(milliseconds: speed),
            textAlign: textAlign,
          );
        }).toList(),
        repeatForever: true,
        pause: const Duration(seconds: 2),
      ),
    );
  }

  static Widget buildRotatingText({
    required List<String> texts,
    TextStyle? style,
    Duration pause = const Duration(seconds: 3),
    TextAlign textAlign = TextAlign.start,
  }) {
    return AnimatedTextKit(
      animatedTexts: texts.map((text) {
        return RotateAnimatedText(
          text,
          textStyle: style ??
              AppTextStyles.h3.copyWith(
                color: AppColors.primary,
              ),
          alignment: textAlign == TextAlign.center
              ? Alignment.center
              : (textAlign == TextAlign.end
                  ? Alignment.centerRight
                  : Alignment.centerLeft),
        );
      }).toList(),
      repeatForever: true,
      pause: pause,
    );
  }

  static Widget buildColorizeAnimatedText({
    required List<String> texts,
    required List<Color> colorizeColors,
    TextStyle? style,
    Duration duration = const Duration(seconds: 5),
    TextAlign textAlign = TextAlign.start,
  }) {
    return AnimatedTextKit(
      animatedTexts: texts.map((text) {
        return ColorizeAnimatedText(
          text,
          textStyle: style ?? AppTextStyles.h3,
          colors: colorizeColors,
          textAlign: textAlign,
          speed: duration,
        );
      }).toList(),
      repeatForever: true,
    );
  }

  static Widget buildWavyAnimatedText({
    required List<String> texts,
    TextStyle? style,
    Duration speed = const Duration(milliseconds: 200),
    TextAlign textAlign = TextAlign.start,
  }) {
    return AnimatedTextKit(
      animatedTexts: texts.map((text) {
        return WavyAnimatedText(
          text,
          textStyle: style ?? AppTextStyles.h3,
          textAlign: textAlign,
          speed: speed,
        );
      }).toList(),
      repeatForever: true,
      pause: const Duration(seconds: 2),
    );
  }
}
