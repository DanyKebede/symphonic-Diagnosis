import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../service/banner_data.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({
    super.key,
  });

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.28,
          padding: const EdgeInsets.all(3),
          margin:
              const EdgeInsets.only(top: 10, left: 17, right: 17, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromRGBO(13, 133, 72, 1),
              width: 1,
            ),
          ),
          child: CarouselSlider(
            items: bannerItem
                .map((e) => Image.asset(
                      e,
                      fit: BoxFit.fill,
                    ))
                .toList(),
            // items: [
            //   Image.asset(
            //     'assets/images/banner/banner_4.png',
            //     fit: BoxFit.fill,
            //   ),
            //   Image.asset(
            //     'assets/images/banner/banner_4.png',
            //     fit: BoxFit.fill,
            //   ),
            // ],
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
              enableInfiniteScroll: false,
              // autoPlay: true,
              // autoPlayInterval: const Duration(seconds: 3),
            ),
          ),
        ),
        AnimatedSmoothIndicator(
          activeIndex: activeIndex,
          count: bannerItem.length,
          effect: const ExpandingDotsEffect(
              dotHeight: 12,
              dotWidth: 11,
              spacing: 6.0,
              activeDotColor: Color.fromRGBO(13, 133, 72, 1),
              dotColor: Color.fromRGBO(81, 207, 144, 1)),
        )
      ],
    );
  }
}
