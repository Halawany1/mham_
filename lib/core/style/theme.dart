import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mham/core/constent/color_constant.dart';

ThemeData lightTheme() => ThemeData(
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: GoogleFonts.inter(
          color: ColorConstant.hint,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
        fillColor: ColorConstant.white,
        suffixIconColor: ColorConstant.hint,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: const BorderSide(
            color: ColorConstant.brown,
          ),
        )),
    cardColor: Colors.white,
    backgroundColor: ColorConstant.backgroundAuth,
    scaffoldBackgroundColor: ColorConstant.scaffoldBackground,
    primaryColor: ColorConstant.brown,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: ColorConstant.unSelectedIconInNav),
    iconTheme: IconThemeData(color: ColorConstant.backgroundAuth),
    appBarTheme: AppBarTheme(color: ColorConstant.scaffoldBackground),
    hoverColor: ColorConstant.brown.withOpacity(0.9),
    textTheme: TextTheme(
        titleMedium: GoogleFonts.heebo(
          color: ColorConstant.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.heebo(
          color: ColorConstant.brown,
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.inter(
          color: Colors.black,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.inter(
          color: ColorConstant.brown,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        )));
