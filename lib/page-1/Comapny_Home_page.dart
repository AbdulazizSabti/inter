import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inter/page-1/EditCompanyProfile.dart';
import 'package:inter/page-1/Test.dart';
import 'package:inter/page-1/ViewCompnyProfile.dart';
import 'package:inter/page-1/postInternship.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({Key? key});

  @override
  _CompanyHomePageState createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  int _currentIndex = 2;
  PageController _pageController = PageController(initialPage: 2);
  User? _user;
  String? _username;
  String? _userImageUrl;

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
          _userImageUrl = userSnapshot['image_url'];
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
              backgroundImage: _userImageUrl != null
                  ? NetworkImage(
                      _userImageUrl!) // Use NetworkImage if URL is available
                  : AssetImage('lib/images/tadreby_icon.png')
                      as ImageProvider, // Use AssetImage as fallback
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
            label: 'Internship',
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
      //Logic profile
      child: ViewCompanyProfilePage(),
    ),
    Center(
      //Logic internship
      child: PostInternshipPage(),
    ),
    Center(
      //Logic Home
      child: TestPage(),
    ),
    Center(
      //Logic chat
      child: Text('Chat Page'),
    ),
    Center(
      //Logic Search
      child: Text('Search Page'),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
