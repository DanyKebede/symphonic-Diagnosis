import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/diseasedescriptionmodel.dart';

class DiseaseDescriptionProvider extends ChangeNotifier {
  List<dynamic> diseaseDescription = [];

  Future<void> loadDiseaseDescription() async {
    try {
      final data = await readJsonData();
      diseaseDescription = data;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading Diseasedescription: $e');
      }
    }
    notifyListeners();
  }

  Future<List<DiseaseDescriptionModel>> readJsonData() async {
    final jsondata =
        await rootBundle.loadString('assets/json/diseasedescription.json');

    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => DiseaseDescriptionModel.fromJson(e)).toList();
  }
}
