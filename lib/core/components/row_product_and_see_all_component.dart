import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildRowTextAndSeeAll extends StatelessWidget {
  const BuildRowTextAndSeeAll({
    super.key,
    required this.text,
    required this.onTap,
     this.onTapView,
    this.seeAll = true,
    this.view = false,
    required this.empty
  });

  final String text;
  final Function()? onTap;
  final Function()? onTapView;
  final bool seeAll;
  final bool view;
  final bool empty;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);

    final locale = AppLocalizations.of(context);
    return Row(
      children: [
        Text(
          text,
          style: font.bodyLarge!.copyWith(
            color: color.backgroundColor,
              fontSize: 18.sp),
        ),
        Spacer(),
        if(!empty)
          InkWell(
          onTap: onTap,
          child: seeAll
              ? Container(
                  alignment: Alignment.center,
                  height: 18.h,
                  width: 66.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: color.primaryColor),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text('See All',
                      style: font.bodyMedium!.copyWith(
                        fontSize: 12.sp,
                        color: color.primaryColor,
                      )),
                )
              : Icon(
                  FontAwesomeIcons.filter,
                  color: color.hoverColor,
                ),
        ),

      ],
    );
  }
}
