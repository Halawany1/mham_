import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/home_screen/home_screen.dart';
import 'package:mham/views/see_all_screen/see_all_screen.dart';

class BuildSliderCarType extends StatelessWidget {
  const BuildSliderCarType({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var color = Theme.of(context);
    return  Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              cubit.changeTypeCarIndex(
                  value: cubit.index > 0
                      ? cubit.index - 1
                      : 4);
              carouselController
                  .jumpToPage(cubit.index);
            },
            child: Icon(Icons.arrow_back_ios)),
        Container(
          width: 250.w,
          height: 57.h,
          decoration: BoxDecoration(
            color: color.cardColor,
            borderRadius:
            BorderRadius.circular(10.r),
          ),
          child: CarouselSlider(
              carouselController:
              carouselController,
              items: List.generate(5, (index) {
                double width = cubit.index == index
                    ? 57.w
                    : 30.w;
                double height = cubit.index == index
                    ? 57.w
                    : 30.w;

                return InkWell(
                  onTap: () {
                    cubit.getAllProduct(
                        carId: index + 1);
                    cubit.carController.clearAllSelection();
                    Helper.push(context,
                        SeeAllScreen(title:'',carType: true,));
                  },
                  child: Image.asset(
                    ImageConstant.cars(index),
                    width: width,

                    height: height,
                  ),
                );
              }),
              options: CarouselOptions(
                height: 57.h,
                viewportFraction: 0.2,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  cubit.changeTypeCarIndex(
                      value: index);
                },
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval:
                Duration(seconds: 3),
                autoPlayAnimationDuration:
                Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                scrollDirection: Axis.horizontal,
              )),
        ),
        InkWell(
            onTap: () {
              cubit.changeTypeCarIndex(
                  value: cubit.index == 4
                      ? 0
                      : cubit.index + 1);
              carouselController
                  .jumpToPage(cubit.index);
            },
            child: Icon(Icons.arrow_forward_ios))
      ],
    );

  }
}
