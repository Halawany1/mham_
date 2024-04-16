import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/color_constant.dart';

void confirmPopUp({required BuildContext context,
required VoidCallback onPress,
  required String title,
  required String content,
})=> showDialog(
  context: context,
  builder: (BuildContext context) {
    var font=Theme.of(context).textTheme;
    var color=Theme.of(context);
    final locale = AppLocalizations.of(context);

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
           'cancel' ,
            style: font.bodyMedium!.copyWith(
                color: color.primaryColor),
          ),
        ),
        TextButton(
          onPressed: onPress,
          child: Text(
          'ok',
            style: font.bodyMedium!.copyWith(
                color: ColorConstant.error),
          ),
        ),
      ],
    );
  },
);