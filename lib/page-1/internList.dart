import 'package:flutter/material.dart';
import 'package:inter/components/internship_title.dart';
import 'package:inter/models/internship.dart';
import 'package:inter/page-1/Test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class internListPage extends StatefulWidget {
  const internListPage({super.key});

  @override
  _internListPageState createState() => _internListPageState();
}

class _internListPageState extends State<internListPage> {
  //int _currentIndex = 2;
  //PageController _pageController = PageController(initialPage: 2);

  void toInternDetailPage() {
    //Method To see the internship Details
  }
  Future<List<DocumentSnapshot>> fetchInternshipDocuments() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('internship').get();

      return querySnapshot.docs; // This returns a List of DocumentSnapshot
    } catch (e) {
      print('Error fetching internship documents: $e');
      return []; // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Search
            GestureDetector(
              onTap: () {
                // Add the navigation action here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        TestPage(), // Replace with the destination screen
                  ),
                );
              },
              child: Container(
                width: 200, // Adjust the width as needed
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Background color
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                  border: Border.all(
                      color: Colors.blue, width: 2), // Border color and width
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'My applications',
                      style: TextStyle(
                        color: Colors.black, // Text color
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.school_rounded,
                      color: Colors.black, // Icon color
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            //Internship List
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Internship List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
// create an internship=========================================================
                  Internship internship = Internship(
                      name: 'Microsoft',
                      location: 'Riyadh',
                      imagePath: 'lib/images/microsoft.png',
                      description:
                          'Technology specialist, Internship opportunities',
                      details:
                          "Come build community, explore your passions and do your best work at Microsoft with thousands of University graduates from every corner of the world. This opportunity will allow you to bring your aspirations, talent, potential—and excitement for the journey ahead.At Microsoft, Interns work on real-world projects in collaboration with teams across the world, while having fun along the way. You’ll be empowered to build community, explore your passions and achieve your goals. This is your chance to bring your solutions and ideas to life while working on cutting-edge technology.Microsoft’s mission is to empower every person and every organization on the planet to achieve more. As employees we come together with a growth mindset, innovate to empower others, and collaborate to realize our shared goals. Each day we build on our values of respect, integrity, and accountability to create a culture of inclusion where everyone can thrive at work and beyond.The Cloud Solution Architect provides technical expertise through sales presentations, product demonstrations, installation and maintenance of company products. Assists the sales staff in assessing potential application of company products to meet customer needs and preparing detailed product specifications for the development and implementation of customer applications/solutions.Responsibilities Program Start Date: February 2024, Riyadh Length: 9 months, Full TimeResponsibilities: Applies foundational technical knowledge of an architecture solution to meet business and information technology (IT) requirements and resolve identified technical constraints. Microsoft is an equal opportunity employer. Consistent with applicable law, all qualified applicants will receive consideration for employment without regard to age, ancestry, citizenship, color, family or medical care leave, gender identity or expression, genetic information, immigration status, marital status, medical condition, national origin, physical or mental disability, political affiliation, protected veteran or military status, race, ethnicity, religion, sex (including pregnancy), sexual orientation, or any other characteristic protected by applicable local laws, regulations and ordinances. If you need assistance and/or a reasonable accommodation due to a disability during the application process read more about requesting accommodations");
                  return InternshipTitle(
                    internship: internship,
                    onTap: () => toInternDetailPage(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
