import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextAndLinkRow extends StatelessWidget {
  const BuildTextAndLinkRow({super.key,
    required this.text,
    required this.textLink,
    required this.onTap,
    this.smallText = false,

  });

  final String text;
  final String textLink;
  final bool smallText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
          style: font.bodyMedium!
              .copyWith(fontSize: smallText ? 11.sp : 14.sp),),
        SizedBox(width: 5.w,),
        InkWell(
          onTap:onTap,
          child: Text(textLink,
            style: font.titleMedium!
                .copyWith(fontSize: smallText ? 11.sp : 12.sp),),
        )
      ],);
  }
}
