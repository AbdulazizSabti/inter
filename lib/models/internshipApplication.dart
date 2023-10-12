class Application {
  final String name;
  final String email;
  final String imagePath;
  final String description;
  final String detail;
  String status;

  Application({
    required this.name,
    required this.email,
    required this.imagePath,
    required this.description,
    required this.detail,
    this.status = 'Pending', // Initial status
  });
}
