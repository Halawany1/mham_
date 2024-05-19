import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/internet_cubit/internet_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/layout/widget/no_internet.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DriverLayoutScreen extends StatelessWidget {
  const DriverLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;

    return BlocBuilder<OrderDriverCubit, OrderDriverState>(
      builder: (context, state) {
        var orderCubit = context.read<OrderDriverCubit>();
        return BlocBuilder<InternetCubit, InternetState>(
          builder: (context, internetState) {
            return BlocBuilder<LayoutCubit, LayoutState>(
              builder: (context, state) {
                var cubit = context.read<LayoutCubit>();
                return Scaffold(
                    body: internetState is InternetNotConnected
                        ? BuildNoInternet()
                        : cubit.screensDriver[cubit.driverIndex],
                    bottomNavigationBar: Container(
                      height: cubit.driverIndex == 0 &&
                              CacheHelper.getData(
                                      key: AppConstant.timeLineProcess) !=
                                  null
                          ? 135.h
                          : 55.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r))),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: SalomonBottomBar(
                              selectedColorOpacity: 0.2,
                              backgroundColor: color.cardColor,
                              margin: EdgeInsets.all(12.h),
                              currentIndex: cubit.driverIndex,
                              onTap: (i) {
                                cubit.changeDriverIndex(i);
                              },
                              items: [
                                SalomonBottomBarItem(
                                  icon: Icon(
                                    FontAwesomeIcons.home,
                                    size: 18.r,
                                  ),
                                  title: Text(locale.home),
                                  selectedColor:
                                      color.backgroundColor.withOpacity(0.9),
                                ),
                                SalomonBottomBarItem(
                                  icon: Icon(
                                    FontAwesomeIcons.timeline,
                                    size: 18.r,
                                  ),
                                  title: Text(locale.timeLine),
                                  selectedColor:
                                      color.backgroundColor.withOpacity(0.9),
                                ),
                                SalomonBottomBarItem(
                                  icon: Icon(
                                    FontAwesomeIcons.truck,
                                    size: 18.r,
                                  ),
                                  title: Text(locale.orders),
                                  selectedColor:
                                      color.backgroundColor.withOpacity(0.9),
                                ),
                                SalomonBottomBarItem(
                                  icon: Icon(
                                    FontAwesomeIcons.history,
                                    size: 18.r,
                                  ),
                                  title: Text(locale.history),
                                  selectedColor:
                                      color.backgroundColor.withOpacity(0.9),
                                ),
                                SalomonBottomBarItem(
                                  icon: Icon(
                                    FontAwesomeIcons.solidUser,
                                    size: 18.r,
                                  ),
                                  title: Text(locale.profile),
                                  selectedColor:
                                      color.backgroundColor.withOpacity(0.9),
                                ),
                              ],
                            ),
                          ),
                          if (cubit.driverIndex == 0 &&
                              CacheHelper.getData(
                                      key: AppConstant.timeLineProcess) !=
                                  null &&
                              orderCubit.timeLineOrderModel != null)
                            Container(
                              height: 80.h,
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              decoration: BoxDecoration(
                                  color:
                                      color.backgroundColor.withOpacity(0.75),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Row(
                                      children: [
                                        Text(
                                          orderCubit.allIsShipped?
                                          'order status':orderCubit
                                              .timeLineOrderModel!
                                              .activeOrder!
                                              .orderItems![
                                          CacheHelper.getData(
                                              key: AppConstant
                                                  .timeLineProcess)]
                                              .product!.productsName!,
                                          style: font.bodyMedium!
                                              .copyWith(fontSize: 15.sp)
                                              .copyWith(
                                                  color: ColorConstant.brown),
                                        ),
                                        Spacer(),
                                        Text(
                                          orderCubit
                                              .timeLineOrderModel!
                                              .activeOrder!
                                              .orderItems![
                                          CacheHelper.getData(
                                              key: AppConstant
                                                  .timeLineProcess)]
                                              .status!,
                                          style: font.bodyMedium!.copyWith(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  AnotherStepper(
                                    verticalGap: 20.h,
                                    stepperList: [
                                      StepperData(
                                          title: StepperText(locale.ordered,
                                              textStyle: font.bodyMedium!
                                                  .copyWith(fontSize: 12.sp)),
                                          iconWidget: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: color.backgroundColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.r))),
                                            child: Text('1',
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                  fontSize:12.sp,
                                                        color: ColorConstant
                                                            .brown)),
                                          )),
                                      StepperData(
                                          title: StepperText(locale.processing,
                                              textStyle: font.bodyMedium!
                                                  .copyWith(fontSize: 12.sp)),
                                          iconWidget: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color:
                                                orderCubit
                                                    .timeLineOrderModel!
                                                    .activeOrder!
                                                    .orderItems![
                                                CacheHelper.getData(
                                                    key: AppConstant
                                                        .timeLineProcess)]
                                                    .status=="Processing"||
                                                        orderCubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .orderItems![
                                                        CacheHelper.getData(
                                                            key: AppConstant
                                                                .timeLineProcess)]
                                                            .status=="Shipped"||
                                                        orderCubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .orderItems![
                                                        CacheHelper.getData(
                                                            key: AppConstant
                                                                .timeLineProcess)]
                                                            .status=="Delivered"
                                                    ? color.backgroundColor
                                                    : Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.r))),
                                            child: Text('2',
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                    fontSize:12.sp,
                                                        color: ColorConstant
                                                            .brown)),
                                          )),
                                      StepperData(
                                          title: StepperText(locale.shipped,
                                              textStyle: font.bodyMedium!
                                                  .copyWith(fontSize: 12.sp)),
                                          iconWidget: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color:
                                                orderCubit
                                                    .timeLineOrderModel!
                                                    .activeOrder!
                                                    .orderItems![
                                                CacheHelper.getData(
                                                    key: AppConstant
                                                        .timeLineProcess)]
                                                    .status=="Shipped"||
                                                        orderCubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .orderItems![
                                                        CacheHelper.getData(
                                                            key: AppConstant
                                                                .timeLineProcess)]
                                                            .status=="Delivered"
                                                    ? color.backgroundColor
                                                    : Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.r))),
                                            child: Text('3',
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                    fontSize:12.sp,
                                                        color: ColorConstant
                                                            .brown)),
                                          )),
                                      StepperData(
                                        iconWidget: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: orderCubit
                                                          .timeLineOrderModel!
                                                          .activeOrder!
                                                          .orderItems![
                                                              CacheHelper.getData(
                                                                  key: AppConstant
                                                                      .timeLineProcess)]
                                                          .status =="Delivered"
                                                  ? Border.all(
                                                      color: color.primaryColor)
                                                  : null,
                                              color:  orderCubit
                                                  .timeLineOrderModel!
                                                  .activeOrder!
                                                  .orderItems![
                                              CacheHelper.getData(
                                                  key: AppConstant
                                                      .timeLineProcess)]
                                                  .status =="Delivered"
                                                  ? color.backgroundColor
                                                  : Colors.grey,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.r))),
                                        ),
                                        title: StepperText(locale.delivered,
                                            textStyle: font.bodyMedium!
                                                .copyWith(fontSize: 12.sp)),
                                      ),
                                    ],
                                    activeIndex: orderCubit
                                        .timeLineOrderModel!
                                        .activeOrder!
                                        .orderItems![
                                    CacheHelper.getData(
                                        key: AppConstant
                                            .timeLineProcess)]
                                        .status == "Ordered" ? 1 :
                                    orderCubit
                                        .timeLineOrderModel!
                                        .activeOrder!
                                        .orderItems![
                                    CacheHelper.getData(
                                        key: AppConstant
                                            .timeLineProcess)]
                                        .status == "Processing" ? 2 :
                                    orderCubit
                                        .timeLineOrderModel!
                                        .activeOrder!
                                        .orderItems![
                                    CacheHelper.getData(
                                        key: AppConstant
                                            .timeLineProcess)]
                                        .status == "Shipped"? 3:4,

                                    stepperDirection: Axis.horizontal,
                                    iconWidth: 20.w,
                                    // Height that will be applied to all the stepper icons
                                    iconHeight: 20
                                        .h, // Width that will be applied to all the stepper icons
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ));
              },
            );
          },
        );
      },
    );
  }
}
