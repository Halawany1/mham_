import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/profile_cubit/profile_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/pop_up_sure_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/layout/layout_screen.dart';
import 'package:mham/views/edit_profile_screen/edit_profile_screen.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:mham/views/profile_screen/widget/card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/profile_screen/widget/language_dailog_selection_component.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';

class ProfileDriverScreen extends StatelessWidget {
  const ProfileDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    if (ProfileCubit.get(context).driverProfileModel == null) {
      ProfileCubit.get(context).getProfile(driver: true);
    }
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is SuccessUpdateProfileDriverState) {
          showMessageResponse(
              message: locale.successUpdateProfile,
              context: context,
              success: true);
        }
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: color.scaffoldBackgroundColor,
                statusBarBrightness: Brightness.light,
              ),
            ),
            body: cubit.driverProfileModel == null
                ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SafeArea(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.h),
                          child: Column(
                            children: [
                              Text(
                                locale.myProfile,
                                style:
                                    font.bodyLarge!.copyWith(fontSize: 20.sp),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              // if (cubit.driverProfileModel!.driver!.user!
                              //         .avatar ==
                              //     null)
                                CircleAvatar(
                                  radius: 45.r,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    size: 30.r,
                                  ),
                                ),
                              // if (cubit.driverProfileModel!.driver!.user!
                              //         .avatar !=
                              //     null)
                              //   CircleAvatar(
                              //       radius: 45.r,
                              //       child: Image.asset(ApiConstant.baseUrl+cubit
                              //           .driverProfileModel!
                              //           .driver!
                              //           .user!
                              //           .avatar!)),
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                cubit.driverProfileModel!.driver!.user!
                                    .userName!,
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
                                  cubit.getProfile(driver: true);
                                  AuthenticationCubit.get(context)
                                      .getCountries();
                                  userNameController.text = cubit
                                      .driverProfileModel!
                                      .driver!
                                      .user!
                                      .userName!;
                                  phoneController.text = cubit
                                      .driverProfileModel!
                                      .driver!
                                      .user!
                                      .mobile!;
                                  driverLicenseController.text = cubit
                                      .driverProfileModel!
                                      .driver!
                                      .drivingLicence!;
                                  Helper.push(
                                      context: context,
                                      widget: EditProfileScreen(
                                        driver: true,
                                      ),
                                      withAnimate: true);
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              BuildCards(
                                icon: FontAwesomeIcons.bell,
                                text: locale.notifications,
                                onTap: () {
                                  Helper.push(
                                      context: context,
                                      widget: NotificationScreen(),
                                      withAnimate: true);
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
                                icon:
                                    CacheHelper.getData(key: AppConstant.theme)
                                        ? FontAwesomeIcons.moon
                                        : FontAwesomeIcons.lightbulb,
                                text:
                                    !CacheHelper.getData(key: AppConstant.theme)
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
                              BuildCards(
                                icon: FontAwesomeIcons.sync,
                                text: locale.appUpdate,
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              BuildCards(
                                icon: FontAwesomeIcons.signOut,
                                logout: true,
                                text: locale.logout,
                                dark: !LayoutCubit.get(context).theme,
                                onTap: () {
                                  showDialog(
                                      builder: (context) => confirmPopUp(
                                          context: context,
                                          onPress: () {
                                            userNameController.clear();
                                            phoneController.clear();
                                            passwordController.clear();
                                            addressController.clear();
                                            driverLicenseController.clear();
                                            CacheHelper.removeData(
                                                key: AppConstant.token);
                                            CacheHelper.removeData(
                                                key: AppConstant.driver);
                                            CacheHelper.removeData(
                                                key: AppConstant.driverId);
                                            LayoutCubit.get(context)
                                                .changeTheme(true);
                                            Navigator.pop(context);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LayoutScreen()),
                                            );
                                          },
                                          title: locale.logout,
                                          content: locale.areYouSureToLogout),
                                      context: context);
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
                  ));
      },
    );
  }
}
