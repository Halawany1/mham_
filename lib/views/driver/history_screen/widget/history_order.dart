import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/models/driver_order_model.dart';
import 'package:mham/views/driver/home_screen/widget/quantity_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class BuildHistoryOrder extends StatelessWidget {
  const BuildHistoryOrder({super.key,
    required this.index,
    required this.orders});
  final List<Orders> orders;
  final int index;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var locale = AppLocalizations.of(context);
    return Card(
      elevation: 4,
      shadowColor: LayoutCubit.get(context).theme==true?
      color.scaffoldBackgroundColor:Color(0xFF1F1F1F) ,
      color:  LayoutCubit.get(context).theme==true?
      color.scaffoldBackgroundColor:Color(0xFF1F1F1F),
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
            color: LayoutCubit.get(context).theme==true?
            color.scaffoldBackgroundColor:Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(20.r)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: color.backgroundColor,
              child: Text('${index+1}',style: font.bodyMedium,),
            ),
            SizedBox(width: 15.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Helper.
                trackingTimeFormat(orders[index].createdAt!),style: font.bodyMedium!.copyWith(
                    fontSize: 12.sp
                ),),
                Text('${orders[index].totalPrice!} ${locale.kd}',style: font.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    color: color.backgroundColor
                ),),
                Text(orders[index].status!,style: font.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.green
                ),),
              ],),
            Spacer(),
            BuildQuantityContainer(quantity:orders[index].orderItems!.length),
          ],
        ),
      ),
    );
  }
}
