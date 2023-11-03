import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/userData.dart';
import 'internshipNewDetailsScreen.dart';

class InternshipNewTitle extends StatelessWidget {
  final String title;
  final String details;
  final String location;
  final String userEmail;
  final String? startDate;

  InternshipNewTitle({
    required this.title,
    required this.details,
    required this.location,
    required this.userEmail,
    this.startDate,
  });

  Future<Map<String, dynamic>> retrieveUserData() async {
    if (userEmail != null) {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDataMap = userQuery.docs.first.data() as Map<String, dynamic>;
        print("Retrieved username: ${userDataMap['username']}");
        final String username = userDataMap['username'];
        final String image_url = userDataMap['image_url'];
        return {
          'username': username,
          'image_url': image_url,
        };
      }
    }
    return {
      'username': null,
      'image_url': null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: retrieveUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is still loading, return a loading indicator if needed
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Handle error
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!;
          final username = data['username'];
          final image_url = data['image_url'];

          return Container(
            margin: EdgeInsets.all(15),
            width: 280,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Internship pic
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: FadeInImage(
                      placeholder: AssetImage(
                          'lib/images/tadreby_icon.png'), // Use a default image
                      image: NetworkImage(image_url ??
                          ''), // Use image_url, or the default image if it's null
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                // Description
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                // Name & Location
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (username != null)
                            Text(
                              username!, // Use username, if available
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(location),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (startDate != null)
                            Text("Program starts on " + startDate!,
                                style: TextStyle(color: Colors.grey[600])),
                          if (startDate != null)
                            Text("Last day to apply " + startDate!,
                                style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                      // Apply button
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InternshipNewDetailsScreen(
                                title: title,
                                details: details,
                                location: location,
                                username: username,
                                startDate: startDate,
                                image_url: image_url,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(215, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Icon(
                            Icons.double_arrow,
                            color: Colors.white,
                          ),
                        ),
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
}
