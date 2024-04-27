import 'package:flutter/material.dart';
import 'package:symphonicdiagnosis/models/predictedmodel.dart';
import 'package:symphonicdiagnosis/navigation_widget.dart';
import 'package:symphonicdiagnosis/screens/doctor/doctor_list.dart';
import 'package:symphonicdiagnosis/screens/result/doctorpage.dart';

import '../screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case IntroductionPage.routeName:
        return IntroductionPage.route();
      case AuthPage.routeName:
        return AuthPage.route();
      case Navigation.routeName:
        return Navigation.route();
      case SymptomPage.routeName:
        return SymptomPage.route();
      case SearchSymptoms.routeName:
        return SearchSymptoms.route();
      case ResultPage.routeName:
        return ResultPage.route();
      case DiseaseDetailPage.routeName:
        return DiseaseDetailPage.route(settings.arguments);
      case FistAidDetailPage.routeName:
        return FistAidDetailPage.route(settings.arguments);
      case ForgetPasswordPage.routeName:
        return ForgetPasswordPage.route();
      case DoctorPage.routeName:
        return DoctorPage.route(settings.arguments as String);
      case DoctorList.routeName:
        return DoctorList.route();
      case ShowDetailPage.routeName:
        return ShowDetailPage.route(settings.arguments as PredictedModel);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Page Not Found',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/authPage', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(112, 79, 56, 1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
