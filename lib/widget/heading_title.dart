import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  const HeadingTitle({
    super.key,
    required this.mainColor,
    required this.title,
    required this.seeAll,
  });

  final Color mainColor;
  final String title;
  final VoidCallback seeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: seeAll,
            child: Row(
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
                Icon(
                  Icons.arrow_right_alt_rounded,
                  color: mainColor,
                  size: 28,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
