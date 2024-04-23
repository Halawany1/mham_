import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';

class BuildCardReviews extends StatelessWidget {
  const BuildCardReviews({super.key,required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var cubit= HomeCubit.get(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: color.primaryColor.withOpacity(0.1)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: color.primaryColor,
            child: Text(
              cubit.oneProductModel!.product!.productRating![index].user!.userName![0],
              style: font.bodyLarge!
                  .copyWith(color: color.cardColor),
            ),
          ),
          SizedBox(
            width: 10.h,
          ),
          SizedBox(
            width: 220.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          cubit.oneProductModel!.product!.productRating![index].user!.userName!,
                          style: font.bodyMedium,
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: cubit.oneProductModel!.product!.productRating![index].ratingNum!
                          .toDouble(),
                      minRating: cubit.oneProductModel!.product!.productRating![index].ratingNum!
                          .toDouble(),
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: color.highlightColor
                          .withOpacity(0.8),
                      itemSize: 12.sp,
                      itemBuilder: (context, _) =>
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {},
                      tapOnlyMode: true,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  cubit.oneProductModel!.product!.productRating!
                  [index].review??'No Review',
                  style: font.bodyMedium!
                      .copyWith(fontSize: 12.sp),
                ),
                SizedBox(height: 2.h,),
                Text(
                  '5 Apr, 3:35',
                  style: font.bodyMedium!.copyWith(
                      fontSize: 10.sp,
                      color: color.primaryColor
                          .withOpacity(0.5)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
