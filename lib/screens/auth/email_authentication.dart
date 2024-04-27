import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  static const String routeName = '/emailVerification';

  const EmailVerificationPage({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const EmailVerificationPage(),
    );
  }

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late Timer _timer;
  bool isButtonDisabled = true;
  int countdown = 120;

  void disableButtonFor2Minutes() {
    setState(() {
      isButtonDisabled = true;
      countdown = 120;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        countdown -= 1;

        if (countdown <= 0) {
          timer.cancel();
          isButtonDisabled = false;
        }
      });
    });
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        countdown -= 1;

        if (countdown <= 0) {
          timer.cancel();
          isButtonDisabled = false;
        }
      });
    });
  }

  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo/shopping.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 30),
              const Text(
                'Verify your email address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.email.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please go to your email and click on the link we sent to verify your email address.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(112, 79, 56, 1),
                      fixedSize: Size(size.width * 0.7, 50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: isButtonDisabled
                        ? null
                        : () async {
                            try {
                              await user.sendEmailVerification();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Password reset link sent',
                                  ),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } on FirebaseException catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    e.code.toString(),
                                  ),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }

                            // Disable the button again
                            disableButtonFor2Minutes();
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 102, 100, 100),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Resend Email',
                          style: TextStyle(
                            color: Color.fromARGB(255, 102, 100, 100),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${countdown ~/ 60}:${(countdown % 60).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 71, 70, 70),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(size.width * 0.7, 50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color.fromRGBO(112, 79, 56, 1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/authPage', (route) => false);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color.fromARGB(255, 71, 70, 70),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
