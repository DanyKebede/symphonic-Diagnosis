import 'package:flutter/material.dart';

class TruncateText extends StatefulWidget {
  final String text;
  final int maxLength;

  const TruncateText({
    super.key,
    required this.text,
    this.maxLength = 100,
  });

  @override
  State<TruncateText> createState() => _TruncateTextState();
}

class _TruncateTextState extends State<TruncateText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String truncatedText =
        isExpanded ? widget.text : widget.text.substring(0, widget.maxLength);

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            truncatedText,
            style: const TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins'),
          ),
          if (widget.text.length > widget.maxLength)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'See less' : 'Read more',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
