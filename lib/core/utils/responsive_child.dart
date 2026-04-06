import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Wraps content with max width and centering for desktop.
class ResponsiveChild extends StatelessWidget {
  const ResponsiveChild({
    super.key,
    required this.child,
    this.maxWidth,
  });

  final Widget child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final max = maxWidth ?? AppConstants.maxContentWidth;
    if (width > max) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: max),
          child: child,
        ),
      );
    }
    return child;
  }
}
