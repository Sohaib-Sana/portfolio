import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
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
  final ScrollController _scrollController = ScrollController();
  final List<bool> _visibleItems = [];

  @override
  void initState() {
    super.initState();

    // Initialize all items as not visible
    _visibleItems
        .addAll(List.generate(widget.experiences.length, (_) => false));

    // Add scroll listener to animate items as they come into view
    _scrollController.addListener(_checkVisibility);

    // Start initial animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _animateInitialItems();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    // This would typically use visibility detection for a more accurate approach
    // Here we're keeping it simple with a time-based approach
  }

  void _animateInitialItems() {
    // Animate first two items (or all if less than 3)
    final int count =
        widget.experiences.length < 3 ? widget.experiences.length : 2;

    for (int i = 0; i < count; i++) {
      setState(() {
        _visibleItems[i] = true;
      });
    }

    // Schedule the remaining items to appear with delays
    for (int i = count; i < widget.experiences.length; i++) {
      Future.delayed(Duration(milliseconds: 500 + (i * 300)), () {
        if (mounted) {
          setState(() {
            _visibleItems[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Years of experience text
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
                style: isMobile
                    ? AppTextStyles.h4.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      )
                    : AppTextStyles.h3.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 48),

        // Timeline
        Padding(
          padding: EdgeInsets.only(left: isMobile ? 0 : 24),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.experiences.length,
            itemBuilder: (context, index) {
              final experience = widget.experiences[index];
              final isLast = index == widget.experiences.length - 1;
              log('$experience', name: 'Experience ');

              return ExperienceCard(
                experience: experience,
                isLast: isLast,
                index: index,
                animate: _visibleItems[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
