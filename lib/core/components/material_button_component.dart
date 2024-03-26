import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildDefaultButton extends StatelessWidget {
  const BuildDefaultButton({super.key,
    required this.text,
    required this.onPressed,
     this.width=double.infinity,
  });
  final String text;
  final VoidCallback onPressed;
  final double width;
  @override
  Widget build(BuildContext context) {
    var color =Theme.of(context);
    var font =Theme.of(context).textTheme;
    return MaterialButton(
      height: 42.h,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      color: color.primaryColor,
      onPressed:onPressed,
      child: Text(text,style: font.titleMedium,),
    );
  }
}
