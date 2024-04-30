import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCategory extends StatelessWidget {
  const BuildCategory({super.key,
    required this.text,
    required this.onTap,
    required this.image,
  });
  final String text;
  final VoidCallback onTap;
  final String image;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    final font = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
              width: 70.w,
              height: 70.w,
              image),
          Text(
            text,
            style: font.bodyMedium!
                .copyWith(
                fontSize: 12.sp,
                color: color.backgroundColor),
          )
        ],
      ),
    );
  }
}
