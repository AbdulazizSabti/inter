import 'package:flutter/material.dart';
import 'package:inter/page-1/internshipNewDetailsScreen.dart';

class InternshipNewTitle extends StatelessWidget {
  final String name;
  final String description;
  final String details;
  final String location;
  final String imagePath;
  final String? startDate;

  InternshipNewTitle({
    required this.name,
    required this.description,
    required this.details,
    required this.location,
    required this.imagePath,
    this.startDate,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset(
                imagePath,
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
            description,
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
                    // Internship name
                    Text(
                      name,
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
                    // if null dont show the text
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
                          name: name,
                          description: description,
                          details: details,
                          location: location,
                          imagePath: imagePath,
                          startDate: startDate,
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
}
