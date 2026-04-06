import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Responsive helpers: phone vs tablet/desktop, max width for content.
class Responsive {
  static bool isPhone(BuildContext context) {
    return MediaQuery.sizeOf(context).width < AppConstants.breakpointTablet;
  }

  static bool isTabletOrDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= AppConstants.breakpointTablet;
  }

  static double maxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppConstants.breakpointDesktop) {
      return AppConstants.maxContentWidth;
    }
    return width;
  }

  static EdgeInsets screenPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppConstants.breakpointDesktop) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
    if (width >= AppConstants.breakpointTablet) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  }
}
