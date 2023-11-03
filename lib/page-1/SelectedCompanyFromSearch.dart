import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelecctedCompanyFromSearchPage extends StatefulWidget {
  final String userId;

  const SelecctedCompanyFromSearchPage({Key? key, required this.userId}) : super(key: key);

  @override
  _SelecctedCompanyFromSearchPageState createState() => _SelecctedCompanyFromSearchPageState();
}

class _SelecctedCompanyFromSearchPageState extends State<SelecctedCompanyFromSearchPage> {
  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  String? _profileStatus;
  String imageUrl = "";
  late Widget _displayedImage;

  @override
  void initState() {
    super.initState();
    _displayedImage = Image.asset(
      'lib/images/tadreby_icon.png',
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
    retrieveUserData();
    retrieveUserImage();
  }

  Future<void> retrieveUserData() async {
  String userId = widget.userId;

  // Query the 'users' collection to retrieve the user data based on userId
  QuerySnapshot usersQuery = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userId)
      .get();

  if (usersQuery.docs.isNotEmpty) {
    // Assuming userId is unique, there should be only one matching user
    Map<String, dynamic>? userData = usersQuery.docs.first.data() as Map<String, dynamic>?;
    if (userData != null) {
      setState(() {
        usernameController.text = userData['username'] ?? '';
        descriptionController.text = userData['description'] ?? '';
        locationController.text = userData['location'] ?? '';
        _profileStatus = userData['profile_status'] ?? null;
      });
    }
  }
}



  Future<void> retrieveUserImage() async {
  String userId = widget.userId;

  // Query the 'users' collection to retrieve the user data based on userId
  QuerySnapshot usersQuery = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userId)
      .get();

  if (usersQuery.docs.isNotEmpty) {
    // Assuming userId is unique, there should be only one matching user
    Map<String, dynamic>? userData = usersQuery.docs.first.data() as Map<String, dynamic>?;
    if (userData != null) {
      String imageUrl = userData['image_url'] ?? '';

      if (imageUrl.isNotEmpty) {
        setState(() {
          _displayedImage = ClipOval(
            child: Image.network(
              imageUrl,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          );
        });
      }
    }
  }
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
                  _displayedImage,
                  SizedBox(height: 16.0),
                  Text(
                    usernameController.text,
                    style: TextStyle(
                      fontSize: 31,
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
                          fontSize: 28,
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              descriptionController.text,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
