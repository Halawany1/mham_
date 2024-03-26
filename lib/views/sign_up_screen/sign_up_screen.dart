import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/text_and_link_row_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/error/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
var _formKey = GlobalKey<FormState>();

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    var userNameController = TextEditingController();
    var phoneController = TextEditingController();
    var addressController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    final locale = AppLocalizations.of(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit=context.read<AuthenticationCubit>();
        return WillPopScope(
          onWillPop: () async{
            Navigator.pop(context);
            cubit.resetVisible();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  cubit.resetVisible();
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,

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
                              return Validation.validateUsername(value);
                            },
                            title:locale.userName,
                            hint:locale.userName,
                            controller: userNameController),
                        SizedBox(
                          height: 20.h,
                        ),
                        BuildTextFormField(
                            maxLength: 15,
                            keyboardType:
                            TextInputType.phone,
                            cubit: cubit,
                            validator: (value) {
                              return Validation.validatePhoneNumber(value);
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
                              return Validation.validatePassword(value);
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
                                  value, passwordController.text);
                            },
                            visibleTwo: true,
                            withSuffixIcon: true,
                            title: locale.confirmPassword,
                            hint: locale.confirmPassword,
                            controller: confirmPasswordController),
                        SizedBox(
                          height: 35.h,
                        ),
                        BuildDefaultButton(
                          text: locale.signUp,
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {

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
                          textLink: 'Sign In',
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
