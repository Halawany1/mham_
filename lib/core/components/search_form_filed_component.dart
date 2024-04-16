

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/views/home_screen/home_screen.dart';

class BuildSearchFormField extends StatelessWidget {
  const BuildSearchFormField({super.key,
   this.readOnly=false,
     this.onSave,
     this.onTap,
  });
  final bool readOnly;
  final void Function(String?) ?onSave;
  final VoidCallback ?onTap;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);

    return  SizedBox(
      height: 32.h,
      width: 245.w,
      child: TextFormField(
        readOnly: readOnly,
        style: TextStyle(
          color: color.cardColor.withOpacity(0.75),
          fontSize: 15.sp,
        ),
        onChanged: onSave,
        onTap: onTap,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none),
            prefixIcon: Icon(
              FontAwesomeIcons.search,
              color: color.cardColor.withOpacity(0.75),
              size: 15.sp,
            ),
            hintText: 'Search',
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10.w),
            hintStyle: font.bodyMedium!.copyWith(
                fontSize: 15.sp,
                color: color.cardColor.withOpacity(0.75)),
            filled: true,
            fillColor: color.hoverColor),
      ),
    );
  }
}
