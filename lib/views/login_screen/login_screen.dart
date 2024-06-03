import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/profile_cubit/profile_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_and_link_row_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/driver_layout/driver_layout_screen.dart';
import 'package:mham/layout/layout_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/driver/home_screen/driver_home_screen.dart';
import 'package:mham/views/otp_screen/otp_screen.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';

var _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key,required this.client});

  final bool client;
  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    void clearAllData() {
      phoneController.clear();
      passwordController.clear();
      AuthenticationCubit.get(context).selectedCountry=null;
    }

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is NoInternetAuthState){
          showMessageResponse(message: locale.noInternetConnection,
              context: context, success: false);
        }
        var cubit = context.read<AuthenticationCubit>();
        if(client){
          if (state is SuccessLoginUserState) {
            clearAllData();
            CacheHelper.saveData(
                key: AppConstant.token, value: cubit.userModel!.token);
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>
              const LayoutScreen())
              ,(route) => false,);
            HomeCubit.get(context).getNotification();
          }
          if (state is ErrorLoginUserState) {
            showMessageResponse(message: state.error,
                context: context, success: false);
          }
        }else{
          if (state is SuccessLoginUserState) {
            clearAllData();
            CacheHelper.saveData(
                key: AppConstant.token,
                value: cubit.driverModel!.token);
            CacheHelper.saveData(key: AppConstant.driver,
                value: true);
            Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) =>
              const DriverLayoutScreen())
              ,(route) => false,);
            CacheHelper.saveData(key: AppConstant.driverId,
                value: cubit.driverModel!.user!.driver!.id);
          }
          if (state is ErrorLoginUserState) {
            showMessageResponse(message: state.error,
                context: context, success: false);
          }
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: color.backgroundColor,
          ),
          backgroundColor: color.backgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(25.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        locale.signIn,
                        style: font.bodyLarge,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        locale.welcomeBack,
                        style: font.bodyMedium,
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                      BuildTextFormField(
                          maxLength: 15,
                          prefixIcon: true,
                          keyboardType: TextInputType.phone,
                          cubit: cubit,
                          validator: (value) {
                            return Validation.validatePhoneNumber(
                                value, context);
                          },
                          title: locale.phone,
                          hint: locale.phone,
                          controller: phoneController),
                      SizedBox(
                        height: 20.h,
                      ),
                      BuildTextFormField(
                          maxLength: 120,
                          keyboardType: TextInputType.text,
                          cubit: cubit,
                          validator: (value) {
                            return Validation.validatePassword(value, context);
                          },
                          title: locale.password,
                          withSuffixIcon: true,
                          hint: '*************',
                          controller: passwordController),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:
                              (context) => OtpScreen(role: client?'user':'driver',),));
                            },
                            child: Text(
                              locale.forgotPassword,
                              style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      state is LoadingLoginUserState
                          ? Center(
                              child: CircularProgressIndicator(
                              color: color.primaryColor,
                            ))
                          : BuildDefaultButton(
                        colorText: color.cardColor,
                        backgorundColor: color.primaryColor,
                              text: locale.signIn,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ProfileCubit.get(context).profileModel=null;
                                  String countryCode =
                                      cubit.selectedCountry == null
                                          ? '+965'
                                          : cubit.selectedCountry!.dialCode;

                                    cubit.userLogin(
                                      driver: !client,
                                        lang: LayoutCubit.get(context).lang,
                                        phone: countryCode + phoneController.text,
                                        password: passwordController.text);

                                 
                                }
                              },
                            ),
                      SizedBox(
                        height: 12.h,
                      ),
                      BuildTextAndLinkRow(
                        onTap: () {
                          clearAllData();
                          cubit.getCountries();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                   SignUpScreen(client: client,)));
                          AuthenticationCubit.get(context).resetVisible();
                        },
                        text: locale.noHaveAccount,
                        textLink: locale.signUp,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // Text(
                      //   locale.orContinueWith,
                      //   style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                      // ),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // const BuildThridPartyServices()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
