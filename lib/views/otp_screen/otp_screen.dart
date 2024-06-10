import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/views/change_password_screen/change_password_screen.dart';
import 'package:mham/views/checkout_screen/widget/forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sms_autofill/sms_autofill.dart';

var phoneOtpController = TextEditingController();
var formKey = GlobalKey<FormState>();

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.role});
  final String role;
  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is SuccessGetOtpState){
          AuthenticationCubit.get(context).changeIndexOtpVerification(1);
        }
        if(state is ErrorGetOtpState){
          showMessageResponse(message: state.error,
              context: context, success: false);
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  if (cubit.currentIndexOtpVerification == 1) {
                    cubit.changeIndexOtpVerification(0);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Icon(Icons.arrow_back, color: color.primaryColor,)),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(35.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset(
                        ImageConstant.otp,
                        width: 180.w,
                        height: 180.h,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        locale.otpVerification,
                        style: font.bodyLarge!.copyWith(
                          fontSize: 23.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if(cubit.currentIndexOtpVerification == 0)
                        Text(
                          textAlign: TextAlign.center,
                          locale.weWillSendOtp,
                          style: font.bodyMedium!.copyWith(
                            fontSize: 14.sp,
                            color: color.primaryColor.withOpacity(0.6),
                          ),
                        ),
                      if(cubit.currentIndexOtpVerification == 1)
                        Text(
                          textAlign: TextAlign.center,
                          '${locale.enterOtp} ${cubit.selectedCountry == null
                              ? '+965'
                              : cubit.selectedCountry!.dialCode +
                              phoneOtpController.text}',
                          style: font.bodyMedium!.copyWith(
                            fontSize: 14.sp,
                            color: color.primaryColor.withOpacity(0.6),
                          ),
                        ),
                      SizedBox(
                        height: 30.h,
                      ),
                      if(cubit.currentIndexOtpVerification == 0)
                        BuildFormUnderLine(
                          phone: true,
                          hint: locale.enterMobileNumber,
                          inputType: TextInputType.phone,
                          title: locale.mobile,
                          controller: phoneOtpController,
                          validator: (value) {
                            return Validation.validatePhoneNumber(
                                value, context);
                          },
                        ),
                      if( cubit.currentIndexOtpVerification == 1)
                        PinFieldAutoFill(

                          decoration: UnderlineDecoration(

                            colorBuilder: FixedColorBuilder
                              (color.primaryColor),
                            // Set stroke color transparent
                            bgColorBuilder: FixedColorBuilder(
                                Colors
                                    .transparent), // Set background color transparent
                          ),
                          currentCode: '',
                          codeLength: 4,
                          autoFocus: true,
                          keyboardType: TextInputType.number,

                        ),
                      if( cubit.currentIndexOtpVerification == 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(locale.didntRecieveOtp,
                              style: font.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                                color: color.primaryColor.withOpacity(0.5),
                              ),),
                            TextButton(
                              onPressed: () {

                              },
                              child: Text(
                                locale.resendOtp,
                                style: font.bodyMedium!.copyWith(
                                  fontSize: 12.sp,
                                  color: color.backgroundColor,
                                ),
                              ),
                            )
                          ],),
                      SizedBox(height: 40.h,),
                    state is LoadingGetOtpState?
                      Center(child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(color.primaryColor)
                      ))
                      :BuildDefaultButton(
                          text: cubit.currentIndexOtpVerification == 0 ?
                          locale.getOtp : locale.verify,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String countryCode =
                              cubit.selectedCountry == null
                                  ? '+965'
                                  : cubit.selectedCountry!.dialCode;
                              if (cubit.currentIndexOtpVerification == 0) {
                                cubit.verifyOtp(
                                    mobile: countryCode+phoneOtpController.text,
                                    role: role);
                              } else {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      ChangePasswordScreen(),));
                              }
                            }
                          }, backgorundColor: color.primaryColor,
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
