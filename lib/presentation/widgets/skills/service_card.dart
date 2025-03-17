import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../common/hover_card.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconPath;
  final List<String> technologies;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.iconPath,
    required this.technologies,
    this.iconBackgroundColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade100
        : const Color(0xFF202020);

    return HoverCard(
      color: bgColor,
      scale: 1.03,
      duration: const Duration(milliseconds: 200),
      showElevation: false,
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: iconBackgroundColor ??
                  AppColors.primary.withAlpha((0.1 * 255).toInt()),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: iconPath.endsWith('.svg')
                  ? SvgPicture.asset(
                      iconPath,
                      width: 40,
                      height: 40,
                      // colorFilter: iconColor != null
                      //     ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                      //     : null,
                    )
                  : Image.asset(
                      iconPath,
                      width: 40,
                      height: 40,
                      color: iconColor,
                    ),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: AppTextStyles.h5,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          // Dotted line
          const Text(
            '.....',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Technologies list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: technologies.map((tech) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tech,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
