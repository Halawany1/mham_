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
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:mham/views/order_screen/widget/empty_order.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var layoutCubit = LayoutCubit.get(context);

    print(CacheHelper.getData(key: AppConstant.driverId));
    if (OrderDriverCubit.get(context).driverOrderModel == null) {
      OrderDriverCubit.get(context).getAllOrders();
    }
    return BlocConsumer<OrderDriverCubit, OrderDriverState>(
      listener: (context, state) {
        if (state is SuccessTakeTheOrderState) {
          showMessageResponse(
              message: 'Take Order Successfully',
              context: context,
              success: true);
        }
        if (state is ErrorTakeTheOrderState) {
          showMessageResponse(
              message: state.error, context: context, success: false);
        }
      },
      builder: (context, state) {
        var cubit = OrderDriverCubit.get(context);
        return Scaffold(
          appBar: cubit.driverOrderModel == null ||
                  state is LoadingGetAllOrdersState
              ? null
              : topAppBar(context),
          body: cubit.driverOrderModel == null ||
                  state is LoadingGetAllOrdersState
              ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        OrderDriverCubit.get(context).getAllOrders();

                      },
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locale.orders,
                                style: font.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showMenu<String>(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                        layoutCubit.lang == 'en' ? 120.w : 20.w,
                                        120.h,
                                        layoutCubit.lang == 'en' ? 20.w : 120.w,
                                        0),
                                    elevation: 5,
                                    color: color.scaffoldBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    items: cubit.filter.map((item) {
                                      return PopupMenuItem<String>(
                                        value: item,
                                        child: Container(
                                          width: 140.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  if (item == cubit.filter[0]) {
                                                    cubit.getAllOrders();
                                                  }
                                                  if (item == cubit.filter[1] ||
                                                      item == cubit.filter[2]) {
                                                    cubit.getAllOrders(
                                                        status: item);
                                                  }
                                                  if (item == cubit.filter[3]) {
                                                    cubit.getAllOrders(
                                                        sort: 'DtotalPrice');
                                                  }
                                                  if (item == cubit.filter[4]) {
                                                    cubit.getAllOrders(
                                                        sort: 'AtotalPrice');
                                                  }
                                                  if (item == cubit.filter[5]) {
                                                    cubit.getAllOrders(
                                                        inCountry: true);
                                                  } else if (item ==
                                                      cubit.filter[6]) {
                                                    cubit.getAllOrders(
                                                        inCountry: false);
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  item,
                                                  style: font.bodyMedium!
                                                      .copyWith(fontSize: 14.sp),
                                                ),
                                              ),
                                              if (item != cubit.filter[6])
                                                Divider(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
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
                        if (cubit.driverOrders.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(bottom: 110.h),
                            child: BuildEmptyOrder(
                              withoutButton: true,
                            ),
                          ),
                        if (cubit.driverOrders.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.all(12.h),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.driverOrders.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10.h,
                                        crossAxisSpacing: 10.w,
                                        mainAxisExtent: 220.h),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      cubit.getOrderById(
                                          id: cubit.driverOrders[index].id!);
                                      Helper.push(
                                          context: context,
                                          widget: OrderDetailsDriverScreen());
                                    },
                                    child: BuildCardOrderGrid(
                                      index: index,
                                      orders: cubit.driverOrders,
                                    ),
                                  );
                                }),
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
