import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showMessageResponse({required String message,
  required BuildContext context,
 required bool success
}){
  final locale = AppLocalizations.of(context);

  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor:success? Colors.green:Colors.red, // Optional: Customize background color
    behavior: SnackBarBehavior.floating, // Optional: Customize behavior
    duration: Duration(seconds: 3), // Optional: Specify duration
    action: SnackBarAction( // Optional: Add an action button
      label:locale.close ,
      onPressed: () {
        // Action to execute when the user presses the action button
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}