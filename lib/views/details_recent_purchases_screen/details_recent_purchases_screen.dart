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
import 'package:mham/views/order_details_screen/widget/order_details.dart';
import 'package:mham/views/order_details_screen/widget/tracking_order.dart';

import '../recent_purchases_screen/widget/return_order_popup.dart';

class DetailsRecentPurchasesScreen extends StatelessWidget {
  const DetailsRecentPurchasesScreen({
    super.key,
    required this.currentIndex,
    required this.totalPrice,
    required this.orderId,
    required this.returns,
    required this.qunatity,
    this.hideNav = false,
    this.returnOrder = false,
    this.hideReturnButton = false,
  });

  final int currentIndex;
  final int orderId;
  final double totalPrice;
  final bool hideNav;
  final bool returnOrder;
  final bool hideReturnButton;
  final List<Map<String, dynamic>> returns;
  final int qunatity;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    var cubit = HomeCubit.get(context);
    List<StepperData> stepperData = [
      StepperData(
          title: StepperText(locale.ordered, textStyle: font.bodyMedium),
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
                  cubit.recentPurchases[currentIndex].processingAt != null
              ? StepperText(
                  locale.orderPrepared +
                      Helper.trackingTimeFormat(
                          cubit.recentPurchases[currentIndex].processingAt!),
                  textStyle: font.bodySmall!.copyWith(color: Colors.grey))
              : null,
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: cubit.recentPurchases[currentIndex].deliveredAt !=
                            null ||
                        cubit.recentPurchases[currentIndex].processingAt != null
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('2',
                style: font.bodyMedium!.copyWith(
                    color:
                        cubit.recentPurchases[currentIndex].deliveredAt != null
                            ? ColorConstant.brown
                            : Colors.grey)),
          )),
      StepperData(
          title: StepperText(locale.shipped, textStyle: font.bodyMedium),
          subtitle: cubit.recentPurchases[currentIndex].deliveredAt != null &&
                  cubit.recentPurchases[currentIndex].shippedAt != null
              ? StepperText(
                  textStyle: font.bodySmall!.copyWith(color: Colors.grey),
                  locale.deliverItem +
                      Helper.trackingTimeFormat(
                          cubit.recentPurchases[currentIndex].shippedAt!))
              : null,
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: cubit.recentPurchases[currentIndex].deliveredAt !=
                            null ||
                        cubit.recentPurchases[currentIndex].shippedAt != null
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('3',
                style: font.bodyMedium!.copyWith(
                    color:
                        cubit.recentPurchases[currentIndex].deliveredAt != null
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
        Navigator.pop(context);
        return true;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is NoInternetHomeState) {
            showMessageResponse(
                message: locale.noInternetConnection,
                context: context,
                success: false);
          }
          if (state is SuccessReturnOrderState) {
            cubit.cardProductDetails.clear();
            cubit.trackingContainer = false;
            HomeCubit.get(context).orderModel=null;
            HomeCubit.get(context).getAllOrders();
            Navigator.pop(context);
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
                    Navigator.pop(context);
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
                      BuildOrderDetails(
                          lenght: qunatity,
                          createdAt:
                              cubit.recentPurchases[currentIndex].createdAt!,
                          status: cubit.recentPurchases[currentIndex].status!,
                          totalPrice: totalPrice),
                      SizedBox(
                        height: 20.h,
                      ),
                      BuildTrackingOrder(
                          activeProcess:cubit.recentPurchases[currentIndex]
                              .deliveredAt!=null?4:
                          cubit.recentPurchases[currentIndex]
                              .shippedAt!=null?3:2 ,
                          createdAt:
                              cubit.recentPurchases[currentIndex].createdAt!,
                          orderId: cubit.recentPurchases[currentIndex].id!,
                          stepperData: stepperData,
                          totalPrice: totalPrice),
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
                          if (cubit.recentPurchases[currentIndex]
                                  .orderItems![index].product!.availableYears !=
                              null) {
                            cubit.recentPurchases[currentIndex].orderItems![index]
                                .product!.availableYears!
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
                          cubit.recentPurchases[currentIndex].orderItems![index]
                              .returnProducts!
                              .forEach((element) {
                            returnQuantity += element.quantity!;
                          });
                          for (int i = 1;
                              i <=
                                  cubit.recentPurchases[currentIndex]
                                      .orderItems![index].quantity! -
                                      returnQuantity;
                              i++) {
                            quantities.add(i.toString());
                          }

                          return BuildCardProductDetails(
                            hideCancelOrder:hideReturnButton ,
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
                        itemCount: cubit.recentPurchases[currentIndex].
                        orderItems!.length,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      if (returnOrder)
                        BuildDefaultButton(
                            text: locale.returnOrder,
                            borderRadius: 8.r,
                            width: 110.w,
                            height: 26.h,
                            fontSize: 13.sp,
                            onPressed: () {
                              if (!hideReturnButton) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BuildReturnOrderPopUp(
                                      orderId: orderId,
                                        returns: returns);
                                  },
                                );
                              }
                            },
                            backgorundColor:hideReturnButton
                                ? Colors.grey
                                : color.backgroundColor,
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
