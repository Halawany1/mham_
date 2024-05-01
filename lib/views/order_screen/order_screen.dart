import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/order_details_screen/order_details_screen.dart';
import 'package:mham/views/order_details_screen/widget/card_product_details.dart';
import 'widget/card_order_list_component.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    if( cubit.orderModel==null){
      cubit.getAllOrders();
    }
    var font = Theme
        .of(context)
        .textTheme;
    final locale = AppLocalizations.of(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SuccessCancelOrderState) {
          showMessageResponse(
              message: locale.cancelledOrderSuccessfully,
              context: context,
              success: true);
        }
        if(state is NoInternetHomeState){
          showMessageResponse(message: locale.noInternetConnection,
              context: context, success: false);
        }
        if (state is ErrorCancelOrderState) {
          showMessageResponse(
              message: state.error, context: context, success: false);
        }

      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            body: cubit.orderModel != null &&
                state is! LoadingGetAllOrdersState
                ? RefreshIndicator(
              onRefresh: () async{
                cubit.getAllOrders();
              },
                  child: SafeArea(
                                child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if(cubit.allOrders.length > 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                locale.orders,
                                style:
                                font.bodyLarge!.copyWith(fontSize: 22.sp),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        cubit.allOrders.length > 0 ?
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              double totalPrice = 0.0;
                              List<Map<String, dynamic>> returnData = [];

                              cubit.allOrders[index].carts![0].cartProducts!
                                  .forEach((element) {
                                totalPrice += element.product!.price! *
                                    element.quantity!;
                                cubit.cardProductDetails.add(false);
                                returnData.add({
                                  "cartProduct_id": element.productId,
                                  "reason": reasonController.text,
                                  "quantity": element.quantity
                                });
                              });

                              return InkWell(
                                  onTap: () {
                                    int count=0;
                                    cubit.allOrders[index].carts!
                                    [0].cartProducts!.forEach((element) {
                                      if(element.status=="Cancelled"){
                                        count++;
                                      }
                                    });
                                    Helper.push(
                                        context,
                                        OrderDetailsScreen(
                                          hideCancelOrder:count==cubit.allOrders[index].carts!
                                          [0].cartProducts!.length ,
                                          returns: returnData,
                                          currentIndex: index,
                                          totalPrice: totalPrice,
                                        ));
                                  },
                                  child: BuildCardOrderList(
                                      returns:returnData,
                                      status: cubit.allOrders[index].status!,
                                      quantity: cubit.allOrders.length,
                                      createdAt: cubit.allOrders[index]
                                          .createdAt!,
                                      orderId: cubit.allOrders[index].orderId!,
                                      totalPrice: totalPrice,
                                      index: index)
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(
                                  height: 10.h,
                                ),
                            itemCount: cubit.allOrders.length) :
                        Padding(
                          padding: EdgeInsets.only(top: 120.h),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImageConstant.cart),
                                SizedBox(height: 20.h),
                                Text(locale.noOrdersFound,
                                  style:
                                  font.bodyMedium!.
                                  copyWith(fontSize: 22.sp),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                                ),
                              ),
                )
                : Center(
                child: BuildImageLoader(assetName: ImageConstant.logo)));
      },
    );
  }
}
