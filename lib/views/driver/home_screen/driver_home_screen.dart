import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/card_order_gird_component.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var layoutCubit = LayoutCubit.get(context);
    return BlocBuilder<OrderDriverCubit, OrderDriverState>(
      builder: (context, state) {
        var cubit = OrderDriverCubit.get(context);
        return Scaffold(
          body: cubit.driverOrderModel == null
              ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
              : SafeArea(
                  child: Center(
                      child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      BuildTopAppBarInDriver(),
                      SizedBox(
                        height: 10.h,
                      ),
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
                                color: color.primaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.h),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.driverOrderModel!.orders!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w,
                                    mainAxisExtent: 220.h),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  print(cubit
                                      .driverOrderModel!.orders![index].id!);
                                  cubit.getOrderById(
                                      id: cubit
                                          .driverOrderModel!.orders![index].id!);
                                  Helper.push(
                                      context: context,
                                      widget: OrderDetailsDriverScreen(index: index,));
                                },
                                child: BuildCardOrderGrid(index: index),
                              );
                            }),
                      )
                    ]),
                  )),
                ),
        );
      },
    );
  }
}
