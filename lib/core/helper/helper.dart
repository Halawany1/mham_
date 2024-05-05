import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

class Helper {
  static String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    // Convert to local time zone
    dateTime = dateTime.toLocal();
    // Format the date and time
    String formattedDateTime = DateFormat("MMMM d, h:mm a").format(dateTime);
    return formattedDateTime;
  }
  static String formatTimeNotification(DateTime time) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(time).abs();

    if (difference.inSeconds < 60) {
      return "now";
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return "${minutes} minute${minutes == 1 ? '' : 's'} ago";
    } else if (difference.inHours < 24 && time.day == now.day) {
      int hours = difference.inHours;
      return "${hours} hour${hours == 1 ? '' : 's'} ago";
    } else if (difference.inDays < 7) {
      return DateFormat("d MMM 'at' HH:mm").format(time);
    } else {
      return DateFormat("d MMM").format(time);
    }
  }

  static String formatTimeString(String timeString) {
    DateTime time = DateTime.parse(timeString);
    return formatTimeNotification(time);
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


  static bool isArabic(String text) {
    for (int i = 0; i < text.length; i++) {
      // Check if the character falls within the Arabic Unicode range
      if (text.codeUnitAt(i) >= 0x0600 && text.codeUnitAt(i) <= 0x06FF) {
        return true; // Return true if Arabic character found
      }
    }
    return false; // Return false if no Arabic characters found
  }




}