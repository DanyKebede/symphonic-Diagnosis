enum Strength {
  high,
  medium,
  low,
}

class DiseaseModel {
  final String title;
  final String type;
  final String description;
  final Strength level;

  const DiseaseModel({
    required this.level,
    required this.type,
    required this.title,
    required this.description,
  });
}

class DiseasesModel {
  final String name;
  final String link;
  final List symptoms;
  final List overview;
  final List causes;
  final List riskFactors;
  final List diagnosis;

  const DiseasesModel({
    required this.name,
    required this.link,
    required this.symptoms,
    required this.overview,
    required this.causes,
    required this.diagnosis,
    required this.riskFactors,
  });

  factory DiseasesModel.fromJson(Map<String, dynamic> json) {
    return DiseasesModel(
      name: json['name'],
      link: json['link'],
      symptoms: json['Symptoms'],
      overview: json['Overview'],
      causes: json['Causes'],
      riskFactors: json['Risk factors'],
      diagnosis: json['diagnosis'],
    );
  }
}
