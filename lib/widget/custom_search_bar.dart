import 'package:flutter/material.dart';

class CSearchBar extends StatelessWidget {
  const CSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(13, 133, 72, 1)),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: const Row(
          children: [
            Icon(
              Icons.search,
              size: 28,
              color: Color.fromRGBO(13, 133, 72, 1),
            ),
            SizedBox(width: 8),
            Text(
              'Search for Diseases',
              style: TextStyle(
                color: Color.fromRGBO(13, 133, 72, 1),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
