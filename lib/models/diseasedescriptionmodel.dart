class DiseaseDescriptionModel {
  final String name;
  final String description;

  const DiseaseDescriptionModel(
      {required this.name, required this.description});

  factory DiseaseDescriptionModel.fromJson(Map<String, dynamic> json) {
    return DiseaseDescriptionModel(
      name: json['name'],
      description: json['description'],
    );
  }
}
