import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/views/driver/history_screen/widget/history_order.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class HistoryDriverScreen extends StatelessWidget {
  const HistoryDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var layoutCubit = LayoutCubit.get(context);
    return Scaffold(
      appBar: topAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    locale.history,
                    style: font.bodyMedium,
                  ),
                  GestureDetector(
                    onTap: () {
                      showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            layoutCubit.lang == 'en' ? 120.w : 30.w,
                            170.h,
                            layoutCubit.lang == 'en' ? 30.w : 120.w,
                            0),
                        elevation: 5,
                        color: color.scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        items: [],
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.filter,
                      color: color.backgroundColor,
                    ),
                  )
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.all(12.h),
              child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return BuildHistoryOrder();
                  }),
            )

          ],
        ),
      ),
    );
  }

}
