import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/order_details_screen/order_details_screen.dart';
import 'package:mham/views/order_screen/widget/card_order_list_component.dart';

class RecentPurchasesScreen extends StatelessWidget {
  const RecentPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return BlocBuilder<HomeCubit, HomeState>(
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
              title: Text('Your Recent Purchases'),
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
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                double totalPrice = 0.0;
                                cubit.recentPurchases[index].carts![0]
                                    .cartProducts!
                                    .forEach((element) {
                                  totalPrice += element.product!.price! *
                                      element.quantity!;
                                  cubit.cardProductDetails.add(false);
                                });
                                return InkWell(
                                    onTap: () {
                                      Helper.push(
                                          context,
                                          OrderDetailsScreen(
                                            currentIndex: index,
                                            returnOrder: true,
                                            hideNav: true,
                                            totalPrice: totalPrice,
                                          ));
                                    },
                                    child: BuildCardOrderList(
                                        returnOrder: true,
                                        status: cubit
                                            .recentPurchases[index].status!,
                                        quantity: cubit.recentPurchases.length,
                                        createdAt: cubit
                                            .recentPurchases[index].createdAt!,
                                        orderId: cubit
                                            .recentPurchases[index].orderId!,
                                        totalPrice: totalPrice,
                                        index: index));
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10.h,
                                  ),
                              itemCount: cubit.recentPurchases.length)
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
