import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
    Navigator.push(context, MaterialPageRoute(builder:
        (context) => widget,));
  }

  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder:
        (context) => widget,),(route) => false,);
  }
  static void pop(BuildContext context) {
   Navigator.pop(context);
  }

  static Future<bool> hasConnection() async {
    var isDeviceConnected = await InternetConnectionChecker().hasConnection;
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile ||
        connectionResult == ConnectivityResult.wifi) {
      isDeviceConnected = true;
    } else {
      isDeviceConnected = false;
    }
    return isDeviceConnected;
  }


}