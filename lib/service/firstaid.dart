import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/firstaidmodel.dart';

class FirstAidProvider extends ChangeNotifier {
  List<dynamic> firstAidData = [];
  List<dynamic> searchResult = [];

  Future<void> loadFirstAid() async {
    try {
      final firstAid = await readJsonData();
      firstAidData = firstAid;
      searchResult = firstAid;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading firstAid: $e');
      }
    }
    notifyListeners();
  }

  Future<List<FirstAidModel>> readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/json/FirstAid.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => FirstAidModel.fromJson(e)).toList();
  }

  search(val) {
    if (val == '') {
      searchResult = firstAidData;
    } else {
      searchResult = firstAidData
          .where((element) =>
              element.name.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
