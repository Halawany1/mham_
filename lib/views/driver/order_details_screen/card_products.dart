import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/go_link_row_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/views/driver/order_details_screen/check_box_list_tile.dart';

var reasonController = TextEditingController();

class BuildCardProductDetailsForDriver extends StatelessWidget {
  const BuildCardProductDetailsForDriver({
    super.key,
    required this.opened,
     this.index,
    this.notClosed = false,
  });

  final bool opened;
  final bool notClosed;
  final int ?index;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<OrderDriverCubit, OrderDriverState>(
      builder: (context, state) {
        var cubit = context.read<OrderDriverCubit>();
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: color.backgroundColor),
              borderRadius:notClosed?
              BorderRadius.circular(18.r)
              :BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.openAndCloseDetailsProduct();
                  },
                  child: Container(
                    width: double.infinity,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 220.w,
                            height: 45.h,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.asset(
                                    'assets/images/product.png',
                                    height: 80.h,
                                    width: 80.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  left: 5.w,
                                  top: 2.h,
                                  child: SizedBox(
                                    width: 35.w,
                                    height: 16.w,
                                    child: BuildContainerType(
                                      type: cubit.driverOrderByIdModel!.order!.orderItems![index!].product!.type!,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 90.w,
                                  child: SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      cubit.driverOrderByIdModel!.order!.orderItems![index!].product!.productsName!,
                                      style: font.bodyMedium!.copyWith(
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 90.w,
                                  top: 25.h,
                                  child: SizedBox(
                                    width: 85.w,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        cubit.driverOrderByIdModel!.order!.orderItems![index!].product!.price!.toString() + ' ${locale.kd}',
                                        style: font.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp,
                                            color: color.backgroundColor),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 200.w,
                                  top: 25.h,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 20.w,
                                    height: 20.w,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: color.primaryColor),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      style: font.bodyMedium!
                                          .copyWith(fontSize: 13.sp),
                                      5.toString(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (!notClosed)
                            Icon(
                              !opened
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down_outlined,
                              color: color.backgroundColor,
                            ),
                          if (notClosed)
                            Text(
                              cubit.driverOrderByIdModel!.order!.orderItems![index!].product!.status!,
                              style: font.bodyMedium!.copyWith(
                                color: Colors.green,
                                fontSize: 12.sp
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                if (opened)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),
                      SizedBox(
                        height: 10.h,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.6,
                        ),
                        itemBuilder: (context, index) => BuildCheckBoxListTile(
                          text: cubit.checkboxListTiles[index].title,
                          value: cubit.checkboxListTiles[index].value,
                          changeValue: (value) {
                            cubit.changeCheckboxListTile(
                                index: index, value: value!);
                          },
                        ),
                      ),
                      if (cubit.checkboxListTiles[0].value ||
                          cubit.checkboxListTiles[1].value)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: color.backgroundColor,
                                  radius: 5.r,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Trader Information',
                                  style: font.bodyLarge!.copyWith(
                                      fontSize: 15.sp,
                                      color: color.backgroundColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 5.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.driverOrderByIdModel!.order!.customer!.userName!,
                                    style: font.bodyMedium!
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    cubit.driverOrderByIdModel!.order!.customer!.mobile!,
                                    style: font.bodyMedium!
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    cubit.driverOrderByIdModel!.order!.address!,
                                    style: font.bodyMedium!
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  BuildGoToLinkRow(),
                                ],
                              ),
                            )
                          ],
                        ),
                      SizedBox(
                        height: 12.h,
                      ),
                      BuildDefaultButton(
                          text: locale.cancelItem,
                          width: 100.w,
                          height: 26.h,
                          fontSize: 12.sp,
                          borderRadius: 8.r,
                          onPressed: () {},
                          backgorundColor: color.backgroundColor,
                          colorText: ColorConstant.brown)
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
