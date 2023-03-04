import 'dart:convert';

import 'package:clinic_flutter_p1/widget/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/app_input.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _register() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match.';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/register'),
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': 'doctor'
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print("Registration successful");
        // Registration successful, navigate to the login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Registration failed. Please try again later.';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //image
              Image.asset(
                'assets/register.png',
                width: 300,
                height: 300,
              ),
              // username
              AppInput(
                hintText: 'Username',
                controller: _usernameController,
              ),
              // email
              AppInput(
                hintText: 'Email',
                controller: _emailController,
              ),
              // password
              AppInput(
                hintText: 'Password',
                isPassword: true,
                controller: _passwordController,
              ),
              // confirm password
              AppInput(
                hintText: 'Confirm Password',
                isPassword: true,
                controller: _confirmPasswordController,
              ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              // button
              ButtonPrimary(
                text: 'Register',
                onTap: _register,
              ),
              // back to login text button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
