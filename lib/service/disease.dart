import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/diseasemodel.dart';
import '../models/statusmodel.dart';

List<StatusModel> status = const [
  StatusModel(
    title: 'Go to the nearest Hospital',
    description: 'The symptom you have declared require medical evaluation.',
    imgUrl: 'assets/images/hospital.png',
    mycolor: Colors.orange,
  ),
];

class DiseaseProvider extends ChangeNotifier {
  List<dynamic> diseaseData = [];
  List<dynamic> searchResult = [];

  Future<void> loadDisease() async {
    try {
      final disease = await readJsonData();

      diseaseData = disease;
      searchResult = disease;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading disease: $e');
      }
    }
    notifyListeners();
  }

  Future<List<DiseasesModel>> readJsonData() async {
    final jsondata =
        await rootBundle.loadString('assets/json/allDiseases.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => DiseasesModel.fromJson(e)).toList();
  }

  search(val) {
    if (val == '') {
      searchResult = diseaseData;
    } else {
      searchResult = diseaseData
          .where((element) =>
              element.name.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
