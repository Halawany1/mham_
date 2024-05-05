import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/helper/helper.dart';

class BuildCardNotification extends StatelessWidget {
  const BuildCardNotification({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: color.primaryColor
            .withOpacity(cubit.notifications[index].isReaded! ? 0.12 : 0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: color.primaryColor,
                child: Icon(
                  size: 35.sp,
                  FontAwesomeIcons.bell,
                  color: color.backgroundColor,
                ),
              ),
              if (!cubit.notifications[index].isReaded!)
                CircleAvatar(
                  radius: 8.r,
                  backgroundColor: color.backgroundColor,
                )
            ],
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 210.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: Text(
                        cubit.notifications[index].title!,
                        style: font.bodyLarge!.copyWith(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 185.w,
                    child: Text(
                      cubit.notifications[index].body!,
                      style: font.bodyMedium!.copyWith(fontSize: 15.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                Helper.formatTimeString(cubit.notifications[index].createdAt!),
                style: font.bodyMedium!.copyWith(
                  fontSize: 12.sp,
                  color: color.primaryColor.withOpacity(0.6),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
