import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildContainerType extends StatelessWidget {
  const BuildContainerType({super.key,
    required this.type
  });

  final String type;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.backgroundColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 5.w, vertical: 2.h),
        child: Text(
          type,
          style: font.bodyMedium!
              .copyWith(fontSize: 10.sp),
        ),
      ),
    );
  }
}
