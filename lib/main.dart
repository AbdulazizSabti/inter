import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inter/firebase_options.dart';
import 'package:inter/models/userData.dart';
import 'package:inter/page-1/internshipNewScreen.dart';
import 'package:provider/provider.dart';
import 'page-1/Comapny_Home_page.dart';
import 'page-1/Student_Home_page.dart';
import 'page-1/Login_page.dart';
import 'page-1/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserData>(create: (_) => UserData()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
