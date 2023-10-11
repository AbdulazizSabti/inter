import 'package:flutter/material.dart';
import 'package:inter/models/internship.dart';

import '../page-1/internshipDetailsScreen.dart';

class InternshipTitle extends StatelessWidget {
  Internship internship;
  Function()? onTap;
  InternshipTitle({super.key, required this.internship, required this.onTap});

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
          // internship pic
          Padding(
            padding: EdgeInsets.all(8.0), // Adjust the padding as needed
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                internship.imagePath,
                height: 60, // Adjust the height as needed
                width: 60, // Adjust the width as needed
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // description
          Text(
            internship.description,
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
                    internship.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(internship.location),
                ],
              ),

              // Apply button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          InternshipDetailsScreen(internship: internship),
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
