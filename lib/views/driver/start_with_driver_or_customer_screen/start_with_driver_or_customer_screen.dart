import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/login_screen/login_screen.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';


class GetStartWithDriverOrCustomerScreen extends StatelessWidget {
  const GetStartWithDriverOrCustomerScreen({super.key,
  required this.signUp
  });

  final bool signUp;
  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    final locale = AppLocalizations.of(context);
    void clearAllData() {
      phoneController.clear();
      passwordController.clear();
      userNameController.clear();
      AuthenticationCubit.get(context).countryId=null;
      confirmPasswordController.clear();

    }
    return WillPopScope(
      onWillPop: () async{
        Helper.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.backgroundAuth,
          leading: InkWell(
              onTap: () {
                Helper.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        backgroundColor: ColorConstant.backgroundAuth,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(25.h),
              child: Column(
                children: [
                  Text(
                   signUp?
                   locale.signUp:locale.signIn,
                    style: font.bodyLarge,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    signUp?
                    locale.createAccount:locale.welcomeBack,
                    style: font.bodyMedium,
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  BuildDefaultButton(text: locale.asClient,
                      onPressed: () {
                        clearAllData();
                        if(signUp){
                          Helper.push(context: context,widget:  SignUpScreen(
                            client: true,
                          ),withAnimate: true);


                        }else{
                          Helper.push(context: context,widget:  LoginScreen(
                            client: true,
                          ),withAnimate: true);

                        }
                      },
                      backgorundColor: ColorConstant.brown,
                      colorText: ColorConstant.white),
                  SizedBox(height: 20.h,),
                  BuildDefaultButton(text:locale.asDriver,
                      onPressed: () {
                        clearAllData();
                        AuthenticationCubit.get(context).getCountries();
                        if(signUp){
                          Helper.push(context: context,widget:  SignUpScreen(
                            client: false,
                          ),withAnimate: true);

                        }else{
                          Helper.push(context: context,widget:  LoginScreen(
                            client: false,
                          ),withAnimate: true);

                        }

                      },
                      withBorder: true,
                      backgorundColor: ColorConstant.backgroundAuth,
                      colorText: ColorConstant.brown),
                  SizedBox(
                    height: 120.h,
                  ),
                  Text(
                    locale.orContinueWith,
                    style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const BuildThridPartyServices()

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
