import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;
  final BorderRadius? borderRadius;
  final Color? color;
  final Color? hoverColor;
  final bool showElevation;
  final bool showBorder;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final List<BoxShadow>? boxShadow;
  final bool isGradientBackground;
  final List<Color>? gradientColors;
  final AlignmentGeometry? gradientBegin;
  final AlignmentGeometry? gradientEnd;

  const HoverCard({
    Key? key,
    required this.child,
    this.scale = 1.05,
    this.duration = const Duration(milliseconds: 300),
    this.borderRadius,
    this.color,
    this.hoverColor,
    this.showElevation = true,
    this.showBorder = false,
    this.height,
    this.width,
    this.padding,
    this.onTap,
    this.boxShadow,
    this.isGradientBackground = false,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
  }) : super(key: key);

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        widget.borderRadius ?? BorderRadius.circular(16);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: TweenAnimationBuilder(
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          tween: Tween<double>(
            begin: 1.0,
            end: _isHovered ? widget.scale : 1.0,
          ),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                height: widget.height,
                width: widget.width,
                padding: widget.padding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: _isHovered
                      ? widget.hoverColor ?? Theme.of(context).cardTheme.color
                      : widget.color ?? Theme.of(context).cardTheme.color,
                  gradient: widget.isGradientBackground
                      ? LinearGradient(
                          begin: widget.gradientBegin!,
                          end: widget.gradientEnd!,
                          colors: widget.gradientColors ??
                              AppColors.projectGradient,
                        )
                      : null,
                  border: widget.showBorder
                      ? Border.all(
                          color: Theme.of(context).dividerTheme.color!,
                          width: 1,
                        )
                      : null,
                  boxShadow: widget.showElevation
                      ? widget.boxShadow ??
                          [
                            BoxShadow(
                              color: _isHovered
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: _isHovered ? 15 : 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                      : null,
                ),
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
