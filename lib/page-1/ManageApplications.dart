import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'companyAppTitle.dart'; // Import the CompanyAppTitle class

class ManageApplicationsScreen extends StatefulWidget {
  final String internshipID;

  ManageApplicationsScreen({required this.internshipID});

  @override
  _ManageApplicationsScreenState createState() =>
      _ManageApplicationsScreenState();
}

class _ManageApplicationsScreenState extends State<ManageApplicationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Applications'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Internship')
            .doc(widget.internshipID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Internship not found.'));
          }

          final internshipData = snapshot.data!.data() as Map<String, dynamic>;
          final applicationList =
              internshipData['Application'] as List<dynamic>;

          if (applicationList.isEmpty) {
            return Center(child: Text('No applications found.'));
          }

          return ListView.builder(
            itemCount: applicationList.length,
            itemBuilder: (context, index) {
              final applicationData =
                  applicationList[index] as Map<String, dynamic>;
              final String studentEmail = applicationData['studentEmail'];

              // Create a CompanyAppTitle widget and pass studentEmail
              return CompanyAppTitle(
                studentEmail: studentEmail,
                internshipID: widget.internshipID,
              );
            },
          );
        },
      ),
    );
  }
}
