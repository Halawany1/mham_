import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/views/driver/start_with_driver_or_customer_screen/start_with_driver_or_customer_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildSheetLoginAndSignUp extends StatelessWidget {
  const BuildSheetLoginAndSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    return SizedBox(
      height: 270.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.asset('assets/images/auth_image.png',),
          Positioned(
              top: 75.h,
              left: 140.w,
              child: Text(locale.welcome,style: font.bodyLarge!.copyWith(
                  fontSize: 20.sp
              ),)),
          Positioned(
            top: 115.h,
            left: 50.w,
            child: Text(locale.pleaseSignInForFullVersion,
              textAlign: TextAlign.center,
              style: font.bodyMedium,),
          ),
          SizedBox(height: 30.h,),
          Positioned(
            top: 175.h,
            left: 70.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildDefaultButton(text: locale.signIn,
                    height: 25.h,
                    width: 70.w,
                    fontSize: 12.sp,
                    borderRadius: 8.r,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GetStartWithDriverOrCustomerScreen(signUp: false),));
                      //Navigator.pop(context);
                    }, backgorundColor: color.backgroundColor,
                    colorText: color.primaryColor),
                SizedBox(width: 50.w,),
                BuildDefaultButton(text: locale.signUp,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => GetStartWithDriverOrCustomerScreen(signUp: true),));
                     // Navigator.pop(context);
                    }, backgorundColor: color.cardColor,
                    withBorder: true,
                    borderRadius: 8.r,
                    fontSize: 12.sp,
                    height: 25.h,
                    width: 70.w,
                    colorText: color.primaryColor)
              ],),
          )
        ],
      ),
    );
  }
}
