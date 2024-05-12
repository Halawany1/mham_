import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/driver/home_screen/widget/quantity_container.dart';
import 'package:mham/views/order_details_screen/order_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BuildCardOrderGrid extends StatelessWidget {
  const BuildCardOrderGrid({
    super.key,
    required this.index,

  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var cubit = OrderDriverCubit.get(context);
    return Card(
      elevation: 4,
      shadowColor: LayoutCubit.get(context).theme==true?
      color.scaffoldBackgroundColor:Color(0xFF1F1F1F) ,
      color:  LayoutCubit.get(context).theme==true?
      color.scaffoldBackgroundColor:Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Container(
        height: 230.h,
        width: 155.w,
        decoration: BoxDecoration(
          color:  LayoutCubit.get(context).theme==true?
          color.scaffoldBackgroundColor:Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38.r,
                    backgroundColor: color.backgroundColor,
                    child: Text(
                      (index+1).toString(),
                      style: font.bodyMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                Helper.formatDate(cubit.driverOrderModel!
                    .orders![index].createdAt!),
                overflow: TextOverflow.ellipsis,
                style: font.bodyMedium!.copyWith(fontSize: 15.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  cubit.driverOrderModel!.orders![index].totalPrice!.toStringAsFixed(2)+
                      ' ${locale.kd}',
                  style: font.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: color.backgroundColor),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.driverOrderModel!.orders![index].status!,
                    style: font.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: Colors.green),
                  ),
                 BuildQuantityContainer(quantity: 5),
                ],
              ),
              SizedBox(
                height:12.h,
              ),
            BuildDefaultButton(text: 'Take the order',
                height: 18.h,
                fontSize: 11.sp,
                onPressed: () {

                }, backgorundColor: color.backgroundColor
                , colorText: ColorConstant.brown)
            ],
          ),
        ),
      ),
    );
  }
}
