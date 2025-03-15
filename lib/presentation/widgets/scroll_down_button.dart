import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ScrollDownButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double size;
  final Color? color;
  final Duration animationDuration;

  const ScrollDownButton({
    Key? key,
    required this.onPressed,
    this.size = 50.0,
    this.color,
    this.animationDuration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<ScrollDownButton> createState() => _ScrollDownButtonState();
}

class _ScrollDownButtonState extends State<ScrollDownButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? AppColors.primary;

    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceAnimation.value),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(widget.size / 2),
            child: Container(
              height: widget.size,
              width: widget.size,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: color,
                  size: widget.size * 0.6,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
