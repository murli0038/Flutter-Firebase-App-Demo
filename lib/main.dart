import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_app/HomePage.dart';
import 'package:firebase_demo_app/LogInPage.dart';
import 'package:firebase_demo_app/SignUpPage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogIn(),
      routes: {
        '/signup': (_) => SignUp(),
        '/home': (_) => HomePage(),
        '/login': (_) => LogIn()
      },
    );
  }
}
