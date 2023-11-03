import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inter/page-1/internshipNewTitle.dart';

class InternshipListNewScreen extends StatefulWidget {
  const InternshipListNewScreen({Key? key}) : super(key: key);

  @override
  _InternshipListNewScreenState createState() =>
      _InternshipListNewScreenState();
}

class _InternshipListNewScreenState extends State<InternshipListNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Internship').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No internship data available');
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final data = document.data() as Map<String, dynamic>;

              return InternshipNewTitle(
                title: data['title'],
                details: data['details'],
                location: data['location'],
                userEmail: data['userEmail'],
              );
            },
          );
        },
      ),
    );
  }
}
