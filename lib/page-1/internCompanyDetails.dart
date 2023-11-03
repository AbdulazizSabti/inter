import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class InternshipCompanyDetailsScreen extends StatefulWidget {
  final String title;
  final String details;
  final String location;
  final String username;
  final String? image_url;
  final String? startDate;

  InternshipCompanyDetailsScreen({
    required this.title,
    required this.details,
    required this.location,
    required this.username,
    this.image_url,
    this.startDate,
  });

  @override
  _InternshipCompanyDetailsScreenState createState() =>
      _InternshipCompanyDetailsScreenState();
}

class _InternshipCompanyDetailsScreenState
    extends State<InternshipCompanyDetailsScreen> {
  String? image_url; // Variable to store the image URL
  // Variable to store the username

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
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
                  Image.network(
                    widget.image_url ??
                        'lib/images/tadreby_icon.png', // Use image_url, if available
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Internship title
            Text(
              widget.title, // Access widget properties using widget.
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (widget.startDate != null)
              Text("Program starts on " + widget.startDate!,
                  style: TextStyle(color: Colors.grey[600])),
            if (widget.startDate != null)
              Text("Last day to apply " + widget.startDate!,
                  style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 10),

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
                  widget.details, // Access widget properties using widget.
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Edit button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Edit button action here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 66, 66, 66), // Change the background color
                    onPrimary: Colors.white, // Change the text color
                    padding: EdgeInsets.all(16), // Adjust the button's padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the button's corner radius
                    ),
                  ),
                  child: Text(
                    'Edit internship',
                    style: TextStyle(
                      fontSize: 18, // Adjust the button's text size
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Edit button action here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 66, 66, 66), // Change the background color
                    onPrimary: Colors.white, // Change the text color
                    padding: EdgeInsets.all(16), // Adjust the button's padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust the button's corner radius
                    ),
                  ),
                  child: Text(
                    'Manage applications',
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
