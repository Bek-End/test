import 'package:flutter/material.dart';
import 'package:local_test/core/constants/app_colors.dart';
import 'package:local_test/core/constants/app_text_styles.dart';

class Button extends StatelessWidget {
  const Button.text({
    super.key,
    required this.text,
    required this.onTap,
    this.isExpanded = true,
    this.hasShadow = true,
    this.hasBorder = true,
    this.disabled = false,
    this.child,
    this.style,
    this.bgColor,
    this.borderColor,
    this.padding,
    this.margin,
  });

  const Button.child({
    super.key,
    required this.child,
    required this.onTap,
    this.isExpanded = true,
    this.hasShadow = true,
    this.hasBorder = true,
    this.disabled = false,
    this.text,
    this.style,
    this.bgColor,
    this.borderColor,
    this.padding,
    this.margin,
  });

  final VoidCallback? onTap;
  final bool isExpanded;
  final bool hasShadow;
  final bool hasBorder;
  final bool disabled;
  final Widget? child;
  final String? text;
  final TextStyle? style;
  final Color? bgColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  EdgeInsetsGeometry get getPadding =>
      padding ??
      EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: isExpanded ? 16.0 : 24.0,
      );

  BoxBorder? get getBorder => hasBorder
      ? Border.all(width: 2.0, color: borderColor ?? AppColors.black)
      : null;

  List<BoxShadow> get getShadow => [
        if (hasShadow)
          BoxShadow(
            color: borderColor ?? AppColors.black,
            offset: const Offset(0.0, 8.0),
          ),
      ];

  Widget get getChild {
    final textChild = Text(text ?? '',
        style: style ??
            (disabled ? AppTextStyles.s20w600Grey : AppTextStyles.s20w600));
    return isExpanded ? Center(child: child ?? textChild) : child ?? textChild;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        width: isExpanded ? double.infinity : null,
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8.0),
        padding: getPadding,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.white,
          border: getBorder,
          borderRadius: BorderRadius.circular(3659.95),
          boxShadow: getShadow,
        ),
        child: getChild,
      ),
    );
  }
}
