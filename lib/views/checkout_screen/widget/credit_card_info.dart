import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
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
    var cubit = HomeCubit.get(context);

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
              GestureDetector(
                onTap: () {
                  cubit.changeWallet(false);
                },
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.creditCard,size: 35.r,
                        color: cubit.wallet?
                        color.backgroundColor.withOpacity(0.7):color.backgroundColor),
                    SizedBox(height: 10.h,),
                    Text(
                      locale.credit,
                      style: font.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color: cubit.wallet?
                          color.primaryColor.withOpacity(0.5):color.primaryColor),

                    ),
                  ],
                ),
              ),
              SizedBox(width: 50.w,),
              GestureDetector(
                onTap: () {
                  cubit.changeWallet(true);

                },
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.wallet,size: 35.r,
                        color:cubit.wallet?
                        color.backgroundColor:color.backgroundColor.withOpacity(0.7)),
                    SizedBox(height: 10.h,),
                    Text(
                      'Mham Wallet',
                      style: font.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700,
                          fontSize: 15.sp,
                          color:cubit.wallet?
                          color.primaryColor:color.primaryColor.withOpacity(0.5)),

                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(
            height: 5.h,
          ),

          SizedBox(
            height: 15.h,
          ),

          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
