import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/transiaction_cubit/transiaction_cubit.dart';
import 'package:mham/core/helper/helper.dart';

class BuildCardRefunds extends StatelessWidget {
  const BuildCardRefunds({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var cubit = TransiactionCubit.get(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50.w,
          width: 50.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color.backgroundColor,
              borderRadius: BorderRadius.circular(8.r)
          ),
          child:CircleAvatar(
            backgroundColor: color.cardColor,
            radius: 15.r,
            child: Icon(CupertinoIcons.arrow_up_right,
              color: color.backgroundColor,),
          ),
        ),
        SizedBox(width: 12.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${cubit.refundsModel!
                .refunds![index].userOrder!.totalPrice} '+locale.kd,
              style: font.bodyMedium!.copyWith(
                  fontSize: 16.sp,
                  color: color.backgroundColor,
                  fontWeight: FontWeight.bold
              ),),
            Text(Helper.formatTimeString(cubit.refundsModel!
                .refunds![index].userOrder!.createdAt!),
              style: font.bodySmall!,),

          ],
        ),
      ],);
  }
}
