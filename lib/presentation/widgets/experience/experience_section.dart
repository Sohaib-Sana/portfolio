import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/experience_model.dart';
import '../common/section_headers.dart';
import 'timeline_widget.dart';

Widget buildExperienceSection(
  context, {
  Key? key,
  required List<ExperienceModel> experiences,
}) {
  return Container(
    key: key,
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: ResponsiveHelper.getHorizontalPadding(context),
      vertical: 40,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightBackground
          : AppColors.darkBackground.withAlpha((0.3 * 255).toInt()),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildSectionHeader(context, 'Chapters of My Career'),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.getHorizontalPadding(context) * 3),
          child: Text(
            'Since starting my journey as a Flutter developer, I\'ve worked with startup and talented teams, gaining hands-on experience in building impactful, user-centric applications. This has allowed me to sharpen my skills in mobile app development and creating seamless user experiences.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 60),
        TimelineWidget(context, experiences: experiences),
        const SizedBox(height: 40),
      ],
    ),
  );
}
