import 'package:flutter/material.dart';
import 'page-1/Test.dart';
import 'page-1/internshipList.dart';
import 'page-1/Login_page.dart';
import 'page-1/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}
