class PredictedModel {
  final String predictedDisease;
  final double confidenceScore;
  final String speciality;

  PredictedModel(
      {required this.predictedDisease,
      required this.confidenceScore,
      required this.speciality});

  factory PredictedModel.fromJson(Map<String, dynamic> json) {
    return PredictedModel(
      predictedDisease: json['predicteddisease'],
      confidenceScore: double.parse(json['confidencescore']),
      speciality: json['consultdoctor'],
    );
  }
}
