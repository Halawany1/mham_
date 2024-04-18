import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildNotFoundProduct extends StatelessWidget {
  const BuildNotFoundProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var color=Theme.of(context);
    final locale = AppLocalizations.of(context);

    return   Column(children: [
      SizedBox(height: 10.h,),
      Icon(FontAwesomeIcons.exclamationCircle,
        color: color.errorColor,),
      SizedBox(height: 10.h,),
      Text(locale.noProductFound),
    ],);
  }
}
