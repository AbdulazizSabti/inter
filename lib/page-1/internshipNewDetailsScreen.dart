import 'package:flutter/material.dart';

class InternshipNewDetailsScreen extends StatelessWidget {
  final String name;
  final String description;
  final String details;
  final String location;
  final String imagePath;

  InternshipNewDetailsScreen({
    required this.name,
    required this.description,
    required this.details,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Internship image and name
            Center(
              child: Column(
                children: [
                  Image.asset(
                    imagePath,
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Internship description
            Text(
              description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            // Internship details (scrollable)
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              color: Colors.grey[200],

              height: 450, // Set the maximum height of the details section
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, // Make it scroll vertically
                child: Text(
                  details,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Apply button
            ElevatedButton(
              onPressed: () {
                // Handle Accept button action here
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 3, 132, 91), // Change the background color
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
      ),
    );
  }
}
