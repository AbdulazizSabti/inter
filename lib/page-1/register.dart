import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:inter/page-1/Student_Home_page.dart';
import 'dart:ui';
import 'Login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inter/components/button.dart';
import 'package:inter/components/textField.dart';
import 'package:inter/page-1/Comapny_Home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _passwordVisible = false; // Track password visibility
  bool _confirmPasswordVisible = false; // Track confirm password visibility
  String? _accountType;
  bool validateEmail(String email) {
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool validateFields() {
    if (_accountType == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select an account type.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (!validateEmail(emailController.text)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a valid email address.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (passwordController.text.length < 6) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('The password must be at least 6 characters long.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('The passwords do not match.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  Future<void> signUp() async {
    if (validateFields()) {
      try {
        var userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var userUID = userCredential.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(userUID).set({
          'email': emailController.text,
          'username': usernameController.text,
          'accountType': _accountType,
        });
        if (_accountType == 'Student') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentHomePage(),
            ),
          );
        } else if (_accountType == 'Company') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompanyHomePage(),
            ),
          );
        }

        // Registration success logic here
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('The email is already in use'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        // Registration error handling here
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var emailController2 = emailController;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(16.0),
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
                  // Account type dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Account Type',
                      border: OutlineInputBorder(),
                    ),
                    value: _accountType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _accountType = newValue;
                      });
                    },
                    items: <String>[
                      'Student',
                      'Company',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
                    obscureText:
                        !_passwordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  TextField(
                    controller: confirmPasswordController,

                    obscureText:
                        !_confirmPasswordVisible, // Toggle password visibility
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  const SizedBox(height: 10),
                  //Sign up button==================================================
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: signUp,
                    child: Text('Sign up'),
                  ),

                  //Have an account? Sign in now====================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Have an account?'),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          // Navigate to RegisterPage on button press
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
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
