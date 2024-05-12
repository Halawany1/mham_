import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCheckBoxListTile extends StatelessWidget {
  const BuildCheckBoxListTile({super.key,

    required this.text,
    required this.value,
    required this.changeValue,});
  final String text;
  final bool value;
  final void Function(bool?) changeValue;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return  SizedBox(
      width: 140.w,
      child: ListTileTheme(
        horizontalTitleGap: 0,
        child: CheckboxListTile(
          value: value,
          contentPadding: EdgeInsets.zero,
          activeColor: color.backgroundColor,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            text,
            style: font.bodyMedium!.copyWith(fontSize: 15.sp),
          ),
          onChanged: changeValue,
        ),
      ),
    );
  }
}

