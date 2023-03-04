import 'package:clinic_flutter_p1/screens/login_screen.dart';
import 'package:clinic_flutter_p1/screens/register_screen.dart';
import 'package:clinic_flutter_p1/theme.dart';
import 'package:clinic_flutter_p1/widget/button_primary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// login or home page

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: whiteColor,
        ),
        home: LoginScreen()
        // home: LoginScreen()
        );
  }
}
