import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/views/driver/home_screen/widget/quantity_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class BuildHistoryOrder extends StatelessWidget {
  const BuildHistoryOrder({super.key});

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
              child: Text('1',style: font.bodyMedium,),
            ),
            SizedBox(width: 15.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('12 Apr, 3:58 Pm',style: font.bodyMedium!.copyWith(
                    fontSize: 12.sp
                ),),
                Text('1000 KD',style: font.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    color: color.backgroundColor
                ),),
                Text('Delivered',style: font.bodyMedium!.copyWith(
                    fontSize: 12.sp,
                    color: Colors.green
                ),),
              ],),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BuildQuantityContainer(quantity: 3),
                SizedBox(width: 10.w,),
                BuildDefaultButton(text: locale.moreDetails,
                    width: 80.w,
                    height: 18.h,
                    borderRadius: 12.r,
                    fontSize: 8.sp,
                    onPressed: () {

                    }, backgorundColor: color.primaryColor,
                    colorText: color.cardColor)
              ],)
          ],
        ),
      ),
    );
  }
}
