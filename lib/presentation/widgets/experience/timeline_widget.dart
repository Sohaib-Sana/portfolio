import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/sections.dart';
import '../../../core/utils/responsive_helper.dart';
import '../../../data/models/experience_model.dart';
import 'experience_card.dart';

class TimelineWidget extends StatefulWidget {
  final List<ExperienceModel> experiences;

  const TimelineWidget(
    context, {
    Key? key,
    required this.experiences,
  }) : super(key: key);

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late List<bool> _visibleItems;

  @override
  void initState() {
    super.initState();
    _visibleItems = List<bool>.filled(widget.experiences.length, false);
  }

  @override
  void didUpdateWidget(covariant TimelineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.experiences.length != widget.experiences.length) {
      _visibleItems = List<bool>.filled(widget.experiences.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: EdgeInsets.only(left: isMobile ? 0 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'More than 2 years',
                style: isMobile ? AppTextStyles.h4 : AppTextStyles.h3,
              ),
              const SizedBox(height: 8),
              Text(
                'experience as a',
                style: isMobile ? AppTextStyles.h4 : AppTextStyles.h3,
              ),
              const SizedBox(height: 4),
              Text(
                'Flutter Developer',
                style:
                    (isMobile ? AppTextStyles.h4 : AppTextStyles.h3).copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 48),

        // Timeline cards
        Padding(
          padding: EdgeInsets.only(left: isMobile ? 0 : 24),
          child: Column(
            children: List.generate(widget.experiences.length, (index) {
              final experience = widget.experiences[index];
              final isLast = index == widget.experiences.length - 1;

              return VisibilityDetector(
                  key: Key('${AppSections.Experience}-$index'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.5 && !_visibleItems[index]) {
                      setState(() {
                        _visibleItems[index] = true;
                      });
                    }
                  },
                  child: AnimatedSlide(
                    offset: _visibleItems[index]
                        ? Offset.zero
                        : const Offset(0, 0.2),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    child: AnimatedOpacity(
                      opacity: _visibleItems[index] ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 600),
                      child: ExperienceCard(
                        experience: experience,
                        isLast: isLast,
                      ),
                    ),
                  ));
            }),
          ),
        ),
      ],
    );
  }
}
