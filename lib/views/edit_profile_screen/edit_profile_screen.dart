import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/profile_cubit/profile_cubit.dart';
import 'package:mham/core/components/drop_down_menu.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/sign_up_screen/sign_up_screen.dart';

import '../../core/helper/helper.dart';

var _formKey = GlobalKey<FormState>();

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.driver});

  final bool driver;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;

    final locale = AppLocalizations.of(context);


    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is NoInternetProfileState) {
          showMessageResponse(
              message: locale.noInternetConnection,
              context: context,
              success: false);
        }
        if (state is SuccessGetCountriesState) {
          if (driver) {
            AuthenticationCubit.get(context).countryId =
                LayoutCubit.get(context).lang == 'en'
                    ? ProfileCubit.get(context)
                        .driverProfileModel!
                        .driver!
                        .user!
                        .country!
                        .countryNameEn
                    : ProfileCubit.get(context)
                        .driverProfileModel!
                        .driver!
                        .user!
                        .country!
                        .countryNameAr;
            ProfileCubit.get(context).image=null;
          } else {
            AuthenticationCubit.get(context).countryId =
                LayoutCubit.get(context).lang == 'en'
                    ? ProfileCubit.get(context)
                        .profileModel!
                        .user!
                        .country!
                        .countryNameEn!
                    : ProfileCubit.get(context)
                        .profileModel!
                        .user!
                        .country!
                        .countryNameAr!;
          }
        }
        if (state is SuccessUpdateProfileState) {
          Helper.pop(context);
          ProfileCubit.get(context).image=null;
        }
      },
      builder: (context, state) {
        var cubit = context.read<AuthenticationCubit>();
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is SuccessUpdateProfileState) {
              Helper.pop(context);
            }
            if (state is ErrorUpdateProfileState) {
              showMessageResponse(
                  message: state.message.toString(),
                  context: context,
                  success: false);
            }
            if (state is SuccessUpdateProfileDriverState) {
              Helper.pop(context);
              ProfileCubit.get(context).image=null;
            }
            if (state is ErrorUpdateProfileDriverState) {
              showMessageResponse(
                  message: state.message.toString(),
                  context: context,
                  success: false);
            }
          },
          builder: (context, state) {
            var profileCubit = context.read<ProfileCubit>();
            return WillPopScope(
              onWillPop: () async {
                Helper.pop(context);
                ProfileCubit.get(context).image=null;
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 0.h,

                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: color.backgroundColor,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 190.h,
                          child: Stack(

                            children: [
                              Container(
                                height: 150.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: color.backgroundColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20.r),
                                      bottomRight: Radius.circular(20.r),
                                    )),
                              ),
                              Positioned(
                                top: 20.h,
                                left: LayoutCubit.get(context).lang == 'en'
                                    ? 20.w
                                    : null,
                                right: LayoutCubit.get(context).lang == 'ar'
                                    ? 20.w
                                    : null,
                                child: InkWell(
                                  onTap: () {
                                    ProfileCubit.get(context).image=null;
                                    Helper.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 30.r,
                                    color: color.primaryColor,
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 20.h,
                                  left: LayoutCubit.get(context).lang == 'en'
                                      ? 123.w
                                      : 90.w,
                                  child: Text(
                                    locale.editProfile,
                                    style: font.bodyLarge!
                                        .copyWith(fontSize: 20.sp),
                                  )),
                              if(driver&&ProfileCubit.get(context).driverProfileModel
                              !.driver!.user!.avatar==null)
                              Positioned(
                                top: 95.h,
                                left: 130.w,
                                child: CircleAvatar(
                                  radius: 45.r,
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    size: 30.r,
                                  ),
                                ),
                              ),
                              if(driver&&
                                  ProfileCubit.get(context).driverProfileModel
                                      !.driver!.user!.avatar!=null)
                                Positioned(
                                  top: 95.h,
                                  left: 130.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40.r),
                                    child: Image.network(
                                     AppConstant.baseImage+
                                         ProfileCubit.get(context).
                                      driverProfileModel!.driver!.user!.avatar!,
                                      width: 90.w,
                                      fit: BoxFit.cover,
                                      height: 90.w,
                                    ),
                                  )
                                ),
                              if(!driver)
                              Positioned(
                                top: 95.h,
                                left: 130.w,
                                child: profileCubit.image!=null?
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40.r),
                                  child: Image.file(profileCubit.image!,
                                    width: 90.w,
                                    fit: BoxFit.cover,
                                    height: 90.w,
                                  ),
                                )
                                :CircleAvatar(
                                  radius: 45.r,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    size: 30.r,
                                  ),
                                ),
                              ),
                              if(driver)
                              Positioned(
                                top: 145.h,
                                right: 140.w,
                                child: GestureDetector(
                                  onTap: () {
                                    profileCubit.pickImage();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:color.primaryColor,
                                    child: Icon(Icons.camera_alt_outlined,
                                      color: color.backgroundColor,),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(25.h),
                          child: Column(
                            children: [
                              BuildTextFormField(
                                  withBorder: true,
                                  maxLength: 45,
                                  keyboardType: TextInputType.name,
                                  cubit: cubit,
                                  validator: (value) {
                                    return Validation.validateFirstName(
                                        value, context);
                                  },
                                  title: locale.userName,
                                  hint: locale.userName,
                                  controller: userNameController),
                              SizedBox(
                                height: 20.h,
                              ),
                              BuildTextFormField(
                                  withBorder: true,
                                  maxLength: 15,
                                  keyboardType: TextInputType.number,
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
                                    locale.country,
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
                                  withBorder: true,
                                  maxLength: 120,
                                  keyboardType: TextInputType.text,
                                  cubit: cubit,
                                  validator: (value) {
                                    return null;
                                  },
                                  title: locale.address,
                                  hint: locale.address,
                                  controller: addressController),
                              SizedBox(
                                height: 20.h,
                              ),
                              if(CacheHelper.getData(key: AppConstant.driverId)!=null)
                              BuildTextFormField(
                                  maxLength: 120,
                                  keyboardType: TextInputType.text,
                                  cubit: cubit,
                                  validator: (value) {
                                    return Validation.validateField(value,
                                        driverLicenseController.text, context);
                                  },
                                  title: 'Driving License',
                                  hint: 'Driving License',
                                  withBorder: true,
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
                                    final String imageName =
                                        imagePath.substring(
                                            imagePath.lastIndexOf('/') + 1);

// Set the image filename to the imageController
                                    driverLicenseController.text = imageName;
                                  },
                                  controller: driverLicenseController),
                              SizedBox(
                                height: 50.h,
                              ),
                              state is LoadingUpdateProfileState ||
                                      state is LoadingUpdateProfileDriverState
                                  ? Center(
                                      child: CircularProgressIndicator.adaptive(
                                          valueColor: AlwaysStoppedAnimation<Color>(color.primaryColor)
                                      ))
                                  : BuildDefaultButton(
                                      text: locale.save,
                                      borderRadius: 10.r,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (driver) {
                                            profileCubit.updateProfileForDriver(
                                              avatar: profileCubit.image!=null?profileCubit.image!.path:'',
                                                lang: LayoutCubit.get(context)
                                                    .lang,
                                                address: addressController.text,
                                                country: cubit.countriesId[
                                                    cubit.countryId]!,
                                                drivingLicence:
                                                    imageFileOne == null
                                                        ? ''
                                                        : imageFileOne!.path,
                                                mobile: phoneController.text,
                                                userName:
                                                    userNameController.text);
                                          } else {
                                            profileCubit.updateProfile(
                                                driver: driver,
                                                userName:
                                                    userNameController.text,
                                                countryId: cubit.countriesId[
                                                    cubit.countryId]!,
                                                phone: phoneController.text);
                                          }
                                        }
                                      },
                                      backgorundColor: color.backgroundColor,
                                      colorText: ColorConstant.brown),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
