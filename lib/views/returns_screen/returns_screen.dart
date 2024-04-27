import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/details_recent_purchases_screen/details_recent_purchases_screen.dart';
import 'package:mham/views/order_details_screen/order_details_screen.dart';
import 'package:mham/views/order_screen/widget/card_order_list_component.dart';
import 'package:mham/views/recent_purchases_screen/recent_purchases_screen.dart';

import '../order_details_screen/widget/card_product_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme
        .of(context)
        .textTheme;
    final locale = AppLocalizations.of(context);
    return BlocConsumer<HomeCubit, HomeState>(
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
        var cubit = HomeCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            Helper.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(locale.returns),
              leading: InkWell(
                  onTap: () {
                    Helper.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: color.primaryColor,
                  )),
            ),
            body: cubit.orderModel != null
                ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    if (cubit.recentPurchases.length > 0)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            double totalPrice = 0.0;
                            List<Map<String, dynamic>> returnData = [];
                            int returnQuantity = 0;
                            int productQuantity = 0;
                            cubit.recentPurchases[index].carts![0]
                                .cartProducts!
                                .forEach((element) {
                              totalPrice += element.product!.price! *
                                  element.quantity!;
                              cubit.cardProductDetails.add(false);
                              returnData.add({
                                "cartProduct_id": element.productId,
                                "reason": 'reason',
                                "quantity": element.quantity
                              });
                              productQuantity += element.quantity!;
                              element.returnProduct!.forEach((element) {
                                returnQuantity += element.quantity!;
                              });
                            });
                            bool hideReturnButton = false;
                            if (productQuantity == returnQuantity) {
                              hideReturnButton = true;
                            }

                            return InkWell(
                                onTap: () {
                                  Helper.push(
                                      context,
                                      DetailsRecentPurchasesScreen(
                                        hideReturnButton:
                                        hideReturnButton,
                                        returns: returnData,
                                        currentIndex: index,
                                        returnOrder: true,
                                        hideNav: true,
                                        totalPrice: totalPrice,
                                      ));
                                },
                                child: BuildCardOrderList(
                                    returns: returnData,
                                    returnOrder: true,
                                    status: cubit
                                        .returnsOrder[index].status!,
                                    quantity:
                                    cubit.returnsOrder.length,
                                    createdAt: cubit
                                        .returnsOrder[index]
                                        .createdAt!,
                                    orderId: cubit
                                        .returnsOrder[index].orderId!,
                                    totalPrice: totalPrice,
                                    index: index));
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(
                                height: 10.h,
                              ),
                          itemCount: cubit.returnsOrder.length),
                    if (cubit.returnsOrder.length == 0)
                      Padding(
                        padding: EdgeInsets.only(top: 120.h),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(ImageConstant.
                              noReturns, width: 110.w,
                                height: 110.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                locale.noReturnRequested,
                                style: font.bodyMedium!.copyWith(
                                    fontSize: 12.sp
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              BuildDefaultButton(
                                  width: 150.w,
                                  height: 30.h,
                                  borderRadius: 8.r,
                                  text: locale.createNewReturn,
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          RecentPurchasesScreen(hideNav: false,),));
                                  },
                                  backgorundColor: color.backgroundColor,
                                  colorText: ColorConstant.brown)
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
                : Center(
                child: BuildImageLoader(assetName: ImageConstant.logo)),
          ),
        );
      },
    );
  }
}
