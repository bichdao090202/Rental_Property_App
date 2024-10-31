import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final double width;
  final double? height;
  final Color? backgroundColor;
  final String text;
  final VoidCallback onPressed;

  const ActionButton({super.key,
    required this.width,
    this.height = 34,
    this.backgroundColor,
    required this.text,
    required this.onPressed,
  });

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          maximumSize: const Size(200, 40),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
