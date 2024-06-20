import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/views/checkout_screen/checkout_screen.dart';
import 'package:mham/views/checkout_screen/widget/forms.dart';

class BuildInformationCard extends StatelessWidget {
  const BuildInformationCard({super.key});

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: color.primaryColor.withOpacity(0.1),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildFormUnderLine(
            inputType: TextInputType.text,
            hint: locale.hintAddress,
            title: locale.addressDetails,
            controller: addressController,
            validator: (value) {
              return Validation.validateField(
                  value, locale.addressDetails, context);
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          BuildFormUnderLine(
            inputType: TextInputType.text,
            suffixIcon: Icon(
              Icons.location_on_sharp,
              color: color.primaryColor,
            ),
            hint: locale.location,
            title: locale.location,
            controller: locationController,
            validator: (value) {
              return Validation.validateField(
                  value, locale.location, context);
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          BuildFormUnderLine(
            inputType: TextInputType.number,
            hint: '1145465788',
            title: locale.mobile,
            controller: mobileController,
            validator: (value) {
              return Validation.validateField(
                  value, locale.mobile, context);
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120.w,
                child: BuildFormUnderLine(
                  inputType: TextInputType.text,
                  hint: 'Akram',
                  title:locale.firstName,
                  controller: firstNameController,
                  validator: (value) {
                    return Validation.validateField(
                        value, locale.firstName, context);
                  },
                ),
              ),
              SizedBox(
                width: 120.w,
                child: BuildFormUnderLine(
                  inputType: TextInputType.text,
                  hint: 'Ahmed',
                  title: locale.lastName,
                  controller: lastNameController,
                  validator: (value) {
                    return Validation.validateField(
                        value, locale.lastName, context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
