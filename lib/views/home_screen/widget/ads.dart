import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildAds extends StatelessWidget {
  const BuildAds({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var font = Theme.of(context).textTheme;
    List<String> adsText = [
      locale.startYourCarParts,
      locale.welcomeToOurSparePartsCategory,
      locale.startYourAutoPartsJourneyWithUs
    ];
    return CarouselSlider(
        items: adsText.map((String text) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  ImageConstant.ads,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 130.h,
                ),
              ),
              Positioned(
                top: 10.h,
                left: 35.w,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 220.w,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: font.bodyLarge!.copyWith(
                        color: ColorConstant.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 0.8,
          initialPage: 0,
          disableCenter: true,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          height: 140.h,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
