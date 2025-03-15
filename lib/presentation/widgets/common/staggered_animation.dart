import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredAnimationWrapper extends StatelessWidget {
  final List<Widget> children;
  final int columnCount;
  final double horizontalOffset;
  final double verticalOffset;
  final Duration duration;
  final bool fromBottom;
  final bool fromLeft;
  final bool staggerDuration;
  final Axis direction;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const StaggeredAnimationWrapper({
    Key? key,
    required this.children,
    this.columnCount = 1,
    this.horizontalOffset = 100.0,
    this.verticalOffset = 50.0,
    this.duration = const Duration(milliseconds: 500),
    this.fromBottom = true,
    this.fromLeft = true,
    this.staggerDuration = true,
    this.direction = Axis.vertical,
    this.scrollController,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return direction == Axis.vertical
        ? _buildVerticalList()
        : _buildHorizontalList();
  }

  Widget _buildVerticalList() {
    return AnimationLimiter(
      child: ListView.builder(
        controller: scrollController,
        physics: physics,
        padding: padding,
        shrinkWrap: shrinkWrap,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: staggerDuration
                ? Duration(milliseconds: duration.inMilliseconds + (index * 100))
                : duration,
            child: SlideAnimation(
              horizontalOffset: fromLeft ? -horizontalOffset : horizontalOffset,
              verticalOffset: fromBottom ? verticalOffset : -verticalOffset,
              child: FadeInAnimation(
                child: children[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalList() {
    return AnimationLimiter(
      child: ListView.builder(
        controller: scrollController,
        physics: physics,
        padding: padding,
        shrinkWrap: shrinkWrap,
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: staggerDuration
                ? Duration(milliseconds: duration.inMilliseconds + (index * 100))
                : duration,
            child: SlideAnimation(
              horizontalOffset: fromLeft ? horizontalOffset : -horizontalOffset,
              child: FadeInAnimation(
                child: children[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StaggeredAnimationGrid extends StatelessWidget {
  final List<Widget> children;
  final int columnCount;
  final double horizontalOffset;
  final double verticalOffset;
  final Duration duration;
  final bool fromBottom;
  final bool fromLeft;
  final bool staggerDuration;
  final double? childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final ScrollController? scrollController;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const StaggeredAnimationGrid({
    Key? key,
    required this.children,
    this.columnCount = 2,
    this.horizontalOffset = 100.0,
    this.verticalOffset = 50.0,
    this.duration = const Duration(milliseconds: 500),
    this.fromBottom = true,
    this.fromLeft = true,
    this.staggerDuration = true,
    this.childAspectRatio,
    this.mainAxisSpacing = 16,
    this.crossAxisSpacing = 16,
    this.scrollController,
    this.shrinkWrap = false,
    this.padding,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        controller: scrollController,
        physics: physics,
        padding: padding,
        shrinkWrap: shrinkWrap,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount,
          childAspectRatio: childAspectRatio ?? 1.0,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        ),
        itemCount: children.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: staggerDuration
                ? Duration(milliseconds: duration.inMilliseconds + (index * 100))
                : duration,
            columnCount: columnCount,
            child: SlideAnimation(
              horizontalOffset: fromLeft ? -horizontalOffset : horizontalOffset,
              verticalOffset: fromBottom ? verticalOffset : -verticalOffset,
              child: FadeInAnimation(
                child: children[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
