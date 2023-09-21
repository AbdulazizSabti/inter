// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SafeArea(
          child: Center(
            child: Column(children: [
              SizedBox(height: 50),

              //logo
              Icon(
                Icons.school_rounded,
                size: 100,
              ),
              SizedBox(height: 50),

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 130, 130, 130))),
                    fillColor: Color.fromARGB(165, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),

              SizedBox(height: 25),
              //username========================================================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    fillColor: Color.fromARGB(165, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 25),
              //password========================================================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    fillColor: Color.fromARGB(165, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 25),
              //ConfirmPassword=================================================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    fillColor: Color.fromARGB(165, 255, 255, 255),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 25),
              //Sign up button

              //OR sign up with

              //Google Button

              //Have an account? Sign in now
            ]),
          ),
        ));
  }
}
