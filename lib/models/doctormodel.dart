class DoctorModel {
  final String id;
  final int age;
  final String name;
  final String phone;
  final String speciality;
  final String imgurl;
  final String title;
  final int experiance;
  final double rating;
  final String email;
  final int hours;
  final String? link; // ?

  DoctorModel({
    required this.id,
    required this.age,
    required this.name,
    required this.phone,
    required this.speciality,
    required this.imgurl,
    required this.title,
    required this.email,
    required this.experiance,
    required this.hours,
    required this.rating,
    this.link,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      age: json['age'] as int,
      title: json['title'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      speciality: json['speciality'] as String,
      imgurl: json['image'] != null ? json['image'] as String : '',
      email: json['email'] as String,
      experiance: json['experiance'] as int,
      hours: json['hours'] as int,
      rating: double.parse(json['rating']),
      link: json['link'] != null ? json['link'] as String : '',
    );
  }
}
