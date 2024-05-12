import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';

class BuildTrackingOrder extends StatelessWidget {
  const BuildTrackingOrder(
      {super.key,
      required this.orderId,
      required this.createdAt,
      required this.stepperData,
       this.notClosed=false,
      required this.totalPrice});

  final double totalPrice;
  final List<StepperData> stepperData;
  final int orderId;
  final String createdAt;
  final bool notClosed;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: color.backgroundColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if(!notClosed){
                  cubit.openAndCloseTrackingContainer();
                }

              },
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Status',
                      style: font.bodyLarge!.copyWith(fontSize: 20.sp),
                    ),
                    if(!notClosed)
                    Icon(
                      cubit.trackingContainer
                          ? Icons.keyboard_arrow_down_outlined
                          : Icons.keyboard_arrow_up,
                    ),
                    if(notClosed)
                      BuildDefaultButton(text: 'Delivered',
                          width: 90.w,
                          height: 25.h,
                          borderRadius: 8.r,
                          fontSize: 12.sp,
                          onPressed: () {

                          }, backgorundColor: color.backgroundColor,
                          colorText: ColorConstant.brown)
                  ],
                ),
              ),
            ),
            if (cubit.trackingContainer || notClosed)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(),
                  Text(
                    locale.order +
                        ' #' +
                      orderId.toString(),
                    style: font.bodySmall!
                        .copyWith(fontSize: 12.sp, color: color.primaryColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    locale.orderDate +
                        ' ' +
                        Helper.trackingTimeFormat(createdAt),
                    style: font.bodySmall!
                        .copyWith(fontSize: 12.sp, color: color.primaryColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AnotherStepper(
                    verticalGap: 15.h,
                    stepperList: stepperData,
                    activeIndex: 1,
                    stepperDirection: Axis.vertical,
                    iconWidth: 32.w,
                    // Height that will be applied to all the stepper icons
                    iconHeight: 30
                        .h, // Width that will be applied to all the stepper icons
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
