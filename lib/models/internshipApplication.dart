class Application {
  final String name;
  final String email;
  final String imagePath;
  final String? description;
  final String? detail;
  //Location,, Uni,, GPA,,
  String status;

  Application({
    required this.name,
    required this.email,
    required this.imagePath,
    this.description,
    this.detail,
    this.status = 'Pending', // Initial status
  });
}
