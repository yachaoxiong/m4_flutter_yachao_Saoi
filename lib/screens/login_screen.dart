import 'dart:convert';

import 'package:clinic_flutter_p1/screens/home_screen.dart';
import 'package:clinic_flutter_p1/screens/register_screen.dart';
import 'package:clinic_flutter_p1/widget/button_primary.dart';
import 'package:clinic_flutter_p1/widget/app_input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/login'),
        body: {
          'username': _usernameController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );
      print('response: ${response.statusCode == 200}');
      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];

        // Store the token using shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (error) {
      print('error: $error');
      setState(() {
        _errorMessage = 'An error occurred, please try again';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/register.png',
                width: 300,
                height: 300,
              ),
              AppInput(
                hintText: 'Username',
                controller: _usernameController,
              ),
              AppInput(
                hintText: 'Password',
                isPassword: true,
                controller: _passwordController,
              ),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ButtonPrimary(
                text: _isLoading ? 'Logging in...' : 'Login',
                onTap: _isLoading ? null : _login,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
