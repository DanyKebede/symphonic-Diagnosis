import 'package:flutter/material.dart';

import '../screens.dart';

class ToggleLoginSignupPage extends StatefulWidget {
  const ToggleLoginSignupPage({super.key});

  @override
  State<ToggleLoginSignupPage> createState() => _ToggleLoginSignupPageState();
}

class _ToggleLoginSignupPageState extends State<ToggleLoginSignupPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(
          onClickSignup: toggle,
        )
      : SingupPage(
          onClickSignin: toggle,
        );

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
