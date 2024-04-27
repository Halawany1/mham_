import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/order_details_screen/widget/card_product_details.dart';

import '../recent_purchases_screen/widget/return_order_popup.dart';

class DetailsRecentPurchasesScreen extends StatelessWidget {
  const DetailsRecentPurchasesScreen({
    super.key,
    required this.currentIndex,
    required this.totalPrice,
    required this.returns,
    this.hideNav = false,
    this.returnOrder = false,
    this.hideReturnButton = false,
  });

  final int currentIndex;
  final double totalPrice;
  final bool hideNav;
  final bool returnOrder;
  final bool hideReturnButton;
  final List<Map<String, dynamic>> returns;

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    var cubit = HomeCubit.get(context);
    List<StepperData> stepperData = [
      StepperData(
          title: StepperText(locale.ordered,
              textStyle: font.bodyMedium),
          subtitle: StepperText(
            locale.orderPlaced +
                Helper.trackingTimeFormat(
                    cubit.recentPurchases[currentIndex].createdAt!),
            textStyle: font.bodyMedium!.copyWith(
                fontSize: 12.sp, color: color.primaryColor.withOpacity(0.7)),
          ),
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
          subtitle: cubit.recentPurchases[currentIndex].deliveredAt != null &&
              cubit.recentPurchases[currentIndex].processingAt != null?
          StepperText(
              locale.orderPrepared +
                  Helper.trackingTimeFormat(
                      cubit.recentPurchases[currentIndex].processingAt!),
              textStyle: font.bodySmall!.copyWith(color:
              Colors.grey)):null,
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: cubit.recentPurchases[currentIndex].deliveredAt != null ||
                    cubit.recentPurchases[currentIndex].processingAt != null
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('2',
                style: font.bodyMedium!.copyWith(
                    color: cubit.recentPurchases[currentIndex].deliveredAt != null
                        ? ColorConstant.brown
                        : Colors.grey)),
          )),
      StepperData(
          title: StepperText(locale.shipped, textStyle: font.bodyMedium),
          subtitle:  cubit.recentPurchases[currentIndex].deliveredAt != null &&
              cubit.recentPurchases[currentIndex].shippedAt != null
              ?StepperText(
              textStyle: font.bodySmall!.copyWith(color: Colors.grey),
              locale.deliverItem +
                  Helper.trackingTimeFormat(
                      cubit.recentPurchases[currentIndex].shippedAt!)):
          null,
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: cubit.recentPurchases[currentIndex].deliveredAt != null ||
                    cubit.recentPurchases[currentIndex].shippedAt != null
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('3',
                style: font.bodyMedium!.copyWith(
                    color: cubit.recentPurchases[currentIndex].deliveredAt != null
                        ? ColorConstant.brown
                        : Colors.grey)),
          )),
      StepperData(
        iconWidget: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: cubit.recentPurchases[currentIndex].deliveredAt != null
                  ? Border.all(color: color.primaryColor)
                  : null,
              color: cubit.recentPurchases[currentIndex].deliveredAt != null
                  ? color.backgroundColor
                  : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
        ),
        title: StepperText(locale.delivered, textStyle: font.bodyMedium),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        cubit.cardProductDetails.clear();
        cubit.trackingContainer = false;
        if (hideNav) {
          Navigator.pop(context);
        } else {
          Helper.pop(context);
        }

        return true;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SuccessReturnOrderState) {
            showMessageResponse(
                message: locale.orderReturnedSuccessfully,
                context: context,
                success: true);
          }
          if (state is ErrorReturnOrderState) {
            showMessageResponse(
                message: state.error, context: context, success: false);
          }

        },
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    cubit.cardProductDetails.clear();
                    cubit.trackingContainer = false;
                    if (hideNav) {
                      Navigator.pop(context);
                    } else {
                      Helper.pop(context);
                    }
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
                                        Helper.formatDate(cubit
                                            .recentPurchases[currentIndex]
                                            .createdAt!),
                                        style: font.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        cubit.recentPurchases[currentIndex].status
                                            .toString(),
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
                                          cubit.recentPurchases[currentIndex].carts!
                                              .length
                                              .toString(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Divider(),
                                    Text(
                                      locale.order +
                                          ' #' +
                                          cubit.recentPurchases[currentIndex].orderId
                                              .toString(),
                                      style: font.bodySmall!.copyWith(
                                          fontSize: 12.sp,
                                          color: color.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      locale.orderDate + ' : ' +
                                          Helper.trackingTimeFormat(cubit
                                              .recentPurchases[currentIndex].createdAt
                                              .toString()),
                                      style: font.bodySmall!.copyWith(
                                          fontSize: 12.sp,
                                          color: color.primaryColor),
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
                              .recentPurchases[currentIndex]
                              .carts![0]
                              .cartProducts![index]
                              .product!
                              .availableYears !=
                              null) {
                            cubit.recentPurchases[currentIndex].carts![0]
                                .cartProducts![index].product!.availableYears!
                                .forEach((element) {
                              carModels.add(element.carModel!.car!.carName! +
                                  ' ' +
                                  element.carModel!.modelName! +
                                  ' ' +
                                  element.availableYear.toString());
                            });
                          }
                          List<String> quantities = [];

                          cubit.recentPurchases.forEach((element) {
                            cubit.cardProductDetails.add(false);
                          });
                          int returnQuantity = 0;
                          cubit.recentPurchases[currentIndex].carts![0]
                              .cartProducts![index].returnProduct!
                              .forEach((element) {
                            returnQuantity += element.quantity!;
                          });
                          for (int i = 1;
                          i <=
                              cubit.recentPurchases[currentIndex].carts![0]
                                  .cartProducts![index].quantity! -
                                  returnQuantity;
                          i++) {
                            quantities.add(i.toString());
                          }
                          return BuildCardProductDetails(
                              returnQuantity: returnQuantity,
                              quantity: quantities,
                              onTap: () {
                                cubit.openAndCloseCardProductDetails(index);
                              },
                              carModels: carModels,
                              returnProduct: returnOrder,
                              opened: cubit.cardProductDetails[index],
                              index: index,
                              orders: cubit.recentPurchases[currentIndex]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                        itemCount: cubit.recentPurchases[currentIndex].carts![0]
                            .cartProducts!.length,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      if(returnOrder)
                        BuildDefaultButton(
                            text: locale.returnOrder,
                            borderRadius: 8.r,
                            width: 110.w,
                            height: 26.h,
                            onPressed: () {
                              if(hideReturnButton){
                                showDialog(context: context,
                                  builder: (context) {
                                    return BuildReturnOrderPopUp(
                                        returns: returns);
                                  },);
                              }

                            },
                            backgorundColor:hideReturnButton?
                                Colors.grey
                                :color.backgroundColor,
                            colorText: ColorConstant.brown)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
