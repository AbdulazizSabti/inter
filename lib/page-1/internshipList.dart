import 'package:flutter/material.dart';
import 'package:inter/components/internship_title.dart';
import 'package:inter/models/internship.dart';
import 'package:inter/page-1/Test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class internshipListPage extends StatefulWidget {
  const internshipListPage({super.key});

  @override
  _internshipListPageState createState() => _internshipListPageState();
}

class _internshipListPageState extends State<internshipListPage> {
  //int _currentIndex = 2;
  //PageController _pageController = PageController(initialPage: 2);

  void toInternDetailPage() {
    //Method To see the internship Details
  }
  Future<List<DocumentSnapshot>> fetchInternshipDocuments() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Internship').get();

      return querySnapshot.docs; // This returns a List of DocumentSnapshot
    } catch (e) {
      print('Error fetching internship documents: $e');
      return []; // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Search button
            GestureDetector(
              onTap: () {
                // Add the navigation action here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TestPage(),
                  ),
                );
              },
              // ... (the rest of the search button code)
            ),

            SizedBox(
              height: 25,
            ),

            // Internship List
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

            // Internship List (retrieved data)
            Expanded(
              child: FutureBuilder(
                future: fetchInternshipDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> documents =
                          snapshot.data as List<DocumentSnapshot>;
                      // Process the documents here and create InternshipTitle widgets
                      return ListView.builder(
                        itemCount: documents.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              documents[index].data() as Map<String, dynamic>;
                          // Access fields from the document and subcollections as needed

                          // Create an InternshipTitle widget for each document
                          Internship internship = Internship(
                            name: data['name'],
                            location: data['location'],
                            imagePath: 'imagePath',
                            description: data['description'],
                            details: data['details'],
                          );
                          return InternshipTitle(
                            internship: internship,
                            onTap: () => toInternDetailPage(),
                          );
                        },
                      );
                    } else {
                      return Text('No internship data available');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
