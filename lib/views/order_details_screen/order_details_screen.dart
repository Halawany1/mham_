import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/order_details_screen/widget/card_product_details.dart';
import 'package:mham/views/order_details_screen/widget/order_details.dart';
import 'package:mham/views/order_details_screen/widget/tracking_order.dart';


class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.currentIndex,
    required this.totalPrice,
    required this.quantity,
    required this.returns,
    this.hideNav = false,
    this.returnOrder = false,
    this.hideCancelOrder = false,
  });

  final int currentIndex;
  final int quantity;
  final double totalPrice;
  final bool hideNav;
  final bool returnOrder;
  final List<Map<String, dynamic>> returns;
  final bool hideCancelOrder;

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
                    cubit.allOrders[currentIndex].createdAt!),
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
          subtitle: cubit.allOrders[currentIndex].deliveredAt != null &&
                  cubit.allOrders[currentIndex].processingAt != null
              ? StepperText(
                  locale.orderPrepared +
                      Helper.trackingTimeFormat(
                          cubit.allOrders[currentIndex].processingAt!),
                  textStyle: font.bodySmall!.copyWith(color: Colors.grey))
              : null,
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: cubit.allOrders[currentIndex].deliveredAt != null ||
                        cubit.allOrders[currentIndex].processingAt != null
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('2',
                style: font.bodyMedium!.copyWith(
                    color: cubit.allOrders[currentIndex].deliveredAt != null
                        ? ColorConstant.brown
                        : Colors.grey)),
          )),
      StepperData(
          title: StepperText(locale.shipped, textStyle: font.bodyMedium),
          subtitle: cubit.allOrders[currentIndex].deliveredAt != null &&
                  cubit.allOrders[currentIndex].shippedAt != null
              ? StepperText(
                  textStyle: font.bodySmall!.copyWith(color: Colors.grey),
                  locale.deliverItem +
                      Helper.trackingTimeFormat(
                          cubit.allOrders[currentIndex].shippedAt!))
              : null,
          iconWidget: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: cubit.allOrders[currentIndex].deliveredAt != null ||
                        cubit.allOrders[currentIndex].shippedAt != null
                    ? color.backgroundColor
                    : Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15.r))),
            child: Text('3',
                style: font.bodyMedium!.copyWith(
                    color: cubit.allOrders[currentIndex].deliveredAt != null
                        ? ColorConstant.brown
                        : Colors.grey)),
          )),
      StepperData(
        iconWidget: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: cubit.allOrders[currentIndex].deliveredAt != null
                  ? Border.all(color: color.primaryColor)
                  : null,
              color: cubit.allOrders[currentIndex].deliveredAt != null
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
          if(state is NoInternetHomeState){
            showMessageResponse(message: locale.noInternetConnection,
                context: context, success: false);
          }
          if (state is SuccessCancelProductState) {
            cubit.cardProductDetails.clear();
            cubit.trackingContainer = false;
            cubit.getAllOrders();
            Navigator.pop(context);
          }
          if(state is SuccessCancelOrderState){
            cubit.cardProductDetails.clear();
            cubit.trackingContainer = false;
            cubit.getAllOrders();
            Navigator.pop(context);
          }
          if (state is ErrorCancelProductState) {
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
            body:state is LoadingCreateOrderState ||
                state is LoadingGetAllOrdersState?
              Center(child: BuildImageLoader(assetName: ImageConstant.logo))
              :SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      BuildOrderDetails(
                          lenght: quantity,
                          createdAt: cubit.allOrders[currentIndex].createdAt!,
                          status: cubit.allOrders[currentIndex].status!,
                          totalPrice: totalPrice),
                      SizedBox(
                        height: 20.h,
                      ),
                      BuildTrackingOrder(
                          activeProcess:cubit.allOrders[currentIndex]
                              .processingAt!=null?2:
                          cubit.allOrders[currentIndex]
                              .shippedAt!=null?3:cubit.allOrders[currentIndex].createdAt!=null?
                          1:0,
                          createdAt: cubit.allOrders[currentIndex].createdAt!,
                          orderId: cubit.allOrders[currentIndex].id!,
                          stepperData: stepperData,
                          totalPrice: totalPrice),
                      SizedBox(
                        height: 20.h,
                      ),
                      if(cubit.allOrders[currentIndex].orderItems!.length>0)
                      Text(
                        locale.productDetails,
                        style: font.bodyLarge!.copyWith(fontSize: 22.sp),
                      ),
                      if(cubit.allOrders[currentIndex].orderItems!.length>0)
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
                                  .orderItems![index]
                                  .product!
                                  .availableYears !=
                              null) {
                            cubit.allOrders[currentIndex].orderItems
                            ![index].product!.availableYears!
                                .forEach((element) {
                              carModels.add(element.carModel!.car!.carName! +
                                  ' ' +
                                  element.carModel!.modelName! +
                                  ' ' +
                                  element.availableYear.toString());
                            });
                          }
                          List<String> quantities = [];

                          cubit.allOrders.forEach((element) {
                            cubit.cardProductDetails.add(false);
                          });
                          int returnQuantity = 0;
                          cubit.allOrders[currentIndex].orderItems
                          ![index].returnProducts!
                              .forEach((element) {
                            returnQuantity += element.quantity!;
                          });
                          for (int i = 1;
                              i <=
                                  cubit.allOrders[currentIndex].orderItems![index]
                                      .quantity! -
                                      returnQuantity;
                              i++) {
                            quantities.add(i.toString());
                          }
                          return BuildCardProductDetails(
                            hideCancelOrder: hideCancelOrder,
                              returnQuantity: returnQuantity,
                              quantity: quantities,
                              onTap: () {
                                cubit.openAndCloseCardProductDetails(index);
                              },
                              carModels: carModels,
                              returnProduct: returnOrder,
                              opened: cubit.cardProductDetails[index],
                              index: index,
                              orders: cubit.allOrders[currentIndex]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.h,
                        ),
                        itemCount: cubit.allOrders[currentIndex].orderItems!.length,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      state is LoadingCancelOrderState
                          ? Center(
                              child: CircularProgressIndicator(
                              color: color.primaryColor,
                            ))
                          : BuildDefaultButton(
                              text: locale.cancelOrder,
                              width: 120.w,
                              height: 26.h,
                              fontSize: 13.sp,
                              borderRadius: 8.r,
                              onPressed: () {
                                if(!hideCancelOrder) {
                                  cubit.cancelOrder(
                                      id: cubit.allOrders[currentIndex].id!);
                                }

                              },
                              backgorundColor:hideCancelOrder?
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
