import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/internet_cubit/internet_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/layout/widget/no_internet.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class DriverLayoutScreen extends StatelessWidget {
  const DriverLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);


    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, internetState) {
        return BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            var cubit = context.read<LayoutCubit>();
            return Scaffold(
                body:
                internetState is InternetNotConnected?
                BuildNoInternet():
                cubit.screensDriver[cubit.driverIndex],
                bottomNavigationBar: SalomonBottomBar(
                  selectedColorOpacity: 0.2,
                  backgroundColor: color.cardColor,
                  margin: EdgeInsets.all(12.h),
                  currentIndex: cubit.driverIndex,
                  onTap: (i) {
                    cubit.changeDriverIndex(i);
                  },
                  items: [
                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.home, size: 18.r,),
                      title: Text(locale.home),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),

                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.timeline, size: 18.r,),
                      title: Text(locale.timeLine),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),

                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.truck, size: 18.r,),
                      title: Text(locale.orders),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.history, size: 18.r,),
                      title: Text(locale.history),
                      selectedColor: color.backgroundColor.withOpacity(0.9),
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(FontAwesomeIcons.solidUser, size: 18.r,),
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
