import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/profile_cubit/profile_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/pop_up_sure_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/edit_profile_screen/edit_profile_screen.dart';
import 'package:mham/views/favourite_screen/favourite_screen.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:mham/views/profile_screen/widget/card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/recent_purchases_screen/recent_purchases_screen.dart';
import 'package:mham/views/returns_screen/returns_screen.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';
import 'widget/language_dailog_selection_component.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme
        .of(context)
        .textTheme;
    if(ProfileCubit.get(context).profileModel==null){
      ProfileCubit.get(context).getProfile(driver: false);
    }
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is SuccessUpdateProfileState) {
          showMessageResponse(message: locale.successUpdateProfile,
              context: context, success: true);
        }
        if (state is ErrorDeleteAccount) {
          showMessageResponse(message: state.message,
              context: context, success: false);
        }
        if(state is SuccessDeleteAccount){
          userNameController.clear();
          phoneController.clear();
          passwordController.clear();
          HomeCubit.get(context).myScrapModel=null;
          CacheHelper.removeData(key: AppConstant.token);
          LayoutCubit.get(context).changeTheme(true);
          LayoutCubit.get(context).changeIndex(0);
        }
      },
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(

          body:CacheHelper.getData(key: AppConstant.token,token: true)==null?
          GetStartScreen():
          cubit.profileModel != null || state is LoadingDeleteAccount
              ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
                      Text(
                        locale.myProfile,
                        style: font.bodyLarge!.copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CircleAvatar(
                        radius: 45.r,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          FontAwesomeIcons.user,
                          size: 30.r,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        cubit.profileModel!.user!.userName!,
                        style: font.bodyLarge!.copyWith(
                            color: color.backgroundColor,
                            fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.user,
                        text: locale.profile,
                        onTap: () {
                          AuthenticationCubit.get(context).getCountries();
                         // List<dynamic> addressList = jsonDecode(cubit.profileModel!.user!.address!);
                          userNameController.text =
                          cubit.profileModel!.user!.userName!;
                          phoneController.text = cubit.profileModel!.user!.mobile!;
                        // addressController.text=addressList[0];
                          Helper.push(context: context,widget:
                              EditProfileScreen(driver: false,),withAnimate: true);
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.solidHeart,
                        text: locale.favorite,
                        onTap: () {
                          Helper.push(context: context,widget:
                          FavouriteScreen(),withAnimate: true);
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.undo,
                        text: locale.returns,
                        onTap: () {
                          HomeCubit.get(context).orderModel=null;
                          HomeCubit.get(context).getAllOrders();
                          Helper.push(context: context,widget:
                          ReturnsScreen(),withAnimate: true);
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.shoppingBag,
                        text: locale.recentPurchases,
                        onTap: () {
                          HomeCubit.get(context).orderModel=null;
                          HomeCubit.get(context).getAllOrders();
                          Helper.push(context: context,widget:
                          RecentPurchasesScreen());
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.bell,
                        text: locale.notifications,
                        onTap: () {
                          Helper.push(context: context,widget:
                          NotificationScreen(),withAnimate: true);
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.globe,
                        text: locale.language,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BuildLanguageSelectionDialog();
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      BuildCards(
                        icon: CacheHelper.getData(key: AppConstant.theme)
                            ? FontAwesomeIcons.moon
                            : FontAwesomeIcons.lightbulb,
                        text: !CacheHelper.getData(key: AppConstant.theme)
                            ? locale.lightMode
                            : locale.darkMode,
                        onTap: () {
                          LayoutCubit.get(context).changeTheme(
                              !CacheHelper.getData(
                                  key: AppConstant.theme));
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // BuildCards(
                      //   icon: FontAwesomeIcons.sync,
                      //   text: locale.appUpdate,
                      //   onTap: () {},
                      // ),
                      SizedBox(
                        height: 40.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.signOut,
                        logout: true,
                        text: locale.logout,
                        dark: !LayoutCubit
                            .get(context)
                            .theme,
                        onTap: () {
                          showDialog(
                            builder: (context) =>  confirmPopUp(context: context,
                                onPress: () {
                                  userNameController.clear();
                                  phoneController.clear();
                                  passwordController.clear();
                                  HomeCubit.get(context).myScrapModel=null;
                                  CacheHelper.removeData(key: AppConstant.token);
                                  LayoutCubit.get(context).changeTheme(true);
                                  LayoutCubit.get(context).changeIndex(0);
                                  Navigator.pop(context);
                                  cubit.logout(fcmToken: CacheHelper.getData(key: AppConstant.fcmToken),
                                      refreshToken:
                                      CacheHelper.getData(key: AppConstant.refreshToken));
                                }, title: locale.logout,
                                content: locale.areYouSureToLogout),
                            context: context
                          );
                        },
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      BuildCards(
                        icon: FontAwesomeIcons.trash,
                        text: locale.deleteAccount,
                        onTap: () {
                          showDialog(
                              builder: (context) =>
                                  confirmPopUp(context: context,
                                  onPress: () {
                                    cubit.deleteAccount(
                                        cubit.profileModel!.user!.id!);
                                    Navigator.pop(context);
                                  }, title: locale.deleteAccount,
                                  content:locale.areYourSureToDeleteAccount),
                              context: context
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
              : Center(child: BuildImageLoader(assetName: ImageConstant.logo)),
        );
      },
    );
  }
}
