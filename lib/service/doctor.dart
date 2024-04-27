import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/doctormodel.dart';

import 'package:flutter/foundation.dart';

const String baseUrl = 'http://10.0.2.2:8000/';

class DoctorProvider extends ChangeNotifier {
  List<dynamic> doctorData = [];
  List<dynamic> searchResult = [];

  Future<void> loadDoctors() async {
    try {
      final doctors = await fetchDoctors();
      doctorData = doctors;
      searchResult = doctors;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading doctors: $e');
      }
    }
    notifyListeners();
  }

  //Get all Doctors

  Future<List<DoctorModel>> fetchDoctors() async {
    final QuerySnapshot doctorData =
        await FirebaseFirestore.instance.collection('Doctors').get();
    return doctorData.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final id = doc.id;
      return DoctorModel.fromJson({...data, 'id': id});
    }).toList();
  }

  search(val) {
    if (val == '') {
      searchResult = doctorData;
    } else {
      searchResult = doctorData
          .where((element) =>
              element.name.toLowerCase().contains(val.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
