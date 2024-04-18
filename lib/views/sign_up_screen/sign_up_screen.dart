import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/drop_down_menu.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_and_link_row_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/layout/layout_screen.dart';

var _formKey = GlobalKey<FormState>();
var userNameController = TextEditingController();
var phoneController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
void clearAllData() {
  userNameController.clear();
  passwordController.clear();
  confirmPasswordController.clear();
  phoneController.clear();
}
    final locale = AppLocalizations.of(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        var cubit=context.read<AuthenticationCubit>();
        if (state is SuccessRegisterUserState) {
          print(cubit.userModel!.token);
          CacheHelper.saveData(
              key: AppConstant.token,
              value: cubit.userModel!.token);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LayoutScreen(),));
        }

        if (state is ErrorRegisterUserState) {
          showMessageResponse(message: state.error,
              context: context, success: false);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return WillPopScope(
          onWillPop: () async {
            clearAllData();
            Navigator.pop(context);
            cubit.resetVisible();
            return true;
          },
          child: Scaffold(
            backgroundColor: color.backgroundColor,
            appBar: AppBar(
              backgroundColor: color.backgroundColor,
              leading: InkWell(
                onTap: () {
                  clearAllData();
                  cubit.resetVisible();
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.h),
                    child: Column(
                      children: [
                        Text(
                          locale.signUp,
                          style: font.bodyLarge,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          locale.createAccount,
                          style: font.bodyMedium,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        BuildTextFormField(
                            maxLength: 45,
                            keyboardType: TextInputType.name,
                            cubit: cubit,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.userName, context);
                            },
                            title: locale.userName,
                            hint: locale.userName,
                            controller: userNameController),
                        SizedBox(
                          height: 20.h,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              locale.selectCountry,
                              style: font.labelMedium,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        BuildDropDownMenu(
                          value: cubit.countryId,
                          onChange: (String? value) {
                            cubit.selectCountryId(value!);
                          },
                          list: cubit.countriesList,
                          valueName: locale.selectCountry,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        BuildTextFormField(
                            maxLength: 120,
                            keyboardType: TextInputType.text,
                            cubit: cubit,
                            validator: (value) {
                              return Validation.validatePassword(
                                  value, context);
                            },
                            withSuffixIcon: true,
                            title: locale.password,
                            hint: locale.password,
                            controller: passwordController),
                        SizedBox(
                          height: 20.h,
                        ),
                        BuildTextFormField(
                            maxLength: 120,
                            keyboardType: TextInputType.text,
                            cubit: cubit,
                            validator: (value) {
                              return Validation.validateConfirmPassword(
                                  value, passwordController.text, context);
                            },
                            visibleTwo: true,
                            withSuffixIcon: true,
                            title: locale.confirmPassword,
                            hint: locale.confirmPassword,
                            controller: confirmPasswordController),
                        SizedBox(
                          height: 35.h,
                        ),
                        state is LoadingRegisterUserState
                            ? Center(child: CircularProgressIndicator())
                            : BuildDefaultButton(
                          colorText: color.cardColor,
                          backgorundColor: color.primaryColor,
                          text: locale.signUp,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String countryCode =
                              cubit.selectedCountry == null
                                  ? '+985'
                                  : cubit.selectedCountry!.dialCode;
                              cubit.userSignUp(
                                  phone: countryCode + phoneController.text,
                                  userName: userNameController.text,
                                  password: passwordController.text,
                                  countryId: cubit.countriesId[cubit.countryId]!,
                                  confirmPassword: confirmPasswordController
                                      .text,
                                  lang: 'en');
                            }
                          },
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        BuildTextAndLinkRow(
                          onTap: () {
                            cubit.resetVisible();
                            Navigator.pop(context);
                          },
                          text: locale.alreadyHaveAccount,
                          textLink: locale.signIn,
                        ),
                        SizedBox(
                          height: 30.h,
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
          ),
        );
      },
    );
  }
}
