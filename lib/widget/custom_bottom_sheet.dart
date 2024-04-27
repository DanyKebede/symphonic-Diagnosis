import 'package:flutter/material.dart';

class BottomSheetHelper {
  static Future<bool?> showLogoutConfirmationBottomSheet(
      {required BuildContext context,
      required String headingTitle,
      required String bodyText}) async {
    final Size size = MediaQuery.of(context).size;
    return await showModalBottomSheet<bool?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                headingTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                bodyText,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: Size(size.width * 0.4, 40),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color.fromRGBO(13, 133, 72, 1)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context,
                          false); // Return false when "Cancel" is tapped
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
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(13, 133, 72, 1),
                      fixedSize: Size(size.width * 0.4, 40),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(
                          context, true); // Return true when "Yes" is tapped
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
