import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/3rd_party_services_component.dart';
import 'package:mham/core/components/drop_down_menu.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_and_link_row_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/driver_layout/driver_layout_screen.dart';
import 'package:mham/layout/layout_screen.dart';

var _formKey = GlobalKey<FormState>();
var userNameController = TextEditingController();
var phoneController = TextEditingController();
var passwordController = TextEditingController();
var confirmPasswordController = TextEditingController();
var addressController = TextEditingController();
var driverLicenseController = TextEditingController();
XFile ?imageFileOne;
class SignUpScreen extends StatelessWidget {
  const  SignUpScreen({super.key,
    required this.client
  });
  final bool client;
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
  addressController.clear();
  driverLicenseController.clear();
  AuthenticationCubit.get(context).countryId=null;
  AuthenticationCubit.get(context).selectedCountry=null;
}

    final locale = AppLocalizations.of(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is NoInternetAuthState){
          showMessageResponse(message: locale.noInternetConnection,
              context: context, success: false);
        }
        var cubit=context.read<AuthenticationCubit>();
        if(client){
          if (state is SuccessRegisterUserState) {
            clearAllData();
            CacheHelper.saveData(
                key: AppConstant.token,
                value: cubit.userModel!.token);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LayoutScreen())
              ,(route) => false,);
            HomeCubit.get(context).getNotification();
          }

          if (state is ErrorRegisterUserState) {
            showMessageResponse(message: state.error,
                context: context, success: false);
          }
        }else{
          if (state is SuccessRegisterUserState) {
            clearAllData();
           // HomeCubit.get(context).getNotification();
            showMessageResponse(message: 'your account requires approval from our admin team',
                context: context, success: true);
          }

          if (state is ErrorRegisterUserState) {
            showMessageResponse(message: state.error,
                context: context, success: false);
          }
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
                        if(!client)
                        BuildTextFormField(
                            maxLength: 120,
                            keyboardType: TextInputType.text,
                            cubit: cubit,
                            validator: (value) {
                              return null;
                            },
                            title: locale.address,
                            hint:locale.enterAddress,
                            controller: addressController),
                        if(!client)
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
                        if(!client)
                        SizedBox(
                          height: 20.h,
                        ),
                        if(!client)
                        BuildTextFormField(
                            maxLength: 120,
                            keyboardType: TextInputType.text,
                            cubit: cubit,

                            validator: (value) {
                              return Validation.validateField(
                                  value, driverLicenseController.text, context);
                            },
                            title: 'Driving License',
                            hint: 'Driving License',
                            readOnly: true,
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              imageFileOne = await picker.pickImage(
                                source: ImageSource.gallery,
                                // alternatively, use ImageSource.gallery
                                maxWidth: 400,
                              );
                              if (imageFileOne == null) return;
                              final String imagePath = imageFileOne!.path;
                              final String imageName = imagePath
                                  .substring(imagePath.lastIndexOf('/') + 1);

// Set the image filename to the imageController
                              driverLicenseController.text = imageName;
                            },
                            controller: driverLicenseController),
                        SizedBox(
                          height: 35.h,
                        ),
                        state is LoadingRegisterUserState
                            ? Center(child: CircularProgressIndicator(color: color.primaryColor,))
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
                              if(client){
                                cubit.userSignUp(
                                    phone: countryCode + phoneController.text,
                                    userName: userNameController.text,
                                    password: passwordController.text,
                                    countryId: cubit.countriesId[cubit.countryId]!,
                                    confirmPassword: confirmPasswordController
                                        .text,
                                    lang:LayoutCubit.get(context).lang);
                              }else{
                                XFile? driverLicense = imageFileOne;
                               print(cubit.countriesId[cubit.countryId]!);
                                cubit.userSignUpForDriver(
                                  country: cubit.countriesId[cubit.countryId]!,
                                  address: addressController.text,
                                    drivingLicence: driverLicense==null?'':driverLicense.path,
                                    phone: countryCode + phoneController.text,
                                    userName: userNameController.text,
                                    password: passwordController.text,
                                    confirmPassword: confirmPasswordController
                                        .text,
                                    lang:LayoutCubit.get(context).lang);
                              }

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
