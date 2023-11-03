class InternshipData {
  final String title;
  final String details;
  final String location;
  final String userEmail;
  final String? startDate;

  InternshipData({
    required this.title,
    required this.details,
    required this.location,
    required this.userEmail,
    this.startDate,
  });

  // Define a factory constructor to create an instance from a Map
  factory InternshipData.fromMap(Map<String, dynamic> map) {
    return InternshipData(
      title: map['title'],
      details: map['details'],
      location: map['location'],
      userEmail: map['userEmail'],
      startDate: map['startDate'],
    );
  }
}
