import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/login_screen/login_screen.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';


class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locale.signIn,
                    style: font.bodyLarge,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    locale.welcomeBackGetStart,
                    style: font.bodyMedium,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  BuildDefaultButton(text: locale.signIn,
                      onPressed: () {
                        clearAllData();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => LoginScreen(),));
                      },
                      backgorundColor: ColorConstant.brown,
                      colorText: ColorConstant.white),
                  SizedBox(height: 20.h,),
                  BuildDefaultButton(text:locale.signUp,
                      onPressed: () {
                        clearAllData();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignUpScreen(),));
                      },
                      withBorder: true,
                      backgorundColor: ColorConstant.backgroundAuth,
                      colorText: ColorConstant.brown),
                  SizedBox(
                    height: 90.h,
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
