import 'package:flutter/material.dart';
import 'package:inter/page-1/Comapny_Home_page.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:inter/page-1/Student_Home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false; // Track password visibility
  final auth =FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool validateEmail(String email) {
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // Email regex pattern
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
   bool validateFields() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ) {
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
    }
    return true;
  }

  Future<void> logIn() async {
    if (validateFields()) {
      try {
        var user = await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (user != null) {
          var userUID = user.user!.uid;
          var userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userUID)
              .get();

          if (userDoc.exists) {
            var accountType = userDoc.data()?['accountType'];

            if (accountType == 'Company') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyHomePage(),
                ),
              );
            } else if (accountType == 'Student') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentHomePage(),
                ),
              );
            }
          }
        }
      } catch (e) {
        // login error handling here
         showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('The password or email is incorrect'),
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
        print(e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'lib/images/tadreby_icon.png',
                  height: 180.0, // Adjust the height here
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'lib/images/googlee.png',
                  height: 180.0, // Adjust the height here
                ),
              ),
              SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                  ElevatedButton(
                    onPressed: logIn ,
                    child : Text('Login'),
                  ), 
                  SizedBox(height: 25),
              //Does not Have an account? Sign in now====================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dose not have an account?'),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      // Navigate to RegisterPage on button press
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    child: Text('Sign up'),
                  ),
                ],
              )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}