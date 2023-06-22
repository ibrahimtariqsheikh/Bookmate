import 'package:book_mate/config/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.buttonColor = AppColors.primary,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.isSubmitting,
    required this.isOutlined,
    this.buttonIcon,
    this.buttonAction,
    this.borderRadius = 11.0,
  }) : super(key: key);

  final String? buttonText;
  final Color buttonColor;
  final double buttonWidth;
  final double buttonHeight;
  final bool isSubmitting;
  final bool isOutlined;
  final Function? buttonAction;
  final IconData? buttonIcon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
final outlineBorderColor = Theme.of(context).colorScheme.tertiary;
final outlineTextColor = Theme.of(context).colorScheme.tertiaryContainer;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton.icon(
        onPressed: () => buttonAction?.call(),
        icon: buttonIcon != null
            ? SizedBox(
                child: Icon(
                  buttonIcon,
                  color: isOutlined ? buttonColor : Colors.white,
                  size: buttonHeight * .3,
                ),
              )
            : const SizedBox(),
        label: !isSubmitting
            ? Text(
                buttonText!,
                style: TextStyle(
                  color: isOutlined ? outlineTextColor : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const CircularProgressIndicator.adaptive(),
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Theme.of(context).scaffoldBackgroundColor
              : buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          side: isOutlined ? BorderSide(color: outlineBorderColor, width: 1) : null,
        ),
      ),
    );
  }
}