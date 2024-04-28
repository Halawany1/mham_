import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:rating_summary/rating_summary.dart';

class BuildRatingSummary extends StatelessWidget {
  const BuildRatingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    var font = Theme.of(context).textTheme;
    return  RatingSummary(
      counter: cubit.oneProductModel!.product!
          .rateCount ==
          0
          ? 1
          : cubit
          .oneProductModel!.product!.rateCount!,
      average: cubit.oneProductModel!.product!
          .averageRate ==
          null
          ? 0
          : cubit.oneProductModel!.product!
          .averageRate!
          .toDouble(),
      averageStyle: font.bodyMedium!
          .copyWith(fontSize: 19.sp),
      showAverage: true,
      backgroundColor: Colors.grey.shade400,
      counterFiveStars: cubit
          .oneProductModel!
          .product!
          .ratePercentage!
          .fiveStar ==
          null
          ? 0
          : cubit.oneProductModel!.product!
          .ratePercentage!.fiveStar!
          .toInt(),
      counterFourStars: cubit
          .oneProductModel!
          .product!
          .ratePercentage!
          .fourStar ==
          null
          ? 0
          : cubit.oneProductModel!.product!
          .ratePercentage!.fourStar!
          .toInt(),
      counterThreeStars: cubit
          .oneProductModel!
          .product!
          .ratePercentage!
          .threeStar ==
          null
          ? 0
          : cubit.oneProductModel!.product!
          .ratePercentage!.threeStar!
          .toInt(),
      counterTwoStars: cubit
          .oneProductModel!
          .product!
          .ratePercentage!
          .twoStar ==
          null
          ? 0
          : cubit.oneProductModel!.product!
          .ratePercentage!.twoStar!
          .toInt(),
      counterOneStars: cubit
          .oneProductModel!
          .product!
          .ratePercentage!
          .oneStar ==
          null
          ? 0
          : cubit.oneProductModel!.product!
          .ratePercentage!.oneStar!
          .toInt(),
    );
  }
}

