import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/symptom.dart';
import './managesymptom.dart';

class AddSymptomPage extends StatelessWidget {
  const AddSymptomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * 0.77,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(13, 133, 72, 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add your symptoms",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Add as many symptoms as you can for the accurate results. ",
              style: TextStyle(
                color: Color.fromARGB(255, 37, 37, 37),
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SelectSymptom(),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              padding: const EdgeInsets.only(bottom: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(13, 133, 72, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(size.width * 0.8, 50)),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/result');
                      Provider.of<SymptomProvider>(context, listen: false)
                          .checkDisease();
                    },
                    child: Row(
                      children: [
                        const Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Image.asset(
                          'assets/images/arrow.png',
                          width: 20,
                          height: 20,
                          color: const Color.fromARGB(255, 231, 224, 224),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
