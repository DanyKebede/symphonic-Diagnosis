import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Intro extends StatelessWidget {
  final String title;
  final String subtitle;
  final String url;

  const Intro({
    required this.title,
    required this.subtitle,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.5,
          margin: EdgeInsets.only(bottom: size.height * 0.05),
          // child: SvgPicture.asset(
          //   url,
          //   fit: BoxFit.cover,
          // )
          child: Image.asset(
            url,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 13),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 19,
              ),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ],
    );
  }
}
