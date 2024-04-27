import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro.dart';
import 'introdata.dart';

class IntroductionPage extends StatefulWidget {
  static const String routeName = '/';
  const IntroductionPage({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const IntroductionPage(),
    );
  }

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  var controller = PageController();
  var lastPage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    lastPage = value == (data.length - 1);
                  });
                },
                children: data
                    .map(
                      (data) => Intro(
                        title: data.title,
                        subtitle: data.description,
                        url: data.imgUrl,
                      ),
                    )
                    .toList(),
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: data.length,
              effect: const ExpandingDotsEffect(
                spacing: 15.0,
                activeDotColor: Color.fromRGBO(13, 133, 72, 1),
                dotHeight: 10,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: lastPage
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(13, 133, 72, 1),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.5, 50)),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/authPage');
                      },
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SfPro',
                        ),
                      ))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: const Color.fromRGBO(13, 133, 72, 1),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(70, 70)),
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 30,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
