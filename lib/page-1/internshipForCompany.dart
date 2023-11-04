import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inter/models/internshipData.dart';
import 'package:inter/page-1/internCompanyTitle.dart';

import 'internshipNewTitle.dart';

class CompanyInternshipList extends StatefulWidget {
  final String? userAccountType;

  CompanyInternshipList({this.userAccountType});

  @override
  _CompanyInternshipListState createState() => _CompanyInternshipListState();
}

class _CompanyInternshipListState extends State<CompanyInternshipList> {
  List<InternshipData> internships = [];

  @override
  void initState() {
    super.initState();
    fetchInternships();
  }

  @override
  void dispose() {
    // Cancel any ongoing asynchronous operations, e.g., timers, listeners, etc.
    super.dispose();
  }

  Future<void> fetchInternships() async {
    if (widget.userAccountType == 'Company') {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          final email = userDoc['email'];

          // Fetch internships with matching user email
          FirebaseFirestore.instance
              .collection('Internship')
              .where('userEmail', isEqualTo: email)
              .get()
              .then((internshipQuery) {
            if (mounted) {
              // Check if the widget is still in the tree
              setState(() {
                internships = internshipQuery.docs
                    .map((doc) => InternshipData.fromMap(doc.data()))
                    .toList();
              });
            }
          }).catchError((error) {
            // Handle the error
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Internship List'),
      ),
      body: internships.isEmpty
          ? Center(child: Text('No internships found.'))
          : ListView.builder(
              itemCount: internships.length,
              itemBuilder: (context, index) {
                final internship = internships[index];
                return InternshipCompanyTitle(
                  title: internship.title,
                  details: internship.details,
                  location: internship.location,
                  userEmail: internship.userEmail,
                  internshipID: internship.internshipID,
                  startDate: internship.startDate,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle button press to post a new internship
          // You can navigate to a new screen or show a dialog for posting.
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
