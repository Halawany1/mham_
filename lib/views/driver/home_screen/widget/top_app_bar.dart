import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




AppBar topAppBar(BuildContext context) {
var font = Theme.of(context).textTheme;
var color = Theme.of(context);
var locale = AppLocalizations.of(context);
return AppBar(
  surfaceTintColor: Colors.transparent,
  backgroundColor: color.backgroundColor,
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: color.backgroundColor,
  ),
  actions: [
    GestureDetector(
        onTap: () {
          Helper.push(context: context,
              widget: NotificationScreen(),withAnimate: true);
        },
        child:
        Padding(
          padding:  EdgeInsets.all(15.h),
          child: Icon(FontAwesomeIcons.bell,
            size: 22.r,color:
            color.primaryColor,),
        )),
  ],
  toolbarHeight: 50.h,
  title: Padding(
    padding:  EdgeInsets.all(10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${locale.hi}',style: font.bodyLarge!.copyWith(
            fontSize: 15.sp
        ),),
        Text(locale.niceToSeeYouAgain,style: font.bodySmall,),
      ],
    ),
  ),

);
}