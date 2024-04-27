import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:symphonicdiagnosis/widget/cutom_text_form_field.dart';

import '../../models/usersmodel.dart';
import '../../repository/user_repository.dart';
import '../../service/auth_service.dart';

class SingupPage extends StatefulWidget {
  final VoidCallback onClickSignin;
  const SingupPage({super.key, required this.onClickSignin});
  static const String routeName = '/signup';

  static Route route(VoidCallback onClickSignin) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SingupPage(
        onClickSignin: onClickSignin,
      ),
    );
  }

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final descriptionController = TextEditingController();
  String? _title = 'Mr';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Center(
                  child: Text(
                    "Fill your information below or register with your social account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 32, 32, 32),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Title',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _title,
                  onChanged: (selectedvalue) {
                    setState(() {
                      _title = selectedvalue;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'Mr',
                      child: Text('Mr'),
                    ),
                    DropdownMenuItem(
                      value: 'Ms',
                      child: Text('Ms'),
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: 'Select Your Title',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(139, 139, 139, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(112, 79, 56, 1),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(112, 79, 56, 1),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value ?? '';
                  },
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'First Name',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                    tcontroller: firstNameController,
                    icon: Icons.person,
                    hintText: "Enter your first name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    }),
                const SizedBox(height: 12.0),
                const Text(
                  'Last Name',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                    tcontroller: lastNameController,
                    icon: Icons.person,
                    hintText: "Enter your last name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    }),
                const SizedBox(height: 12.0),
                const Text(
                  'Description',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                    tcontroller: descriptionController,
                    icon: Icons.description,
                    hintText: "Write some description here",
                    validator: (value) {
                      return null;
                    }),
                const SizedBox(height: 12.0),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                    tcontroller: emailController,
                    icon: Icons.email,
                    hintText: "Your email address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }),
                const SizedBox(height: 12.0),
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 17.0),
                      child: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(204, 204, 204, 1),
                        size: 32,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromRGBO(139, 139, 139, 1),
                          size: 27,
                        ),
                      ),
                    ),
                    hintText: 'Enter Your password',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(139, 139, 139, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(112, 79, 56, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(112, 79, 56, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(112, 79, 56, 1)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 7) {
                      return 'Password must have at least 7 characters';
                    }
                    return null;
                  },
                  controller: passwordController,
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 17.0),
                      child: Icon(
                        Icons.lock,
                        color: Color.fromRGBO(204, 204, 204, 1),
                        size: 32,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromRGBO(139, 139, 139, 1),
                          size: 27,
                        ),
                      ),
                    ),
                    hintText: 'Please Confirm the password',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(139, 139, 139, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(112, 79, 56, 1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(112, 79, 56, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(112, 79, 56, 1)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        if (passwordController.text.trim() ==
                            confirmPasswordController.text.trim()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          try {
                            // signing up a user
                            final user = await AuthService.signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            // storing the user data in firestore db
                            final newUser = UsersModel(
                              title: _title!,
                              id: user.user!.uid,
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              imageUrl: '',
                              description: descriptionController.text.trim(),
                            );

                            UsersRepository.saveUserRecord(newUser);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Account created successfully! Verify your email account to continue.'),
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
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Confirm password doesn\'t match with password! Please make them match.'),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(13, 133, 72, 1),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 61, 61, 61),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    GestureDetector(
                      onTap: widget.onClickSignin,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          color: Color.fromRGBO(13, 133, 72, 1),
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
