import 'dart:io';
import 'package:flutter/material.dart';
import './widgets/login.dart';
import './widgets/dashboard.dart';
import './controller/auth_controller.dart';

import 'package:get/get.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new PostHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final authController = AuthController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FitnessPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Quicksand'),
      home: FutureBuilder(
          future: authController.tryAutoLogin(),
          builder: (context, authResult) {
            if (authResult.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple)),
              );
            } else {
              if (authResult.data == true) {
                return Dashboard();
              }
              return LoginScreen2(
                backgroundColor1: Color(0xFF444152),
                backgroundColor2: Color(0xFF6f6c7d),
                highlightColor: Colors.deepPurple[400],
                foregroundColor: Colors.white,
                logo: new AssetImage("./assets/images/logo.png"),
              );
            }
          }),
    );
  }
}
