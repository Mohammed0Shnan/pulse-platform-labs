import 'package:flutter/material.dart';
import 'package:pulsenow_flutter/core/constants/app_colors.dart';

class InkWellWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? splashColor;

  const InkWellWidget({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.padding,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.zero,
        splashColor: splashColor ?? AppColors.splashColor,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: child,
        ),
      ),
    );
  }
}
