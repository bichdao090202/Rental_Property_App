// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatefulWidget {
//   final TextEditingController? controller;
//   final String label;
//   final String hintText;
//   final TextInputType keyboardType;
//   final bool isPasswordField;
//   final String? Function(String?)? validator;
//   final IconData? prefixIcon;
//   final double? width;
//   final double? height;
//   final String? initialValue;
//
//   CustomTextField(
//       this.controller,
//       this.label, [
//         this.validator,
//         this.prefixIcon,
//         this.initialValue,
//         this.hintText = '',
//         this.isPasswordField = false,
//         this.keyboardType = TextInputType.text,
//         this.width,
//         this.height,
//       ]);
//
//
//   @override
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   bool _obscureText = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width,
//       height: widget.height,
//       child: TextFormField(
//         controller: widget.controller,
//         keyboardType: widget.keyboardType,
//         obscureText: widget.isPasswordField ? _obscureText : false,
//         decoration: InputDecoration(
//           labelText: widget.label,
//           hintText: widget.hintText,
//           border: OutlineInputBorder(),
//           prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
//           suffixIcon: widget.isPasswordField
//               ? IconButton(
//             icon: Icon(
//                 _obscureText ? Icons.visibility : Icons.visibility_off),
//             color: Colors.black,
//             onPressed: () {
//               setState(() {
//                 _obscureText = !_obscureText;
//               });
//             },
//           )
//               : null,
//         ),
//         validator: widget.validator,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final double? width;
  final double? height;
  final String? initialValue;

  CustomTextField(
      this.controller,
      this.label, [
        this.validator,
        this.prefixIcon,
        this.hintText = '',
        this.initialValue,
        this.isPasswordField = false,
        this.keyboardType = TextInputType.text,
        this.width,
        this.height,
      ]) {
    if (initialValue != null && controller != null) {
      controller!.text = initialValue!;
    }
  }

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    if (widget.initialValue != null && _controller!.text.isEmpty) {
      _controller!.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: _controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPasswordField ? _obscureText : false,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          border: OutlineInputBorder(),
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          suffixIcon: widget.isPasswordField
              ? IconButton(
            icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off),
            color: Colors.black,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}