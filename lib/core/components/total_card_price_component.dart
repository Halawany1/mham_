
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class BuildTotalCardPrice extends StatelessWidget {
  const BuildTotalCardPrice({super.key,
  required this.lenghtItems,
  required this.totalPrice,
  required this.totalPriceWithShippingFee,
  });

  final int lenghtItems;
  final double totalPrice;
  final double totalPriceWithShippingFee;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);

    return  Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        width: double.infinity,
        height: 120.h,
        decoration: BoxDecoration(
          color: color.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    locale.subTotal,
                    style: font.bodyMedium!
                        .copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    '($lenghtItems items)',
                    style: font.bodyMedium!.copyWith(
                        fontSize: 10.sp,
                        color: color.primaryColor
                            .withOpacity(0.5)),
                  ),
                  Spacer(),
                  Text(
                  totalPrice.toStringAsFixed(2) +
                        ' ${locale.kd}',
                    style: font.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    locale.shippingFee,
                    style: font.bodyMedium!
                        .copyWith(fontSize: 12.sp),
                  ),
                  Spacer(),
                  Text(
                    '10' + ' ${locale.kd}',
                    style: font.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Divider(),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Text(
                    locale.total,
                    style: font.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                  Spacer(),
                  Text(
                    totalPriceWithShippingFee.toStringAsFixed(2) +
                        ' ${locale.kd}',
                    style: font.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
