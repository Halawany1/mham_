import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/views/home_screen/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildSearchFormField extends StatelessWidget {
  const BuildSearchFormField({
    super.key,
    this.readOnly = false,
    this.onSave,
    this.onTap,
    this.width = 245,
  });

  final bool readOnly;
  final void Function(String?)? onSave;
  final VoidCallback? onTap;
  final double width;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);

    return SizedBox(
      height: 32.h,
      width: width.w,
      child: TextFormField(
        readOnly: readOnly,
        style: TextStyle(
          color:Colors.white,
          fontSize: 15.sp,
        ),
        onChanged: onSave,
        cursorColor: Colors.white,
        onTap: onTap,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none),
            prefixIcon: Icon(
              FontAwesomeIcons.search,
              color: color.highlightColor.withOpacity(0.75),
              size: 15.sp,
            ),
            hintText: locale.search,
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            hintStyle: font.bodyMedium!.copyWith(
                fontSize: 15.sp, color: color.highlightColor.withOpacity(0.75)),
            filled: true,
            fillColor: color.hoverColor),
      ),
    );
  }
}
