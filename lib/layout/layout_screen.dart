import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/home_screen/home_screen.dart';
import 'package:mham/views/order_screen/order_screen.dart';
import 'package:mham/views/profile_screen/profile_screen.dart';
import 'package:mham/views/wallet_screen/wallet_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

PersistentTabController controller = PersistentTabController(initialIndex: 0,);
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;


    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.home),
          title: (locale.home),
          iconSize: 15.sp,
          activeColorPrimary: color.backgroundColor,
          inactiveColorPrimary:
              color.bottomNavigationBarTheme.unselectedItemColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.truck),
          title: (locale.orders),
          iconSize: 15.sp,

          onPressed:CacheHelper.getData(key: AppConstant.token)==null?
              (p0) {
            if(CacheHelper.getData(key: AppConstant.token)==null){
              Helper.push(context, GetStartScreen());
            }
          }:null,
          activeColorPrimary: color.backgroundColor,
          inactiveColorPrimary:
          color.bottomNavigationBarTheme.unselectedItemColor,
        ),
        PersistentBottomNavBarItem(
          onPressed:CacheHelper.getData(key: AppConstant.token)==null?
              (p0) {
            if(CacheHelper.getData(key: AppConstant.token)==null){
              Helper.push(context, GetStartScreen());
            }
          }:null,
          icon: Icon(FontAwesomeIcons.wallet),
          title: (locale.wallet),
          iconSize: 15.sp,
          activeColorPrimary: color.backgroundColor,
          inactiveColorPrimary:
              color.bottomNavigationBarTheme.unselectedItemColor,
        ),
        PersistentBottomNavBarItem(
          onPressed:CacheHelper.getData(key: AppConstant.token)==null?
              (p0) {
            if(CacheHelper.getData(key: AppConstant.token)==null){
              Helper.push(context, GetStartScreen());
            }
          }:null,
          icon: Icon(FontAwesomeIcons.user),
          title: (locale.account),
          iconSize: 15.sp,
          activeColorPrimary: color.backgroundColor,
          inactiveColorPrimary:
          color.bottomNavigationBarTheme.unselectedItemColor,
        ),

      ];
    }

    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        var cubit = context.read<LayoutCubit>();
        return PersistentTabView(
          context,
          controller: controller,
          screens: [
            HomeScreen(),
            OrderScreen(),
            WalletScreen(),
            ProfileScreen(),
          ],
          hideNavigationBar: cubit.hideNav,
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: color.cardColor,
          // Default is Colors.white.
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: false,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: color.cardColor,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 150), // Adjust duration as needed
            curve: Curves.easeInOut, // Choose a suitable curve
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.easeInOut,
            // Use the same curve as itemAnimationProperties
            duration: Duration(
                milliseconds:
                300), // Use the same duration as itemAnimationProperties
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
        );



      },
    );
  }
}