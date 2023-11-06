import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class InternshipNewDetailsScreen extends StatefulWidget {
  final String title;
  final String details;
  final String location;
  final String username;
  final String internshipID;
  final String? image_url;
  final DateTime? startDate;

  InternshipNewDetailsScreen({
    required this.title,
    required this.details,
    required this.location,
    required this.username,
    required this.internshipID,
    this.image_url,
    this.startDate,
  });

  @override
  _InternshipNewDetailsScreenState createState() =>
      _InternshipNewDetailsScreenState();
}

class _InternshipNewDetailsScreenState
    extends State<InternshipNewDetailsScreen> {
  String? image_url;

  // Declare variables to store student information
  String? studentEmail;
  String? studentName;

// Confirmation message function
  void showConfirmationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Application submitted successfully'),
        duration: Duration(seconds: 3), // You can adjust the duration as needed
      ),
    );
  }

  //Function
  void showRejectingSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have applied to this internship already'),
        duration: Duration(seconds: 3), // You can adjust the duration as needed
      ),
    );
  }

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
            Center(
              child: Column(
                children: [
                  Image.network(
                    widget.image_url ?? 'lib/images/tadreby_icon.png',
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
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (widget.startDate != null)
              Text(
                'Start Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.startDate!)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            if (widget.startDate != null)
              Text(
                'Start Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.startDate!)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            SizedBox(height: 10),
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 450,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  widget.details,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle Accept button action here
                submitApplication();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 3, 132, 91),
                onPrimary: Colors.white,
                padding: EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Apply Now',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitApplication() async {
    // Get the current user (student) from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, retrieve the student's information from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        // Student data found, extract the required information
        final String studentName = userSnapshot['username'];
        final String studentEmail = userSnapshot['email'];

        // Now you have the student's name and email for the application
        // You can proceed to generate an application ID and create an application object.
        if (studentName != null && studentEmail != null) {
          String appID = Uuid().v4();
          Map<String, dynamic> application = {
            'appID': appID,
            'studentName': studentName,
            'studentEmail': studentEmail,
            'appStatus': 'pending',
            'summary': '',
            'CV': '',
          };

          // Get the ID of the current internship
          String internshipID = widget.internshipID;

// Query the specific internship document to check if the student's email exists in the "Application" array
          DocumentSnapshot internshipSnapshot = await FirebaseFirestore.instance
              .collection('Internship')
              .doc(internshipID)
              .get();

          if (internshipSnapshot.exists) {
            Map<String, dynamic>? data =
                internshipSnapshot.data() as Map<String, dynamic>?;

            if (data != null) {
              List<dynamic>? applications = data['Application'];
              if (applications is List &&
                  applications
                      .any((app) => app['studentEmail'] == studentEmail)) {
                // The student has already applied for this internship
                showRejectingSnackbar(context);
                print('Student has already applied for this internship');
                // You can display an error message here or handle it as needed
              } else {
                // The student has not applied for this internship
                await FirebaseFirestore.instance
                    .collection('Internship')
                    .doc(internshipID)
                    .update({
                  'Application': FieldValue.arrayUnion([application])
                }).then((value) {
                  // Application added successfully
                  showConfirmationSnackbar(context);
                  print('Application submitted successfully');
                }).catchError((error) {
                  // Handle error if application submission fails
                  print('Error submitting application: $error');
                });
              }
            } else {
              // Handle the case where data is null
              print('Internship data is null');
            }
          } else {
            // Handle the case where the internship document doesn't exist
            print('Internship document not found');
          }
        } else {
          // Handle the case where studentName or studentEmail is not available
          print('Student information is missing');
        }
      } else {
        // User's data not found in Firestore
        print('Student data not found in Firestore');
      }
    } else {
      // User is not authenticated
      print('User is not authenticated.');
    }
  }
}
