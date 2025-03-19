import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/experience_model.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;
  final int index;
  final bool animate;

  const ExperienceCard({
    Key? key,
    required this.experience,
    this.isLast = false,
    required this.index,
    this.animate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildAnimatedCard();
  }

  Widget _buildAnimatedCard() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500 + (index * 300)),
      opacity: animate ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: Duration(milliseconds: 500 + (index * 300)),
        offset: animate ? Offset.zero : const Offset(0, 0.5),
        curve: Curves.easeOutQuart,
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline dot and line
        _buildTimelineDot(),

        const SizedBox(width: 16),

        // Card content
        Expanded(
          child: _buildCardContent(),
        ),
      ],
    );
  }

  Widget _buildTimelineDot() {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
        ),
        if (!isLast)
          Container(
            width: 2,
            height: 130,
            color: AppColors.primary.withOpacity(0.3),
          ),
      ],
    );
  }

  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.position,
          style: AppTextStyles.h5,
        ),
        const SizedBox(height: 8),
        Text(
          experience.company,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              experience.duration,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            if (experience.employmentType != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  experience.employmentType!,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (experience.certificate != null || experience.coverLetter != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Wrap(
              spacing: 8,
              children: [
                if (experience.certificate != null)
                  _buildActionLink(experience.certificate!, 'Certificate'),
                if (experience.coverLetter != null)
                  _buildActionLink(experience.coverLetter!, 'Cover Letter'),
              ],
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildActionLink(String text, String label) {
    return InkWell(
      onTap: () {
        // Handle action
      },
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
