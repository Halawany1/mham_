import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildQuantityContainer extends StatelessWidget {
  const BuildQuantityContainer({super.key, required this.quantity});
  final int quantity;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return  Container(
      alignment: Alignment.center,
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        border: Border.all(color: color.primaryColor),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        quantity.toString(),
        style: font.bodyMedium!.copyWith(
          fontSize: 15.sp
        ),
      ),
    );
  }
}
