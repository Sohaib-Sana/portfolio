import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  final double showOffset;
  final Duration animationDuration;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double elevation;

  const ScrollToTopButton({
    Key? key,
    required this.scrollController,
    this.showOffset = 300,
    this.animationDuration = const Duration(milliseconds: 300),
    this.backgroundColor,
    this.iconColor,
    this.size = 50,
    this.elevation = 2,
  }) : super(key: key);

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final offset = widget.scrollController.offset;
    final showButton = offset >= widget.showOffset;

    if (_showButton != showButton) {
      setState(() {
        _showButton = showButton;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _showButton ? 1.0 : 0.0,
      duration: widget.animationDuration,
      child: AnimatedScale(
        scale: _showButton ? 1.0 : 0.0,
        duration: widget.animationDuration,
        child: FloatingActionButton(
          onPressed: _showButton ? _scrollToTop : null,
          backgroundColor: widget.backgroundColor ?? AppColors.primary,
          foregroundColor: widget.iconColor ?? Colors.white,
          elevation: widget.elevation,
          mini: widget.size < 40,
          child: const Icon(Icons.arrow_upward),
        ),
      ),
    );
  }
}
