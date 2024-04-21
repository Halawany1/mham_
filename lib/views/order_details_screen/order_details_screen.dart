import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/models/order_model.dart';
import 'package:mham/views/order_details_screen/widget/card_product_details.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orders,
    required this.currentIndex,
    required this.totalPrice,
  });

  final Orders orders;
  final int currentIndex;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    List<StepperData> stepperData = [
      StepperData(
          title: StepperText(locale.ordered, textStyle: font.bodyMedium),
          subtitle: StepperText(
            locale.orderPlaced +
                Helper.trackingTimeFormat(orders.createdAt!),
            textStyle: font.bodyMedium!.copyWith(
                fontSize: 12.sp,
                color: color.primaryColor.withOpacity(0.7)),
          ),
          iconWidget: Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
                color: color.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: const Icon(Icons.looks_one, color: Colors.white),
          )),
      StepperData(
          title: StepperText(locale.processing, textStyle: font.bodyMedium),
          subtitle: orders.processingAt == null
              ? null
              : StepperText(locale.orderPrepared+
              Helper.trackingTimeFormat(orders.processingAt!),
                  textStyle: font.bodySmall!.copyWith(color: Colors.grey)),
          iconWidget: Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
                color:
                    orders.status == 'Shipped' || orders.status == 'Delivered'
                        ? color.backgroundColor
                        : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: const Icon(Icons.looks_two, color: Colors.white),
          )),
      StepperData(
          title: StepperText(locale.shipped, textStyle: font.bodyMedium),
          subtitle: orders.shippedAt == null
              ? null
              : StepperText(
                  textStyle: font.bodySmall!.copyWith(
                      color: Colors.grey),
              locale.deliverItem+
                  Helper.trackingTimeFormat(orders.shippedAt!)),
          iconWidget: Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
                color: orders.status == 'Delivered'
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: const Icon(Icons.looks_3, color: Colors.white),
          )),
      StepperData(
        title: StepperText(locale.delivered, textStyle: font.bodyMedium),
      ),
    ];
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return WillPopScope(
          onWillPop: () async {
            Helper.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Helper.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: color.primaryColor)),
              centerTitle: true,
              title: Text(
                locale.orderDetails,
                style: font.bodyLarge!.copyWith(fontSize: 22.sp),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: color.backgroundColor),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r))),
                        child: Padding(
                          padding: EdgeInsets.all(12.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    locale.orderDetails,
                                    style: font.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        Helper.formatDate(orders.createdAt!),
                                        style: font.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        orders.status.toString(),
                                        style: font.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                            color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        locale.quantity,
                                        style: font.bodyMedium!.copyWith(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 25.w,
                                        height: 25.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: color.disabledColor),
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Text(
                                          orders.carts!.length.toString(),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        locale.totalCost,
                                        style: font.bodyMedium!.copyWith(
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          totalPrice.toStringAsFixed(2) +
                                              ' ${locale.kd}',
                                          style: font.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color: color.backgroundColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: color.backgroundColor),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r))),
                        child: Padding(
                          padding: EdgeInsets.all(12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.openAndCloseTrackingContainer();
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                      locale.trackYourOrder,
                                        style: font.bodyLarge!
                                            .copyWith(fontSize: 20.sp),
                                      ),
                                      Icon(
                                        cubit.trackingContainer
                                            ? Icons.keyboard_arrow_down_outlined
                                            : Icons.keyboard_arrow_up,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (cubit.trackingContainer)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AnotherStepper(
                                      verticalGap: 15.h,
                                      stepperList: stepperData,
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
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        locale.productDetails,
                        style: font.bodyLarge!.copyWith(fontSize: 22.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          List<String> carModels = [];
                          if (cubit
                                  .allOrders[currentIndex]
                                  .carts![0]
                                  .cartProducts![index]
                                  .product!
                                  .availableYears !=
                              null) {
                            cubit.allOrders[currentIndex].carts![0]
                                .cartProducts![index].product!.availableYears!
                                .forEach((element) {
                              carModels.add(element.carModel!.car!.carName! +
                                  ' ' +
                                  element.carModel!.modelName! +
                                  ' ' +
                                  element.availableYear.toString());
                            });
                          }
                          return BuildCardProductDetails(
                              onTap: () {
                                cubit.openAndCloseCardProductDetails(index);
                              },
                              carModels: carModels,
                              opened: cubit.cardProductDetails[index],
                              index: index,
                              orders: orders);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                        itemCount: orders.carts![0].cartProducts!.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
