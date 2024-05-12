import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildSmallButton extends StatelessWidget {
  const BuildSmallButton({super.key,
    required this.text,
    this.edit=true,
    required this.onPressed,
    this.hieght=22,
    this.width=68,
    this.withIcon=true,
    this.icon,
  });
  final String text;
  final bool edit;
  final double hieght;
  final double width;
  final VoidCallback onPressed;
  final bool withIcon;
  final IconData ?icon;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return  SizedBox(
      width: width.w,
      child: MaterialButton(onPressed:onPressed,
        height: hieght.h,
        color: edit?color.primaryColor:Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(withIcon)
                Icon(
                  icon,
                  size: 12.sp,
                  color: color.cardColor,
                ),
              if(withIcon)
                SizedBox(
                  width: 10.w,
                ),
              Text(
                text,
                style: font.bodyMedium!.copyWith(
                    fontSize: 14.sp, color: color.cardColor),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
