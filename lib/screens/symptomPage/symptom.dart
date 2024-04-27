import 'package:symphonicdiagnosis/screens/symptomPage/addsymptom/addsymptom.dart';

import 'package:flutter/material.dart';

class SymptomPage extends StatelessWidget {
  static const String routeName = '/symptom';

  const SymptomPage({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SymptomPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Disease Prediction",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const AddSymptomPage(),
    );
  }
}
