class UsersModel {
  final String title;
  final String id;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String description;

  UsersModel({
    required this.title,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.description,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      title: json['title'] as String,
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

  static UsersModel empty() {
    return UsersModel(
        title: '',
        id: '',
        firstName: '',
        lastName: '',
        imageUrl: '',
        description: '');
  }
}
