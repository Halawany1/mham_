import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/helper/helper.dart';

class BuildOrderDetails extends StatelessWidget {
  const BuildOrderDetails({super.key,
    required this.currentIndex,

    required this.lenght,
    required this.createdAt,
    required this.status,
    required this.totalPrice,});

  final int currentIndex;
  final double totalPrice;
  final String createdAt;
  final String status;
  final int lenght;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: color.backgroundColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.orderDetails,
                  style: font.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Text(
                      Helper.formatDate(createdAt),
                      style: font.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      status,
                      style: font.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(
                      locale.quantity,
                      style: font.bodyMedium!.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 25.w,
                      height: 25.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: color.disabledColor),
                        borderRadius:
                        BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        lenght
                            .toString(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  children: [
                    Text(
                      locale.totalCost,
                      style: font.bodyMedium!.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        totalPrice.toStringAsFixed(2) +
                            ' ${locale.kd}',
                        style: font.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: color.backgroundColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
