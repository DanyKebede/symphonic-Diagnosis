class FirstAidModel {
  final String name;
  final List overview;
  final List actions;

  const FirstAidModel(
      {required this.name, required this.overview, required this.actions});

  factory FirstAidModel.fromJson(Map<String, dynamic> json) {
    return FirstAidModel(
      name: json['name'],
      overview: json['Overview'] ?? [''],
      actions: json['actions'] ?? [''],
    );
  }
}
