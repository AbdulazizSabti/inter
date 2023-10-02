import 'package:flutter/material.dart';
import 'package:inter/components/internship_title.dart';
import 'package:inter/models/internship.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
                'Cool message',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),

            //Internship List
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Internship List',
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
                  // create an internship=====================================
                  Internship internship = Internship(
                      name: 'IBM',
                      location: 'Riyadh',
                      imagePath: 'lib/images/ibm.png',
                      description: 'Cool chance');
                  return InternshipTitle(
                    internship: internship,
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
