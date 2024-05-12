import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';


class BuildCartEmpty extends StatelessWidget {
  const BuildCartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return  Center(
      child: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstant.cart),
            SizedBox(
              height: 10.h,
            ),
            Text(
              locale.cartEmpty,
              style: font.bodyMedium!
                  .copyWith(fontSize: 16.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            BuildDefaultButton(
                text: locale.startShopping,
                width: 120.w,
                height: 26.h,
                fontSize: 12.sp,
                borderRadius: 8.r,
                onPressed: () {
                  HomeCubit.get(context)
                      .getAllProduct();
                  Helper.pop(context);
                },
                backgorundColor: color.backgroundColor,
                colorText: ColorConstant.brown)
          ],
        ),
      ),
    );
  }
}
