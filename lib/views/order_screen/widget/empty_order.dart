import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';


class BuildEmptyOrder extends StatelessWidget {
  const BuildEmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 150.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageConstant.cart),
            SizedBox(height: 12.h),
            Text(locale.noOrdersFound,
              style:
              font.bodyMedium!.
              copyWith(fontSize: 18.sp),),
            SizedBox(height: 22.h),
            BuildDefaultButton(
                text: locale.startShopping,
                width: 100.w,
                height: 26.h,
                borderRadius: 8.r,
                onPressed: () {
                  HomeCubit.get(context)
                      .getAllProduct();
                  LayoutCubit.get(context).changeIndex(0);
                },
                backgorundColor: color.backgroundColor,
                colorText: ColorConstant.brown)
          ],
        ),
      ),
    );
  }
}
