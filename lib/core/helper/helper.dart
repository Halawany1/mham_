import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';

class Helper {
  static String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('d MMM, H:mm').format(dateTime);
    return formattedDate;
  }

  static String trackingTimeFormat(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat('h:mm a - MMM dd').format(dateTime);
    return formattedDateTime;
  }
  static String formatDayAndMonthAndYear(String dateString) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dateString);
    String formattedDateTime = DateFormat('h:mm a - MMM dd').format(dateTime);
    return formattedDateTime;
  }
  static void push(BuildContext context, Widget widget) {
    LayoutCubit.get(context).changeHideNav(true);
    Navigator.push(context, MaterialPageRoute(builder:
        (context) => widget,));
  }

  static void pushReplacement(BuildContext context, Widget widget) {
    LayoutCubit.get(context).changeHideNav(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder:
        (context) => widget,));
  }
  static void pop(BuildContext context) {
    LayoutCubit.get(context).changeHideNav(false);
   Navigator.pop(context);
  }


}