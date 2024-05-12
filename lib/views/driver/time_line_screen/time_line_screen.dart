import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/views/driver/order_details_screen/card_products.dart';
import 'package:mham/views/order_details_screen/widget/order_details.dart';
import 'package:mham/views/order_details_screen/widget/tracking_order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    List<StepperData> stepperData = [
      StepperData(
          title: StepperText(locale.ordered, textStyle: font.bodyMedium),
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('1',
                style: font.bodyMedium!.copyWith(color: ColorConstant.brown)),
          )),
      StepperData(
          title: StepperText(locale.processing, textStyle: font.bodyMedium),
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('2',
                style: font.bodyMedium!.copyWith(
                    color: ColorConstant.brown
                )),
          )),
      StepperData(
          title: StepperText(locale.shipped, textStyle: font.bodyMedium),
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('3',
                style: font.bodyMedium!.copyWith(
                    color: ColorConstant.brown
                )),
          )),
      StepperData(
        iconWidget: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: color.primaryColor),
              color: color.backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
        ),
        title: StepperText(locale.delivered, textStyle: font.bodyMedium),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImageConstant.splash,width: 70.w,height: 70.h,),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(18.h),
            child: Column(
              children: [
              BuildOrderDetails(lenght:3 ,
                  createdAt: '2024-05-05T13:11:41.404Z',
                  status: 'Delivered', totalPrice: 1232),
                SizedBox(height: 20.h,),
                BuildTrackingOrder(orderId: 123,
                    createdAt: '2024-05-05T13:11:41.404Z',
                    notClosed: true,
                    stepperData: stepperData, totalPrice: 234235),
                SizedBox(height: 20.h,),
                Text(locale.products,style: font.bodyLarge!.
                copyWith(fontSize: 20.sp),),
                SizedBox(height: 10.h,),
                BuildCardProductDetailsForDriver(
                  notClosed: true,
                    opened:
                false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

