import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mham/core/constent/color/color_constant.dart';

ThemeData lightTheme() => ThemeData(
    appBarTheme: AppBarTheme(
        color: ColorConstant.backgroundAuth,
        iconTheme: IconThemeData(
          color: ColorConstant.brown,
        )
    ),
    cardColor: Colors.white,
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return ColorConstant.brown; // Brown when active
          }
          return ColorConstant.backgroundAuth; // White when inactive
        }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.inter(
        color: ColorConstant.hint,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
      suffixIconColor:ColorConstant.hint ,

      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: const BorderSide(
          color: ColorConstant.brown,
        ),
      ),

      contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: const BorderSide(
          color: ColorConstant.error,
        ),
      ),
      filled: true,

      fillColor: ColorConstant.white,
    ),
    scaffoldBackgroundColor: ColorConstant.backgroundAuth,
    primaryColor: ColorConstant.brown,
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
        titleMedium: GoogleFonts.heebo(
          color: ColorConstant.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.heebo (
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
        )
    )
);