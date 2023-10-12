import 'package:flutter/material.dart';
import 'package:inter/models/internship.dart';
import 'package:inter/page-1/Test.dart';

import 'internshipList.dart';

class InternshipDetailsScreen extends StatelessWidget {
  final Internship internship;

  InternshipDetailsScreen({Key? key, required this.internship})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/tadreby_icon.png', // Tadreby icon image
              height: 180.0, // Adjust the height as needed
            ),
            SizedBox(height: 5),

            // Internship Image, Name, and Buttons
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Internship Image (Small Size)
                  Image.asset(
                    internship.imagePath,
                    height: 60, // Adjust the size as needed
                  ),

                  // Internship Name
                  Text(
                    internship.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Internship name
                  Text(
                    internship.description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Scrollable Box for Internship Details
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius:
                      BorderRadius.circular(8), // Adjust the radius as needed
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      internship.details,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[800]),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25),

            // Apply and Back Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => internshipListPage(),
                      ),
                    );
                    // Navigate back to the Internship List Page here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 60, 60,
                        60), // Change the button's background color
                    onPrimary: Colors.white, // Change the text color
                    padding: EdgeInsets.all(16), // Adjust the button's padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the button's corner radius
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 18, // Adjust the button's text size
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Apply button action here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 93, 144, 255), // Change the background color
                    onPrimary: Colors.white, // Change the text color
                    padding: EdgeInsets.all(16), // Adjust the button's padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the button's corner radius
                    ),
                  ),
                  child: Text(
                    'Apply Now',
                    style: TextStyle(
                      fontSize: 18, // Adjust the button's text size
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
