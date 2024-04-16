import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/constent/image_constant.dart';

class BuildThridPartyServices extends StatelessWidget {
  const BuildThridPartyServices({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {

          },
          child: Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: color.cardColor,
            ),

            child: Image.asset(
              scale: 0.8,
              ImageConstant.appleLogo,
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        InkWell(
          onTap: () {

          },
          child: Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: color.cardColor,
            ),

            child: Image.asset(
              scale: 0.8,
              ImageConstant.googleLogo,
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        InkWell(
          onTap: () {

          },
          child: Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: color.cardColor,
            ),

            child: Image.asset(
              scale: 0.8,
              ImageConstant.facebookLogo,
            ),
          ),
        ),
      ],
    );
  }
}
