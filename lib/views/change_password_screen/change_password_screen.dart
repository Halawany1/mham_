import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/error/validation.dart';

var passwordOtpController = TextEditingController();
var confirmPasswordOtpController = TextEditingController();
var formKey = GlobalKey<FormState>();

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: color.primaryColor,)),
          ),
          body: Form(
            key: formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locale.setNewPassword,
                        style: font.bodyLarge!.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                         locale.createNewPassEnshure),
                      SizedBox(
                        height: 40.h,
                      ),
                      BuildTextFormField(
                          withBorder: true,
                          maxLength: 120,
                          keyboardType: TextInputType.text,
                          cubit: AuthenticationCubit.get(context),
                          validator: (value) {
                            return Validation.validatePassword(value, context);
                          },
                          withSuffixIcon: true,
                          title: locale.password,
                          hint: locale.password,
                          controller: passwordOtpController),
                      SizedBox(
                        height: 20.h,
                      ),
                      BuildTextFormField(
                          withBorder: true,
                          maxLength: 120,
                          keyboardType: TextInputType.text,
                          cubit: AuthenticationCubit.get(context),
                          validator: (value) {
                            return Validation.validateConfirmPassword(value,
                                confirmPasswordOtpController.text, context);
                          },
                          visibleTwo: true,
                          withSuffixIcon: true,
                          title: locale.confirmPassword,
                          hint: locale.confirmPassword,
                          controller: confirmPasswordOtpController),
                      SizedBox(
                        height: 90.h,
                      ),
                      BuildDefaultButton(
                          text: locale.save,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                          },
                          backgorundColor: color.primaryColor,
                          colorText: color.cardColor)
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
