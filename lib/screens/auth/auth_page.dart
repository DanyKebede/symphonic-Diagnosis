import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const String routeName = '/authPage';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: SnackBar(
              content: Text(
                'Something goes wrong. Please check your internet connection and try again.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                ),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return const EmailVerifyPage();
        } else {
          return const ToggleLoginSignupPage();
        }
      },
    );
  }
}
