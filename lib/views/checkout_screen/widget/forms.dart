import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildFormCheckout extends StatelessWidget {
  const BuildFormCheckout({
    super.key,
    required this.hint,
    required this.inputType,
    required this.title,
    required this.controller,
    required this.validator,
     this.suffixIcon,
     this.widthForm=double.infinity,
  });

  final String hint;
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Icon ?suffixIcon;
  final double widthForm;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: font.bodyMedium!.copyWith(fontSize: 16.sp),
        ),
        SizedBox(
          width: widthForm.w,
          child: TextFormField(
            style: font.bodyMedium,
            cursorColor: color.primaryColor,
            controller: controller,
            validator: validator,
            keyboardType: inputType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 5.h),
              suffixIcon: suffixIcon,
            isDense: true,
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: color.primaryColor.withOpacity(0.2))),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: color.primaryColor.withOpacity(0.2))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color.primaryColor)),
              hintText: hint,
            ),
          ),
        )
      ],
    );
  }
}
