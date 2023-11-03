import 'package:flutter/material.dart';
import 'package:inter/models/internshipApplication.dart';
import 'package:inter/page-1/ApplicationDetailsScreen.dart';

class ApplicationTitle extends StatelessWidget {
  Application application;
  Function()? onTap;
  ApplicationTitle({super.key, required this.application, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // pic of the User profile============================================
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust the padding as needed
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                application.imagePath,
                height: 100, // Adjust the height as needed
                width: 100, // Adjust the width as needed
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // description
          Text(
            application.description,
            style: TextStyle(color: Colors.grey[600]),
          ),
          // details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // intership name
                  Text(
                    application.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(application.email),
                ],
              ),

              // Apply button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ApplicationDetailsScreen(application: application),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
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
        ],
      ),
    );
  }
}
