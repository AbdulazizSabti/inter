import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyAppTitle extends StatelessWidget {
  final String studentEmail;
  final String internshipID;

  CompanyAppTitle({
    required this.studentEmail,
    required this.internshipID,
  });

  Future<Map<String, dynamic>> retrieveUserData() async {
    if (studentEmail != null) {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: studentEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDataMap = userQuery.docs.first.data() as Map<String, dynamic>;
        final String studentName = userDataMap['username'];
        final String image_url = userDataMap['image_url'];
        return {
          'username': studentName,
          'image_url': image_url,
        };
      }
    }
    return {
      'username': null,
      'image_url': null,
    };
  }

  Future<String> retrieveSummery() async {
    try {
      final internshipDoc = await FirebaseFirestore.instance
          .collection('Internship')
          .doc(internshipID)
          .get();

      if (internshipDoc.exists) {
        final applicationList = internshipDoc.data()?['Application'];
        if (applicationList != null && applicationList is List) {
          for (var application in applicationList) {
            if (application['studentEmail'] == studentEmail) {
              return application['summery'];
            }
          }
        }
      }
    } catch (error) {
      print('Error retrieving summery: $error');
    }
    return ''; // Return an empty string if summery is not found.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: retrieveSummery(),
      builder: (context, summarySnapshot) {
        if (summarySnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (summarySnapshot.hasError) {
          return Text('Error: ${summarySnapshot.error}');
        } else {
          final String summary = summarySnapshot.data ?? '';

          return FutureBuilder<Map<String, dynamic>>(
            future: retrieveUserData(),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (userSnapshot.hasError) {
                return Text('Error: ${userSnapshot.error}');
              } else {
                final Map<String, dynamic>? userData = userSnapshot.data;

                if (userData == null) {
                  return Text('User data not found.');
                }

                final String? studentName = userData['username'];
                final String image_url = userData['image_url'] ?? '';

                return Container(
                  margin: EdgeInsets.all(15),
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Student pic
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('lib/images/tadreby_icon.png'),
                            image: NetworkImage(image_url),
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Summary
                      Text(
                        summary,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      // Student name and email
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (studentName != null)
                                  Text(
                                    studentName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(studentEmail),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
