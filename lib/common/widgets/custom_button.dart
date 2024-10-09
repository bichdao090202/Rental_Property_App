import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.label,
    this.color,
    required this.onClick,
    this.iconData,
    this.textColor,
    this.borderRadius = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
    this.buttonType = ButtonType.elevated,
    this.notificationCount,
    this.radius = 48.0,
    this.height,
    this.width,
  });

  final String? label;
  final IconData? iconData;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Function onClick;
  final ButtonType buttonType;
  final int? notificationCount;
  final double radius;
  final double? height;
  final double? width;

  Widget _buildButtonContent() {
    if (iconData != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, color: textColor ?? Colors.white),
          const SizedBox(width: 8),
          Text(
            label ?? '',
            style: TextStyle(color: textColor ?? Colors.white),
          ),
        ],
      );
    } else {
      return Text(
        // label?.toUpperCase() ?? '',
        label??'',
        style: TextStyle(color: textColor ?? Colors.white),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevated:
        return _buildElevatedButton(context);
      case ButtonType.outlined:
        return _buildOutlinedButton(context);
      case ButtonType.textButton:
        return _buildTextButton(context);
      case ButtonType.circular:
        return _buildCircularButton();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 50), // Set width and height
        padding: padding,
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onClick as void Function()?,
      child: _buildButtonContent(),
    );
  }


  Widget _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width ?? double.infinity, height ?? 50), // Set width and height
        padding: padding,
        side: BorderSide(color: color ?? Theme.of(context).primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onClick as void Function()?,
      child: _buildButtonContent(),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: padding,
        backgroundColor: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onClick as void Function()?,
      child: _buildButtonContent(),
    );
  }


  Widget _buildCircularButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Ink(
          width: radius,
          height: radius,
          decoration: ShapeDecoration(
            color: color ?? Colors.transparent,
            shape: const CircleBorder(),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: radius / 2,
            iconSize: radius / 2,
            icon: Icon(iconData, color: textColor ?? Colors.white),
            splashColor: textColor?.withOpacity(.4),
            onPressed: onClick as void Function()?,
          ),
        ),
        if (notificationCount != null) ...[
          Positioned(
            top: radius / -14,
            right: radius / -14,
            child: Container(
              width: radius / 2.2,
              height: radius / 2.2,
              decoration: const ShapeDecoration(
                color: Colors.red,
                shape: CircleBorder(),
              ),
              child: Center(
                child: Text(
                  notificationCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: radius / 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

enum ButtonType {
  elevated,
  outlined,
  circular,
  textButton,
}
