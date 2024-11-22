import 'package:flutter/material.dart';
import 'package:rental_property_app/common/widgets/custom_button.dart';
import 'package:rental_property_app/common/widgets/custom_text_field.dart';
import 'package:rental_property_app/data/services/api_service.dart';

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   Future<void> handleRegister() async {
//     if (_formKey.currentState!.validate()) {
//       final phone = _phoneController.text;
//       final password = _passwordController.text;
//
//       try {
//         final response = await ApiService().registerUser({
//           "phone": phone,
//           "password": password
//         });
//
//         if (response != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Đăng ký thành công')),
//           );
//           Navigator.pushReplacementNamed(context, '/login');
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Đăng ký thất bại: ${e.toString()}')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: screenHeight * 0.10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Center(
//                 child: Image.asset(
//                   'assets/logo.png',
//                   width: 100,
//                   height: 100,
//                 ),
//               ),
//               const SizedBox(height: 30.0),
//               const Center(
//                 child: Text(
//                   'Đăng Ký',
//                   style: TextStyle(
//                     fontSize: 35.0,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF1C3988),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.4,
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       CustomTextField(
//                           _phoneController,
//                           'Số điện thoại',
//                           null,
//                           Icons.phone,
//                           'Nhập số điện thoại',
//                           "0905015623"
//                       ),
//                       CustomTextField(
//                           _passwordController,
//                           'Mật khẩu',
//                           null,
//                           Icons.lock,
//                           'Nhập mật khẩu',
//                           "1231",
//                           true
//                       ),
//                       CustomButton(
//                         color: const Color(0xFF1C3988),
//                         onClick: handleRegister,
//                         label: 'ĐĂNG KÝ',
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: CustomButton(
//                                 onClick: () => Navigator.pushNamed(context, '/login'),
//                                 label: 'Đã có tài khoản',
//                                 textColor: const Color(0xFF1C3988),
//                                 buttonType: ButtonType.textButton,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _errorMessage;

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }
    // Regex kiểm tra số điện thoại Việt Nam
    final phoneRegex = RegExp(r'^(0[3|5|7|8|9])+([0-9]{8})$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải ít nhất 6 ký tự';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      try {
        final response = await ApiService().registerUser({
          "phone": _phoneController.text,
          "password": _passwordController.text
        });

        if (response != null) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thất bại: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng Ký')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'Đăng Ký',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C3988),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: _validatePhone,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Xác nhận mật khẩu',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: _validateConfirmPassword,
                  ),
                  SizedBox(height: 16),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 16),
                  CustomButton(
                    color: const Color(0xFF1C3988),
                    onClick: _register,
                    label: 'ĐĂNG KÝ',
                  ),
                  // ElevatedButton(
                  //   onPressed: _isLoading ? null : _register,
                  //   child: _isLoading
                  //       ? CircularProgressIndicator()
                  //       : Text('Đăng Ký'),
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
