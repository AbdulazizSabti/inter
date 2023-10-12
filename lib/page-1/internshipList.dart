import 'package:flutter/material.dart';
import 'package:inter/components/internship_title.dart';
import 'package:inter/models/internship.dart';

class internshipListPage extends StatefulWidget {
  const internshipListPage({super.key});

  @override
  _internshipListPageState createState() => _internshipListPageState();
}

class _internshipListPageState extends State<internshipListPage> {
  //int _currentIndex = 2;
  //PageController _pageController = PageController(initialPage: 2);

  void toInternDetailPage() {
    //Method To see the internship Details
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'lib/images/tadreby_icon.png',
                height: 180.0, // Adjust the height here
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            //Message
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Text(
                'Cool message',
                style: TextStyle(color: Colors.grey[600]),
              ),
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

            Padding(
              padding:
                  EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
              child: Divider(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
