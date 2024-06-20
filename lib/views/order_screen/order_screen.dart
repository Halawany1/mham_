import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/order_details_screen/order_details_screen.dart';
import 'package:mham/views/order_details_screen/widget/card_product_details.dart';
import 'package:mham/views/order_screen/widget/empty_order.dart';
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
    var color = Theme.of(context);

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SuccessCancelOrderState) {
          showMessageResponse(
              message: locale.cancelledOrderSuccessfully,
              context: context,
              success: true);
        }
        if (state is SuccessCancelProductState) {
          showMessageResponse(
              message: 'cancelled Product Successfully',
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
          appBar: cubit.orderModel != null&&
              cubit.allOrders.length > 0&&
              CacheHelper.getData(key: AppConstant.token,token: true)!=null?
              AppBar(
                surfaceTintColor: Colors.transparent,
            title:  Text(
              locale.orders,
              style:
              font.bodyLarge!.copyWith(fontSize: 22.sp),
            ),
          ):null,
            body: CacheHelper.getData(key: AppConstant.token,token: true)==null?
          GetStartScreen():
            cubit.orderModel != null &&
                state is! LoadingGetAllOrdersState
                ? RefreshIndicator(
              color: color.backgroundColor,
              backgroundColor: color.primaryColor,
              onRefresh: () async{
                cubit.getAllOrders();
              },
                  child: SafeArea(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding:  EdgeInsets.all(15.h),
                                    child: Column(
                                      children: [

                                        cubit.allOrders.length > 0 ?
                                        ListView.separated(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              double totalPrice = 0.0;
                                              List<Map<String, dynamic>> returnData = [];
                                              int productCount = 0;
                                              cubit.allOrders[index].orderItems!
                                                  .forEach((element) {
                                                totalPrice +=element.unitPrice*
                                                    element.quantity!;
                                                productCount += element.quantity!;
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
                                                    cubit.allOrders[index].orderItems!.forEach((element) {
                                                      if(element.status=="Cancelled"){
                                                        count++;
                                                      }

                                                    });
                                                    Helper.push(
                                                        context: context,
                                                      widget:   OrderDetailsScreen(
                                                        quantity:productCount ,
                                                        hideCancelOrder:count==cubit.allOrders[index].orderItems
                                                        !.length ,
                                                        returns: returnData,
                                                        currentIndex: index,
                                                        totalPrice: totalPrice,
                                                      ),withAnimate: true);
                                                  },
                                                  child: BuildCardOrderList(
                                                      returns:returnData,
                                                      status: cubit.allOrders[index].status!,
                                                      quantity:productCount,
                                                      createdAt: cubit.allOrders[index]
                                                          .createdAt!,
                                                      orderId: cubit.allOrders[index].id!,
                                                      totalPrice: totalPrice,
                                                      index: index)
                                              );
                                            },
                                            separatorBuilder: (context, index) =>
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                            itemCount: cubit.allOrders.length) :
                                       BuildEmptyOrder(),
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
