import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/internet_cubit/internet_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/layout/widget/no_internet.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme
        .of(context)
        .textTheme;


    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, internetState) {
        var internet = context.read<InternetCubit>();
        return BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            var cubit = context.read<LayoutCubit>();
            return Scaffold(
                body:
                internetState is InternetNotConnected?
                BuildNoInternet():
                cubit.screens[cubit.index],
                bottomNavigationBar: SalomonBottomBar(
                  selectedColorOpacity: 0.2,
                  backgroundColor: color.cardColor,
                  margin: EdgeInsets.all(12.h),
                  currentIndex: cubit.index,
                  onTap: (i) {
                    if (CacheHelper.getData(key: AppConstant.token) != null) {
                      cubit.changeIndex(i);
                    } else {
                      if (i != 0) {
                        Helper.push(context, GetStartScreen());
                      }
                    }
                  },
                  items: [
                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.home, size: 18.r,),
                      title: Text(locale.home),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),

                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.truck, size: 18.r,),
                      title: Text(locale.order),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),

                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.wallet, size: 18.r,),
                      title: Text(locale.wallet),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),

                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.user, size: 18.r,),
                      title: Text(locale.profile),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),
                  ],
                )

            );
          },
        );
      },
    );
  }
}
