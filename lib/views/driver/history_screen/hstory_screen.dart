import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/driver/history_screen/widget/history_order.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';


class HistoryDriverScreen extends StatelessWidget {
  const HistoryDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var layoutCubit = LayoutCubit.get(context);
    return BlocBuilder<OrderDriverCubit, OrderDriverState>(
      builder: (context, state) {
        var cubit = OrderDriverCubit.get(context);
        return Scaffold(
          appBar: cubit.driverOrderModel == null ||
              state is LoadingGetAllOrdersState?null:
            topAppBar(context),
          body:cubit.driverOrderModel == null ||
              state is LoadingGetAllOrdersState?
              Center(child: BuildImageLoader(assetName:
              ImageConstant.logo))
         : 
          cubit.historyOrders.isEmpty?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.history, size: 60.sp,
                        color: color.primaryColor.withOpacity(0.7)),
                    SizedBox(height: 20.h,),
                    Text('${locale.noOrdersFound}',
                        style: font.bodyMedium,
                        textAlign: TextAlign.center),
                  ],
                ),
              )
              :
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        locale.history,
                        style: font.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          showMenu<String>(
                            context: context,
                            position: RelativeRect.fromLTRB(
                                layoutCubit.lang == 'en' ? 120.w : 30.w,
                                170.h,
                                layoutCubit.lang == 'en' ? 30.w : 120.w,
                                0),
                            elevation: 5,
                            color: color.scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            items: [],
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.filter,
                          color: color.backgroundColor,
                        ),
                      )
                    ],
                  ),
                ),


                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h,),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.historyOrders.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            cubit.getOrderById(
                                id: cubit
                                    .historyOrders[index].id!);
                            Helper.push(
                                context: context,
                                widget:
                                OrderDetailsDriverScreen(closeDetails: true,));
                          },
                          child: BuildHistoryOrder(index: index,
                          orders: cubit.historyOrders,),
                        );
                      }),
                )

              ],
            ),
          ),
        );
      },
    );
  }

}
