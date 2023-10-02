import 'package:flutter/material.dart';
import 'package:inter/models/internship.dart';

class InternshipTitle extends StatelessWidget {
  Internship internship;
  InternshipTitle({super.key, required this.internship});

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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(internship.imagePath),
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
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // button to apply
        ],
      ),
    );
  }
}
