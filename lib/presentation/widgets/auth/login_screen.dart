import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/common/widgets/custom_button.dart';
import 'package:rental_property_app/common/widgets/custom_text_field.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';
import 'package:rental_property_app/presentation/widgets/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final phone = _usernameController.text;
      final password = _passwordController.text;

      try {
        await Provider.of<AuthProvider>(context, listen: false).login(phone, password);
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text(e.toString())),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        color: Colors.white,
        // scaffoldMessengerKey: _messangerKey,
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
                    SizedBox(
                      height: screenHeight * 0.4,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(_usernameController,'Username',null,Icons.person, 'Enter your username', "0905015625" ),
                              CustomTextField( _passwordController, 'Password', null, Icons.lock, 'Enter your password', "1231",true),
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
                                        onClick: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (_) => RegisterScreen()));
                                        },
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