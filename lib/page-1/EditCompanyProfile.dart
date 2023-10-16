import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditCompanyProfilePage extends StatefulWidget {
  const EditCompanyProfilePage({Key? key});

  @override
  _EditCompanyProfilePageState createState() => _EditCompanyProfilePageState();
}

class _EditCompanyProfilePageState extends State<EditCompanyProfilePage> {
  @override
  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  String? _profileStatus;
  File? _image;
  String imageUrl = "";
  Widget _displayedImage = CircleAvatar(
    radius: 75,
    backgroundColor: Colors.grey, // Background color for the circular avatar
    child: Icon(
      Icons.person, // Placeholder icon or your existing image
      size: 75,
      color: Colors.white,
    ),
  );

  @override
  void initState() {
    super.initState();
    // Retrieve the current user's data from the database
    retrieveUserData();
    retrieveUserImage();
  }

  void dispose() {
    usernameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
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

          String imageUrl = userData['image_url'] ??
              ''; // Assuming the image URL is stored in 'image_url' field

          // Display the image using Image.network
          Widget imageWidget = imageUrl.isNotEmpty
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

          // Assign the image widget to a variable in your UI
          // and display it in the desired location
          // For example, you can use a Container widget:
          Container(
            width: 150,
            height: 150,
            child: imageWidget,
          );
        });
      }
    }
  }

  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Profile Image?'),
          content: Text(
              'Do you want to change your profile image or keep the current one?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _selectNewImage();
              },
              child: Text('Change Image'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // User chose to keep the old image, no need to do anything here
              },
              child: Text('Keep Old Image'),
            ),
          ],
        );
      },
    );
  }

  void _selectNewImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _displayedImage = GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: CircleAvatar(
                    backgroundImage: FileImage(_image!),
                  ),
                ),
              ),
            );
          },
          child: CircleAvatar(
            backgroundImage: FileImage(_image!),
            radius: 75,
          ),
        );
      }
    });
  }

  Future<void> save() async {
    String title = usernameController.text;
    String description = descriptionController.text;
    String location = locationController.text;
    String? userId = FirebaseAuth.instance.currentUser?.uid;

    // Check if title, description, and location are empty
    if (title.isEmpty || description.isEmpty || location.isEmpty) {
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

    if (_image != null) {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(DateTime.now().millisecondsSinceEpoch.toString());
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() => null);
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    }

    // Check if the user document already exists
    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(
        userId); // Replace 'user_id' with the actual user's ID or unique identifier
    DocumentSnapshot userSnapshot = await userRef.get();

    Map<String, dynamic> userData = {
      'username': title,
      'description': description,
      'location': location,
    };

    if (_image != null) {
      userData['image_url'] = imageUrl;
    }

    if (_profileStatus != null) {
      userData['profile_status'] = _profileStatus;
    }

    if (userSnapshot.exists) {
      // Update the user document with the new data
      userRef.update(userData).then((value) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Profile updated successfully.'),
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
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to update profile. Please try again.'),
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
      });
    } else {
      // Create a new user document with the new data
      userRef.set(userData).then((value) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Profile created successfully.'),
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
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to create profile. Please try again.'),
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Display the user image
              _displayedImage,
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Profile status',
                  prefixIcon: Icon(Icons.supervised_user_circle_sharp),
                  border: OutlineInputBorder(),
                ),
                value: _profileStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _profileStatus = newValue;
                  });
                },
                items: <String>[
                  'Ready for inernship',
                  'Not ready for inernship',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'User name',
                  prefixIcon: Icon(Icons.person),
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
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: save,
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
}
