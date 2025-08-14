import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_project/adhomepade.dart';
import 'package:main_project/birthday.dart';
import 'package:main_project/corporate.dart';
import 'package:main_project/dashboard.dart';
import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyAtnJnKjOrDs9lIEVjs-zDwNURJr34WTm8", appId: "1:98526171172:android:0813edc0b2f48dd94688b1", messagingSenderId: "98526171172", projectId: 'eventplanning-3ad3d')
  ); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}

