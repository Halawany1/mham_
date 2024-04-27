import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildCardNotification extends StatelessWidget {
  const BuildCardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: color.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 5.w,),
          CircleAvatar(
            radius: 30.r,
            backgroundColor: color.primaryColor,
            child: Icon(
              size: 40.sp,
              Icons.wallet,
              color: color.backgroundColor,
            ),
          ),
          SizedBox(width: 20.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 185.w,
                    child: Text('200 KD have been added to your wallet. Check it right now.',
                      style: font.bodyMedium!.copyWith(
                          fontSize: 15.sp
                      ),),
                  ),
                  Icon(FontAwesomeIcons.remove,
                    color: color.primaryColor.withOpacity(0.8),)
                ],
              ),
              SizedBox(height: 5.h,),
              Text('15 minutes ago',style: font.bodyMedium!.copyWith(
                fontSize: 12.sp,
                color: color.primaryColor.withOpacity(0.6),
              ),)
            ],)
        ],
      ),
    );
  }
}
