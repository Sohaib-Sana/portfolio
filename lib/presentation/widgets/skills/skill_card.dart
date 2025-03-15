import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../common/hover_card.dart';

class SkillCard extends StatelessWidget {
  final String name;
  final String icon;
  final double proficiency;
  final bool isFramework;

  const SkillCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.proficiency,
    this.isFramework = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      scale: 1.05,
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Image.asset(
            icon,
            width: 48,
            height: 48,
          ),

          const SizedBox(height: 16),

          // Skill name
          Text(
            name,
            style: AppTextStyles.h5,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Framework/Language indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isFramework
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              isFramework ? 'Framework' : 'Language',
              style: AppTextStyles.caption.copyWith(
                color: isFramework ? AppColors.primary : Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Proficiency indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Proficiency',
                    style: AppTextStyles.bodySmall,
                  ),
                  Text(
                    '${(proficiency * 100).toInt()}%',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  // Background progress bar
                  Container(
                    width: double.infinity,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),

                  // Foreground progress bar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    width: double.infinity * proficiency,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _getColorForProficiency(proficiency),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColorForProficiency(double proficiency) {
    if (proficiency >= 0.8) {
      return Colors.green;
    } else if (proficiency >= 0.6) {
      return Colors.amber;
    } else if (proficiency >= 0.4) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

class SkillModel {
  final String name;
  final String icon;
  final double proficiency;
  final bool isFramework;

  SkillModel({
    required this.name,
    required this.icon,
    required this.proficiency,
    this.isFramework = false,
  });

  static List<SkillModel> getDummySkills() {
    return [
      SkillModel(
        name: 'Flutter',
        icon: 'assets/icons/flutter.png',
        proficiency: 0.9,
        isFramework: true,
      ),
      SkillModel(
        name: 'Dart',
        icon: 'assets/icons/dart.png',
        proficiency: 0.85,
      ),
      SkillModel(
        name: 'Firebase',
        icon: 'assets/icons/firebase.png',
        proficiency: 0.8,
        isFramework: true,
      ),
      SkillModel(
        name: 'RESTful APIs',
        icon: 'assets/icons/api.png',
        proficiency: 0.75,
      ),
      SkillModel(
        name: 'Git',
        icon: 'assets/icons/git.png',
        proficiency: 0.7,
      ),
      SkillModel(
        name: 'State Management',
        icon: 'assets/icons/state.png',
        proficiency: 0.85,
      ),
      SkillModel(
        name: 'UI/UX Design',
        icon: 'assets/icons/ui.png',
        proficiency: 0.75,
      ),
      SkillModel(
        name: 'Responsive Design',
        icon: 'assets/icons/responsive.png',
        proficiency: 0.8,
      ),
    ];
  }
}
