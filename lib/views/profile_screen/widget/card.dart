import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildCards extends StatelessWidget {
  const BuildCards({super.key,
    required this.icon,
    required this.text,
     this.logout=false,
     this.dark=false,
    required this.onTap,});
  final IconData icon;
  final String text;
  final bool logout;
  final VoidCallback onTap;
  final bool dark;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return  GestureDetector(
      onTap: onTap,
      child: Card(
        color: logout?color.backgroundColor:  color.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 3.5,
        child: Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            color: logout?color.backgroundColor:  color.cardColor,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 18.w,),
              Icon(icon,
                color: dark?color.scaffoldBackgroundColor:color.primaryColor,),
              SizedBox(width: 15.w,),
              Text(text,
                style: font.bodyLarge!.copyWith(fontSize: 16.sp,
                  color: dark?color.scaffoldBackgroundColor:color.primaryColor
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
