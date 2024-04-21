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



ThemeData darkTheme() => ThemeData(
    appBarTheme: AppBarTheme(
        color: BlackColorConstant.scaffoldBackground),

    cardColor:Color(0xFF1F1F1F),
    hoverColor: Color(0xFF343434),
    backgroundColor: BlackColorConstant.backgroundAuth,
    highlightColor:Color(0xFFDFDFDF),

    iconTheme: IconThemeData(
        color: BlackColorConstant.white
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.inter(
        color: BlackColorConstant.hint,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      suffixIconColor:BlackColorConstant.hint ,

      focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: const BorderSide(
          color: BlackColorConstant.brownTwo,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: const BorderSide(
          color: BlackColorConstant.error,
        ),
      ),
      filled: true,

      fillColor: Color(0xFF343434),
    ),
    scaffoldBackgroundColor: BlackColorConstant.scaffoldBackground,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0D0D0D),
        elevation: 15,
        unselectedItemColor: Color(0xFF878787),
        selectedItemColor: BlackColorConstant.backgroundAuth,
        selectedIconTheme: IconThemeData(
            color: BlackColorConstant.backgroundAuth
        )
    ),
    primaryColor: BlackColorConstant.brown,
    textTheme: TextTheme(
        titleMedium: GoogleFonts.heebo(
          color: BlackColorConstant.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.heebo (
          color: BlackColorConstant.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
        ),
        labelMedium: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.inter(
          color: BlackColorConstant.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
        )
    )
);
