import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/models/user_model.dart';

class BuildFormUnderLine extends StatelessWidget {
  const BuildFormUnderLine({
    super.key,
    required this.hint,
    required this.inputType,
    required this.title,
    required this.controller,
    required this.validator,
     this.suffixIcon,
     this.widthForm=double.infinity,
     this.phone=false,
  });

  final String hint;
  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Icon ?suffixIcon;
  final double widthForm;
  final TextInputType inputType;
  final bool phone;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var cubit = AuthenticationCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: font.bodyMedium!.copyWith(fontSize: 15.sp),
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
              prefixIcon:phone?
              DropdownButton<CountryId>(
                value: cubit.selectedCountry != null
                    ? cubit.selectedCountry
                    :LayoutCubit.get(context).lang=='en'?
                cubit.countries[7]:cubit.countriesAr[7],
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (CountryId? newValue) {
                  cubit.selectCountryCode(newValue!);
                },
                borderRadius: BorderRadius.circular(10.r),
                underline: Container(),
                items: cubit.countries
                    .map<DropdownMenuItem<CountryId>>(
                        (CountryId country) {
                      return DropdownMenuItem<CountryId>(
                        value: country,
                        child: SizedBox(
                          width: 98.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                country.name,
                                style: font.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp),
                              ),
                              SizedBox(width: 8.w),
                              Text(country.dialCode,
                                  style: font.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ):null,
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
                  borderSide: BorderSide(color: color.backgroundColor)),
              hintText: hint,
            ),
          ),
        )
      ],
    );
  }
}
