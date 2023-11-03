import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inter/page-1/EditCompanyProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inter/page-1/Search_for_inernship.dart';
import 'package:inter/page-1/Test.dart';
import 'package:inter/page-1/internshipNewScreen.dart';

import 'Search_for_company.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 2;
  PageController _pageController = PageController(initialPage: 2);
  User? _user;
  String? _username;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _user = currentUser;
      });
      // Fetch the user's data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      if (userSnapshot.exists) {
        setState(() {
          _username = userSnapshot['username'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // User logged in, show home page
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _username ??
                'Loading...', // Show 'Loading...' if username is not fetched yet
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        leading: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/images/tadreby_icon.png'),
              radius: 20.0,
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Analyze CV',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    Center(
      // Logic Profile
      child: Text('Profile Page'),
    ),
    Center(
      // Logic analyze
      child: TestPage(),
    ),
    Center(
      // Logic Home
      child: InternshipListNewScreen(),
    ),
    Center(
      // Logic Chat
      child: SearchForCompany(),
    ),
    Center(
      // Logic Search
      child: SearchForInternship(),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
