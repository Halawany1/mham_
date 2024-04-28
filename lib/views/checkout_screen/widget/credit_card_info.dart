import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/views/checkout_screen/checkout_screen.dart';
import 'package:mham/views/checkout_screen/widget/forms.dart';


class BuildCreditCardInformation extends StatelessWidget {
  const BuildCreditCardInformation({super.key});

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
          SizedBox(
            height: 15.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageConstant.creditCard),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locale.credit,
                style: font.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            locale.addYourCard,
            style: font.bodyLarge!.copyWith(fontSize: 19.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          BuildFormCheckout(
            inputType: TextInputType.number,
            widthForm: 136.w,
            hint: '**** **** **** ****',
            title: locale.cardNumber,
            controller: cardNumberController,
            validator: (value) {
              return Validation.validateField(
                  value, locale.cardNumber, context);
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          BuildFormCheckout(
            inputType: TextInputType.text,
            widthForm: 136.w,
            hint: locale.monthAndYear,
            title: locale.expiryDate,
            controller: expiryDateController,
            validator: (value) {
              return Validation.validateField(
                  value, locale.expiryDate, context);
            },
          ),
          SizedBox(
            height: 15.h,
          ),
          BuildFormCheckout(
            inputType: TextInputType.number,
            hint:
            locale.enterThreeDigitCode,
            title: locale.cvv,
            controller: cvvController,
            validator: (value) {
              return Validation.validateField(
                  value, locale.cvv, context);
            },
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
