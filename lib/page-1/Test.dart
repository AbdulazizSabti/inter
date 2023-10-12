import 'package:flutter/material.dart';
import 'package:inter/components/internship_title.dart';
import 'package:inter/models/internship.dart';
import 'package:inter/models/internshipApplication.dart';
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
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'lib/images/tadreby_icon.png',
                height: 180.0, // Adjust the height here
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ],
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

            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
              child: Divider(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
