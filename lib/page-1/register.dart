// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inter/components/button.dart';
import 'package:inter/components/textField.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  //text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    var emailController2 = emailController;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              SizedBox(height: 20),

              //logo
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'lib/images/tadreby_icon.png',
                  height: 180.0, // Adjust the height here
                ),
              ),
              SizedBox(height: 20),

              //welcom
              Text(
                'Welcome Seniory!',
                style: TextStyle(
                  color: Color.fromARGB(255, 103, 103, 103),
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 25),
              //Email===========================================================
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),
              //username========================================================
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),
              //password========================================================
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              //ConfirmPassword=================================================
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              //Sign up button==================================================
              MyButton(
                onTap: signUserUp,
              ),
              const SizedBox(height: 50),

              //OR sign up with=================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              //Google Button===================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Google button
                  Image.asset(
                    'lib/images/google.png',
                    height: 65,
                  ),
                ],
              ),

              SizedBox(height: 25),
              //Have an account? Sign in now====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Have an account?'),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      // logic here
                    },
                    child: Text('Log in'),
                  ),
                ],
              )
            ]),
          ),
        )));
  }
}
