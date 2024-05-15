import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    var font = Theme.of(context).textTheme;
    List<StepperData> stepperData = [
      StepperData(
          title: StepperText(locale.ordered,
              textStyle: font.bodyMedium!.copyWith(
                  fontSize: 15.sp
              )),
          iconWidget: CircleAvatar(
              backgroundColor: color.primaryColor,
              child: Icon(Icons.done,color: color.cardColor,))),
      StepperData(
          title: StepperText(locale.processing,
              textStyle: font.bodyMedium!.copyWith(
                fontSize: 15.sp
              )),
          iconWidget: CircleAvatar(
              backgroundColor: color.primaryColor,
              child: Icon(Icons.done,color: color.cardColor,))),
      StepperData(
          title: StepperText(locale.shipped,
              textStyle: font.bodyMedium!.copyWith(
                  fontSize: 15.sp
              )),
          iconWidget: CircleAvatar(
              backgroundColor:Colors.grey,
              child: null)),
      StepperData(
        iconWidget: CircleAvatar(
            backgroundColor:Colors.grey,
            child: null),
        title: StepperText(locale.delivered,
            textStyle: font.bodyMedium!.copyWith(
                fontSize: 15.sp
            )),
      ),
    ];
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
                bottomNavigationBar: Container
                  (
                  height:cubit.driverIndex==0?
                  120.h:55.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r)
                      )
                  ),
                  child: Stack(
                    children: [

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SalomonBottomBar(
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
                        ),
                      ),
                      if(cubit.driverIndex==0)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: color.backgroundColor.withOpacity(0.75),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r)
                          )
                        ),
                        child: AnotherStepper(
                          verticalGap: 15.h,
                          stepperList: stepperData,
                          activeIndex: 1,

                          stepperDirection: Axis.horizontal,
                          iconWidth: 25.w,
                          // Height that will be applied to all the stepper icons
                          iconHeight: 25
                              .h, // Width that will be applied to all the stepper icons
                        ),
                      ),
                    ],

                  ),
                )

            );
          },
        );
      },
    );
  }
}
