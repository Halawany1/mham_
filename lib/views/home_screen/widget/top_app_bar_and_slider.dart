import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/cart_screen/cart_screen.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:mham/views/search_screen/search_screen.dart';
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
                left: 15.w,
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
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));
  }
}
