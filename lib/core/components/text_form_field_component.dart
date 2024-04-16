import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/models/user_model.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.cubit,
    required this.validator,
    required this.keyboardType,
    this.onTap,
    required this.maxLength,
    this.withSuffixIcon = false,
    this.visibleTwo = false,
    this.width = double.infinity,
    this.prefixIcon = false,
    this.readOnly = false,
    this.country = false,
    this.withBorder = false,
  });

  final String hint;
  final String title;
  final int maxLength;
  final TextEditingController controller;
  final bool withSuffixIcon;
  final String? Function(String?)? validator;
  final bool visibleTwo;
  final AuthenticationCubit? cubit;
  final TextInputType keyboardType;
  final double width;
  final bool readOnly;
  final bool prefixIcon;
  final bool country;
  final VoidCallback? onTap;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    List<CountryId> countries = LayoutCubit.get(context).lang=='en'?
    cubit!.countries:cubit!.countriesAr;
    return Column(
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
          width: width,
          child: TextFormField(
            onChanged: (value) {
              controller.text = value;
            },
            onSaved: (newValue) {
              controller.text = newValue!;
            },
            readOnly: readOnly,
            onTap: onTap,
            validator: validator,
            keyboardType: keyboardType,
            maxLength: maxLength,
            controller: controller,
            obscureText: withSuffixIcon
                ? visibleTwo
                ? !cubit!.visibleTwo
                : !cubit!.visibleOne
                : false,
            style: TextStyle(fontSize: 14.sp),
            cursorHeight: 20.h,
            decoration: InputDecoration(
                prefixIcon: prefixIcon
                    ? DropdownButton<CountryId>(
                  value: cubit!.selectedCountry != null
                      ? cubit!.selectedCountry
                      :LayoutCubit.get(context).lang=='en'?
                  cubit!.countries[7]:cubit!.countriesAr[7],
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (CountryId? newValue) {
                    cubit!.selectCountryCode(newValue!);
                  },
                  borderRadius: BorderRadius.circular(10.r),
                  underline: Container(),
                  items: countries
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
                )
                    : null,
                counterText: '',
                contentPadding:
                prefixIcon ? EdgeInsets.symmetric(horizontal: 10.w) : null,
                suffixIcon: country
                    ? Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: color.iconTheme.color,
                )
                    : readOnly
                    ? Icon(
                  FontAwesomeIcons.upload,
                  color: color.iconTheme.color,
                )
                    : withSuffixIcon
                    ? InkWell(
                  onTap: () {
                    if (visibleTwo) {
                      cubit!.changeVisible(false);
                    } else {
                      cubit!.changeVisible(true);
                    }
                  },
                  child: Icon(
                    visibleTwo
                        ? !cubit!.visibleTwo
                        ? FontAwesomeIcons.eyeLowVision
                        : FontAwesomeIcons.eye
                        : !cubit!.visibleOne
                        ? FontAwesomeIcons.eyeLowVision
                        : FontAwesomeIcons.eye,
                    size: 18.sp,
                  ),
                )
                    : null,
                hintText: hint,
                enabledBorder:OutlineInputBorder(
                  borderSide: withBorder
                      ? BorderSide(color: color.backgroundColor)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(20.r),
                ) ,
                border: OutlineInputBorder(
                  borderSide: withBorder
                      ? BorderSide(color: color.backgroundColor)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(20.r),
                )),
          ),
        )
      ],
    );
  }
}

class Country {
  final String nameEn;
  final String nameAr;

  Country(this.nameEn, this.nameAr);
}
