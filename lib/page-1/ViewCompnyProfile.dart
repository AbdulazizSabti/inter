import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:inter/page-1/EditCompanyProfile.dart';

class ViewCompanyProfilePage extends StatefulWidget {
  const ViewCompanyProfilePage({Key? key}) : super(key: key);

  @override
  _ViewCompanyProfilePageState createState() => _ViewCompanyProfilePageState();
}

class _ViewCompanyProfilePageState extends State<ViewCompanyProfilePage> {
  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  String? _profileStatus;
  File? _image;
  String imageUrl = "";
  late Widget _displayedImage;

  @override
  void initState() {
    super.initState();
    _displayedImage = Image.asset(
      'lib/images/tadreby_icon.png',
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
    retrieveUserImage();
    retrieveUserData();
  }

  Future<void> retrieveUserImage() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      // User is not authenticated or logged in
      return;
    }

    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    DocumentSnapshot<Object?> userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        String imageUrl = userData['image_url'] ?? '';

        setState(() {
          // Update the image URL and display the image
          imageUrl = userData['image_url'] ?? '';
          _displayedImage = imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'lib/images/tadreby_icon.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                );
        });
      }
    }
  }

  Future<void> retrieveUserData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      // User is not authenticated or logged in
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('User not authenticated.'),
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

    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    DocumentSnapshot<Object?> userSnapshot = await userRef.get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        setState(() {
          // Set the retrieved data to the text fields and dropdown button
          usernameController.text = userData['username'] ?? '';
          descriptionController.text = userData['description'] ?? '';
          locationController.text = userData['location'] ?? '';
          _profileStatus = userData['profile_status'] ?? null;
        });
      }
    }
  }

  void _editProfile() {
    // Navigate to the edit profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCompanyProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Center(
              child: Column(
                children: [
                  _displayedImage ?? Container(),
                  SizedBox(height: 16.0),
                  Text(
                    usernameController.text,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.blue),
                      SizedBox(width: 8.0),
                      Text(
                        locationController.text,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.description, size: 18, color: Colors.blue),
                SizedBox(width: 8.0),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              descriptionController.text,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity, // Make Edit Profile button wider
              child: ElevatedButton(
                onPressed: _editProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit, size: 18),
                    SizedBox(width: 8.0),
                    Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
