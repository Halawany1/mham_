import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCardReviews extends StatelessWidget {
  const BuildCardReviews({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      height: 98.h,
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
              'A',
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
                    Text(
                      'Ahmed Mohamed',
                      style: font.bodyMedium,
                    ),
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: 4,
                      minRating: 4,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      maxRating: 4,
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
                  'Lorem ipsum dolor sit amet consectetur.',
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
