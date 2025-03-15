import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveHelper {
  static const double mobileMaxWidth = 650;
  static const double tabletMaxWidth = 1100;

  static DeviceType getDeviceType(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double width = MediaQuery.sizeOf(context).width;

    if (width < mobileMaxWidth) {
      return DeviceType.mobile;
    } else if (width < tabletMaxWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  static double getContentMaxWidth(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return MediaQuery.of(context).size.width * 0.9;
      case DeviceType.tablet:
        return 700;
      case DeviceType.desktop:
        return 1200;
    }
  }

  static double getHorizontalPadding(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 16.0;
      case DeviceType.tablet:
        return 32.0;
      case DeviceType.desktop:
        return 48.0;
    }
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    double horizontalPadding = getHorizontalPadding(context);
    return EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: horizontalPadding / 2,
    );
  }

  static double getFontSizeMultiplier(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return 0.85;
      case DeviceType.tablet:
        return 1.0;
      case DeviceType.desktop:
        return 1.1;
    }
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DeviceType deviceType = ResponsiveHelper.getDeviceType(context);

    switch (deviceType) {
      case DeviceType.desktop:
        return desktop ?? (tablet ?? mobile);
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.mobile:
        return mobile;
    }
  }
}
