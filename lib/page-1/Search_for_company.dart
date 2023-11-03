import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inter/page-1/SelectedCompanyFromSearch.dart';
import 'package:inter/page-1/ViewCompnyProfile.dart';

class SearchForCompany extends StatefulWidget {
  const SearchForCompany({Key? key}) : super(key: key);

  @override
  _SearchForCompanyState createState() => _SearchForCompanyState();
}

class _SearchForCompanyState extends State<SearchForCompany> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String name = "";

  void searchFromFirebase(String query) async {
  final result = await FirebaseFirestore.instance
      .collection('users')
      .where('username', isGreaterThanOrEqualTo: query)
      .get();

  setState(() {
    name = query;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
            ),
            onChanged: (query) {
              searchFromFirebase(query);
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
         stream: FirebaseFirestore.instance.collection('users').where('accountType', isEqualTo: 'Company').snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshots.hasError) {
            // Handle error state here
            return Center(child: Text('Error: ${snapshots.error}'));
          } else {
            final userss = snapshots.data!.docs;

            return ListView.builder(
              itemCount: userss.length,
              itemBuilder: (context, index) {
                final users = userss[index].data() as Map<String, dynamic>;
                final usersName = users['username'].toString();
                final imageUrl = users['image_url'] as String?;

                if (name.isEmpty ||
                    usersName.toLowerCase().contains(name.toLowerCase())) {
                  return ListTile(
                    leading: Image(
                      image: imageUrl != null && imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl) as ImageProvider<Object>
                      : AssetImage('lib/images/tadreby_icon.png') as ImageProvider<Object>,
                       width: 100, // Set the desired width
                       height: 100, // Set the desired height
                                                ),
                    title: Text(
                      usersName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      String? userId = users["email"];
                      if (userId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelecctedCompanyFromSearchPage(userId: userId),
                          ),
                        );
                      }
                    },
                  );
                }

                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
