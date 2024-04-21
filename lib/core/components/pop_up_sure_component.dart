import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/color_constant.dart';

Widget confirmPopUp({required BuildContext context,
required VoidCallback onPress,
  required String title,
  required String content,
}){
  var color=Theme.of(context);
  final locale = AppLocalizations.of(context);
  var font=Theme.of(context).textTheme;
  return AlertDialog(
    backgroundColor: color.scaffoldBackgroundColor,
    title: Text(
      title,
      style: font.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorConstant.error),
    ),
    content: Text(
      content,
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          locale.cancel ,
          style: font.bodyMedium!.copyWith(
              color: color.primaryColor),
        ),
      ),
      TextButton(
        onPressed: onPress,
        child: Text(
          locale.ok,
          style: font.bodyMedium!.copyWith(
              color: ColorConstant.error),
        ),
      ),
    ],
  );
}