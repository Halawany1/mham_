import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/card_order_gird_component.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';

class AssignOrdersDriverScreen extends StatelessWidget {
  const AssignOrdersDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    if (OrderDriverCubit.get(context).assignOrderModel == null) {
      OrderDriverCubit.get(context).getAssignedOrder(
          driverId: CacheHelper.getData(key: AppConstant.driverId));
    }

    return BlocBuilder<OrderDriverCubit, OrderDriverState>(
      builder: (context, state) {
        var cubit = OrderDriverCubit.get(context);
        return Scaffold(
          appBar: topAppBar(context),
          body:
              cubit.emptyTimeLineAndAssign?
                  Center(child: Text(locale.noOrdersFound))
                  :
          cubit.assignOrderModel == null
              ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: RefreshIndicator(
                      color: color.backgroundColor,
                      backgroundColor: color.primaryColor,
                      onRefresh: () async{
                        OrderDriverCubit.get(context).getAssignedOrder(
                            driverId: CacheHelper.getData(key: AppConstant.driverId));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                                        Padding(
                      padding: EdgeInsets.all(15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.assignOrder,
                            style: font.bodyMedium,
                          ),
                        ],
                      ),
                                        ),
                                        Padding(
                      padding: EdgeInsets.all(12.h),
                      child: GestureDetector(
                        onTap: () async {
                          cubit.getOrderById(
                              id: cubit.assignOrder[0]
                                  .id!);
                          Helper.push(
                              context: context,
                              widget: OrderDetailsDriverScreen(
                              ));
                        },
                        child: SizedBox(
                          height: 200.h,
                          child: BuildCardOrderGrid(
                            index: 0,
                            assigned: true,
                            orders:cubit.assignOrder,),
                        ),
                      ),
                                        ),
                                        ]),
                    ),
                                    ),
                ),
        );
      },
    );
  }
}
