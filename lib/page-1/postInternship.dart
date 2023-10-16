import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostInternshipPage extends StatefulWidget {
  const PostInternshipPage({Key? key});

  @override
  _PostInternshipPageState createState() => _PostInternshipPageState();
}

class _PostInternshipPageState extends State<PostInternshipPage> {
  @override
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  String? userId;

  int _currentIndex = 2;
  PageController _pageController = PageController(initialPage: 2);
  void initState() {
    super.initState();
    getUserId(); // Call the method to get the user ID
  }

  Future<void> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  Future<void> Save() async {
    String title = titleController.text;
    String description = descriptionController.text;
    String location = locationController.text;

    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        locationController.text.isEmpty ||
        startDate == null ||
        endDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Create a new document reference in the "Internship" collection
    CollectionReference internships =
        FirebaseFirestore.instance.collection('Internship');

    // Add a new document with a generated ID
    internships.add({
      'userId': userId,
      'title': title,
      'description': description,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
    }).then((value) {
      // Document added successfully
      print('Internship saved successfully!');
      // Clear the text fields after saving
      titleController.clear();
      descriptionController.clear();
      locationController.clear();
      setState(() {
        startDate = null;
        endDate = null;
      });
    }).catchError((error) {
      // Error occurred while saving document
      print('Failed to save internship: $error');
    });
  }

  Future<void> selectStartDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) =>
          date.isAfter(DateTime.now().subtract(Duration(days: 1))),
    );

    if (selectedDate != null) {
      setState(() {
        startDate = selectedDate;
      });
    }
  }

  Future<void> selectEndDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: startDate != null
          ? startDate!.add(Duration(days: 1))
          : DateTime.now().add(Duration(days: 1)),
      firstDate: startDate != null
          ? startDate!.add(Duration(days: 1))
          : DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) =>
          date.isAfter(DateTime.now().subtract(Duration(days: 1))),
    );

    if (selectedDate != null) {
      setState(() {
        endDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Tadreby',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        leading: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/images/tadreby_icon.png'),
              radius: 20.0,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Post Internship',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descriptionController,
                maxLines: 7,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: selectStartDate,
                      decoration: InputDecoration(
                        labelText: 'Start Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: startDate != null
                            ? startDate.toString().split(' ')[0]
                            : '',
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: selectEndDate,
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: endDate != null
                            ? endDate.toString().split(' ')[0]
                            : '',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: Save,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 10.0),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement cancel functionality here
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
