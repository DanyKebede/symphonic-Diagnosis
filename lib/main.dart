import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:symphonicdiagnosis/firebase_options.dart';
import 'package:symphonicdiagnosis/screens/IntroductionPage/introduction.dart';
import 'service/disease.dart';
import 'service/diseasedescription.dart';
import 'service/doctor.dart';
import 'service/firstaid.dart';
import 'service/symptom.dart';
import 'config/app_router.dart';
import 'repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DiseaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirstAidProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SymptomProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DiseaseDescriptionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersRepository()..init(),
        )
      ],
      child: const MaterialApp(
        title: 'AI-Driven Symphonic Diagnosis',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: IntroductionPage.routeName,
      ),
    );
  }
}
