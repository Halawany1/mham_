import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/text_and_link_row_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var _formKey = GlobalKey<FormState>();
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        var cubit=context.read<AuthenticationCubit>();
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: 40.h),
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
                          maxLength: 120,
                          keyboardType: TextInputType.emailAddress,
                          cubit: cubit,

                            validator: (value) {
                              return Validation.validateEmail(value);
                            },
                            title: locale.email,
                            hint: 'Nour55@mail.com',
                            controller: emailController),
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
                            title: locale.password,
                            withSuffixIcon: true,
                            hint: '*************',
                            controller: passwordController),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: cubit.rememberCheck,
                              onChanged: (value) {
                                cubit.changeRememberCheck(value!);
                              },
                            ),
                            Text(
                              locale.rememberMe,
                              style: font.bodyMedium!.copyWith(
                                  fontSize: 11.5.sp),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Text(
                                locale.forgotPassword,
                                style: font.bodyMedium!.copyWith(
                                    fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        BuildDefaultButton(
                          text: locale.signIn,
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
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                const
                                SignUpScreen()));
                            AuthenticationCubit.get(context).resetVisible();
                          },
                          text:locale.noHaveAccount,
                          textLink: locale.signUp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        BuildTextAndLinkRow(
                          smallText: true,
                          onTap: () {},
                          text: locale.continueAs,
                          textLink: locale.guest,
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
