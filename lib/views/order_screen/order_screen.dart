import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widget/card_order_list_component.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            body: cubit.orderModel != null
                ? SafeArea(
                  child: Padding(
                    padding:  EdgeInsets.all(20.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(locale.orders,style: font.bodyLarge!.copyWith(
                                fontSize: 22.sp
                              ),),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                double totalPrice = 0.0;
                                cubit.allOrders[index].carts![0].cartProducts!
                                    .forEach((element) {
                                  totalPrice +=
                                      element.product!.price! * element.quantity!;
                                  // cubit.cardProductDetails.add(false);
                                });
                                return InkWell(
                                    onTap: () {},
                                    child: BuildCardOrderList(
                                        totalPrice: totalPrice, index: index));
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10.h,
                                  ),
                              itemCount: cubit.allOrders.length),
                          SizedBox(height: 20.h,),
                        ],
                      ),
                    ),
                  ),
                )
                : Center(child: BuildImageLoader(assetName: ImageConstant.logo)));
      },
    );
  }
}
