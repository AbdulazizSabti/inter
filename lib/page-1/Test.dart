import 'package:flutter/material.dart';

import 'package:inter/models/internship.dart';
import 'package:inter/models/internshipApplication.dart';
import 'package:inter/page-1/Student_Home_page.dart';
import '../components/applicationTitle.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  //int _currentIndex = 2;
  //PageController _pageController = PageController(initialPage: 2);

  void toAppDetailPage() {
    //Method To see the Application Details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Add the navigation action here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentHomePage(), // Replace with the destination screen
                  ),
                );
              },
              child: Container(
                width: 200, // Adjust the width as needed
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  border: Border.all(
                      color: Colors.blue, width: 2), // Border color and width
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Internship List',
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.school,
                      color: Colors.black, // Icon color
                    ),
                  ],
                ),
              ),
            ),
            //Message
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Text(
                'Internship Name',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            //Internship List
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Applications List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
//create an application ========================================================

                  Application application = Application(
                      name: 'Abdulaziz Alsabti',
                      email: 'Abdulaziz@gmail.com',
                      imagePath: 'lib/images/USER_PIC.png',
                      description:
                          'Senior Informations systems student seeking internship, with a passion to learn & growth',
                      detail:
                          "Long text as a 'CV' Long text as a 'CV' Long text as a 'CV' Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV'Long text as a 'CV' ");
                  return ApplicationTitle(
                    application: application,
                    onTap: () => toAppDetailPage(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
