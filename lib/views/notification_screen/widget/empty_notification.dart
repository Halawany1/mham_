import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/constent/image_constant.dart';

class BuildEmptyNotification extends StatelessWidget {
  const BuildEmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.noNotification,
            width: 60.w,
            height: 60.h,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            textAlign: TextAlign.center,
            'We have no updates.\n Please Check again later.',
            style: font.bodyMedium!.copyWith(
              height: 1.2.h,
                fontSize: 15.sp,
                color: color.primaryColor.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
