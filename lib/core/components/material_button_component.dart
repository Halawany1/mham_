import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDefaultButton extends StatelessWidget {
  const BuildDefaultButton({super.key,
    required this.text,
    required this.onPressed,
    required this.backgorundColor,
    required this.colorText,
     this.width=double.infinity,
     this.height=42,
     this.fontSize=20,
     this.borderRadius=20,
     this.withBorder=false,
  });
  final String text;
  final VoidCallback ?onPressed;
  final double width;
  final double borderRadius;
  final double height;
  final double fontSize;
  final Color colorText;
  final Color backgorundColor;
  final bool withBorder;
  @override
  Widget build(BuildContext context) {
    var color =Theme.of(context);
    var font =Theme.of(context).textTheme;
    return SizedBox(
      width: width.w,
      height: height.h,
      child: MaterialButton(
        height: height.h,
        minWidth: width.w,
        shape: RoundedRectangleBorder(
          side: withBorder?
          BorderSide(color: color.primaryColor):BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        color: backgorundColor,
        onPressed:onPressed,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(text,style: font.titleMedium!.copyWith(
            fontSize: fontSize.sp,
            color: colorText
          ),),
        ),
      ),
    );
  }
}
