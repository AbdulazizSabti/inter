import 'package:flutter/material.dart';
import 'package:inter/page-1/internshipList.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 2;
  PageController _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Assim AlTayyar',
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
      //Logic Profile
      child: Text('Profile Page'),
    ),
    Center(
      //Logic analyze
      child: Text('Analyze CV'),
    ),
    Center(
      //Logic Home
      child: internshipListPage(),
    ),
    Center(
      //Logic Chat
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
