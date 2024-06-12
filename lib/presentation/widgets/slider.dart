import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/config/app_colors.dart';
import '../../data/models/home/slider/AdvertisingBanners.dart';
import '../../generated/assets.dart';

class MySlider extends StatefulWidget {

  MySlider(this.advertisingBanners,  {Key? key}) : super(key: key);

  List<dynamic> advertisingBanners;

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.95,
              aspectRatio: 2.0,
              initialPage: 1,
              animateToClosest: true,
              autoPlayInterval: Duration(seconds: 4),
              onPageChanged: (int index, CarouselPageChangedReason reason) => {
                    setState(() => {currentIndex = index})
                  }),
          items: widget.advertisingBanners.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    margin: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            (item as AdvertisingBanners).image.toString(),
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null) ? child : Center(child: CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) => Container(
                                margin: EdgeInsets.all(10),
                                child:
                                //SvgPicture.asset(Assets.imagesEClassesLogoWhite)
                              Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)))));
              },
            );
          }).toList(),
        ),
        DotsIndicator(
          dotsCount: widget.advertisingBanners.length==0?1:widget.advertisingBanners.length,
          position: currentIndex.toDouble(),
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeColor: AppColors.primary,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}
