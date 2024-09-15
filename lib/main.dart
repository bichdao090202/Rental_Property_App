import 'package:flutter/material.dart';
import 'package:rental_property_app/widgets/auth/login_screen.dart';
import 'package:rental_property_app/widgets/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental property app',
        theme: ThemeData(
          primaryColor: Colors.white, // Màu chính của ứng dụng
          // hintColor: Colors.orange, // Màu phụ của ứng dụng
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1C3988)),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
            bodySmall: TextStyle(color: Colors.black)
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF1C3988), // Màu cho nút
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1C3988), // Màu nền AppBar
            titleTextStyle: TextStyle(
              color: Colors.white, // Màu chữ trắng
              // fontWeight: FontWeight.bold, // In đậm
              fontSize: 20, // Kích thước chữ
            ),
            iconTheme: IconThemeData(
              color: Colors.white, // Màu icon AppBar
            ),
          ),
        ),
      home: HomeScreen()
    );
  }
}
