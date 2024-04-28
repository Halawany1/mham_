import 'package:carousel_slider/carousel_slider.dart';
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

class BuildTopAppBarAndSlider extends StatelessWidget {
  const BuildTopAppBarAndSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            BuildSearchFormField(
              onTap: () {
                Helper.push(context, SearchScreen());
              },
              readOnly: true,
            ),
            SizedBox(
              width: 10.w,
            ),
            InkWell(
              onTap: () {
                if(CacheHelper.getData(key: AppConstant.token) == null){
                  Helper.push(context, GetStartScreen());
                }else{
                  Helper.push(context, NotificationScreen());
                }

              },
              child: Icon(
                FontAwesomeIcons.bell,
                color: color.primaryColor,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            InkWell(
              onTap: () {
                if(CacheHelper.getData(key: AppConstant.token) != null){
                  CartCubit.get(context).getCart(
                      token: CacheHelper.getData(
                          key: AppConstant.token));
                  Helper.push(context, CartScreen());
                }else{
                  Helper.push(context, GetStartScreen());
                }

              },
              child: Icon(
                FontAwesomeIcons.shoppingCart,
                color: ColorConstant.backgroundAuth,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        CarouselSlider(
            items: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(12.r),
                child: Image.asset(
                  ImageConstant.ads,
                  width: double.infinity,
                  height: 90.h,
                ),
              ),
            ],
            options: CarouselOptions(
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration:
              Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            )),
      ],
    );

  }
}
