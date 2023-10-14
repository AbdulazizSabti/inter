import 'package:flutter/material.dart';
import 'package:inter/page-1/Test.dart';
import 'package:inter/page-1/internshipList.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({Key? key});

  @override
  _CompanyHomePageState createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  int _currentIndex = 2;
  PageController _pageController = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 76, 34, 202),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tadreby',
            style: TextStyle(
              fontSize: 17,
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
            icon: Icon(Icons.post_add),
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
      child: Text('Profile Page'),
    ),
    Center(
        //Logic internship
        // child: internshipListPage(),
        ),
    Center(
        //Logic Home
        // child: TestPage(),
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
