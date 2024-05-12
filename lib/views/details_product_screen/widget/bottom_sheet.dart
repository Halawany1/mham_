import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/start_with_driver_or_customer_screen/start_with_driver_or_customer_screen.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';

class BuildBottomSheet extends StatelessWidget {
  const BuildBottomSheet ({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    var cubit = HomeCubit.get(context);
    return Container(
      color: color.hoverColor,
      padding: EdgeInsets.all(15.h),
      child: BuildDefaultButton(
          text: cubit.oneProductModel!.product!.inCart!=null&&
              cubit.oneProductModel!.product!.inCart==true
              ? locale.addedToCart
              : locale.addToCart,
          borderRadius: 12.r,
          height: 32.h,
          onPressed: () {

            if (cubit.oneProductModel!.product!.inCart==null) {
              Helper.push(context: context,widget: GetStartScreen());
            }else{
              CartCubit.get(context).addToCart(
                  token: CacheHelper.getData(
                      key: AppConstant.token),
                  id: cubit.oneProductModel!.product!
                      .productsId!,
                  quantity: cubit.quantity);
            }
          },
          backgorundColor:
          cubit.oneProductModel!.product!.inCart!=null&&
              cubit.oneProductModel!.product!.inCart==true
              ? Colors.grey
              : color.backgroundColor,
          colorText: ColorConstant.brown),
    );
  }
}
