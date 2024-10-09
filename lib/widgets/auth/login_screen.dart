import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rental_property_app/common/widgets/custom_button.dart';
import 'package:rental_property_app/common/widgets/custom_text_field.dart';
import 'package:rental_property_app/widgets/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver  {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();


  // Hàm validator cho username
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Username can only contain letters and numbers';
    }
    return null;
  }

  // Hàm validator cho password
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,}$').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter and one number';
    }
    return null;
  }

  Future<void>  handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');
      return;
    }
    final response = await http.get(Uri.parse('https://653f17299e8bd3be29dfede0.mockapi.io/todos/1'));
    // if (response.statusCode == 200) {
    //   await auth.login(
    //     usernameController.text,
    //     passwordController.text,
    //   );
    // }
    // if (ref.watch(authProvider) != null) {
    //   Navigator.pushReplacementNamed(context, '/home');
    // }
    // SnackBar snackBar = SnackBar(
    //   content: Text('Đăng nhập thành công'),
    //   duration: Duration(seconds: 2),
    // );
    const SnackBar(content: Text('Đăng nhập thành công'), duration: Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        color: Colors.white,
        scaffoldMessengerKey: _messangerKey,
        home: Material(
            color: Colors.white,
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: screenHeight * 0.10),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center content
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        width: 100, // Đặt chiều rộng
                        height: 100, // Đặt chiều cao
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Center(
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C3988),
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.4,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(_usernameController,'Username',_validateUsername,Icons.person, 'Enter your username'),
                              CustomTextField( _passwordController, 'Password', _validatePassword, Icons.lock, 'Enter your password', true),
                              CustomButton(
                                color: const Color(0xFF1C3988),
                                onClick: handleLogin,
                                label: 'ĐĂNG NHẬP',
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CustomButton(
                                        onClick: handleLogin,
                                        label: 'Đăng ký',
                                        textColor: const Color(0xFF1C3988),
                                        buttonType: ButtonType.textButton,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CustomButton(
                                        onClick: handleLogin,
                                        label: 'Quên mật khẩu',
                                        textColor: const Color(0xFF1C3988),
                                        buttonType: ButtonType.textButton,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    )
                  ],
                ),
              )
          )

        )
    );
  }
}
