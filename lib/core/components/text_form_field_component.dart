import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.cubit,
    required this.validator,
    required this.keyboardType,
    required this.maxLength,
    this.withSuffixIcon = false,
    this.visibleTwo = false,
    this.width=double.infinity,
  });

  final String hint;
  final String title;
  final int maxLength;
  final TextEditingController controller;
  final bool withSuffixIcon;
  final String? Function(String?)? validator;
  final bool visibleTwo;
  final AuthenticationCubit cubit;
  final TextInputType keyboardType;
  final double width;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: font.labelMedium,
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          width:width ,
          child: TextFormField(
            validator: validator,
            keyboardType: keyboardType,
            maxLength: maxLength,
            controller: controller,
            obscureText: withSuffixIcon?
            visibleTwo?!cubit.visibleTwo:!cubit.visibleOne:false,
            style: TextStyle(fontSize: 14.sp),
            cursorHeight: 20.h,
            decoration: InputDecoration(
              counterText: '',
                suffixIcon: withSuffixIcon
                    ? InkWell(
                  onTap: () {
                    if(visibleTwo){
                      cubit.changeVisible(false);
                    }else{
                      cubit.changeVisible(true);
                    }
                  },
                  child: Icon(
                    visibleTwo?
                    !cubit.visibleTwo?
                    FontAwesomeIcons.eyeLowVision:FontAwesomeIcons.eye:
                    !cubit.visibleOne?
                    FontAwesomeIcons.eyeLowVision:FontAwesomeIcons.eye ,
                    size: 18.sp,
                  ),
                )
                    : null,
                hintText: hint,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.r),
                )),
          ),
        )
      ],
    );
  }
}
