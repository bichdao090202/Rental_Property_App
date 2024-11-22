import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/providers/auth_provider.dart';
import 'package:rental_property_app/presentation/providers/manager_contract_provider.dart';
import 'package:rental_property_app/presentation/providers/room_provider.dart';
import 'package:rental_property_app/presentation/widgets/auth/login_screen.dart';
import 'package:rental_property_app/presentation/widgets/home/home_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// class DefaultFirebaseOptions {
//   static final String _platform = defaultTargetPlatform == TargetPlatform.android
//       ? 'android'
//       : defaultTargetPlatform == TargetPlatform.iOS
//       ? 'ios'
//       : 'web';
//
//   static FirebaseOptions get currentPlatform {
//     if (_platform == 'web') {
//       return const FirebaseOptions(
//           apiKey: "AIzaSyCQnHfFJcbN8BkJQkqf1RiGp5XMAtemjxs",
//           authDomain: "rental-room-app-cf629.firebaseapp.com",
//           projectId: "rental-room-app-cf629",
//           storageBucket: "rental-room-app-cf629.appspot.com",
//           messagingSenderId: "1080683981377",
//           appId: "1:1080683981377:web:ecec5d5c891c7e258074c0",
//           measurementId: "G-PEG5PR9C3H"
//       );
//     } else {
//       throw UnsupportedError('FirebaseOptions not configured for platform $_platform.');
//     }
//   }
// }


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(
      // const MyApp()
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => RoomProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => ManagerContractProvider(ApiService()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Rental property app',
        theme: ThemeData(
          primaryColor: Color(0xFF1C3988),
          // primaryColor: Colors.white, // Màu chính của ứng dụng
          // hintColor: Colors.orange, // Màu phụ của ứng dụng
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1C3988),
            primary: const Color(0xFF1C3988),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
            bodySmall: TextStyle(color: Colors.black)
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFF1C3988),
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
      home:
      LoginScreen(),
      // HomeScreen(),
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => LoginScreen(),

      },
    );
  }
}
