import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rental_property_app/widgets/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Material(
      color: Colors.white,

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: screenHeight * 0.17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch widgets
            children: [
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
              SizedBox(height: 50.0),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.teal), // Border color on focus
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: Icon(Icons.visibility_off), // Password visibility icon
                  focusedBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF1C3988)),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 16.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                  ),
                ),
                child:  const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          // Handle sign up logic
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF1C3988),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password logic
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF1C3988),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}
