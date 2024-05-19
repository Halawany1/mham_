import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/views/order_details_screen/widget/card_product_details.dart';

import '../../../core/components/text_form_field_component.dart';
import '../../../core/error/validation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildReturnOrderPopUp extends StatelessWidget {
  const BuildReturnOrderPopUp({super.key,

    required this.orderId,required this.returns});
  final List<Map<String,dynamic>> returns;
  final int orderId;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;

    final locale = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: color.cardColor,
      surfaceTintColor: color.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            8.r),
      ),
      title: Text(
        locale.returnProduct,
        style: font.bodyLarge!.copyWith(
            fontSize: 15.sp
        ),
      ),
      content: SizedBox(
        height: 90.h,
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
             locale.areYouSureTOReturnProduct,
              style: font.bodyMedium!
                  .copyWith(
                  fontSize: 14.sp
              ),),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween,
              children: [
                BuildDefaultButton(
                    text: locale.cancel,
                    width: 90.w,
                    height: 25.h,
                    borderRadius: 5.r,
                    onPressed: () {
                      reasonController.clear();
                      Navigator.pop(context);
                    },
                    backgorundColor:
                    color
                        .scaffoldBackgroundColor,
                    colorText: color
                        .primaryColor),
                BuildDefaultButton(
                    text: locale.returnn,
                    width: 90.w,
                    borderRadius: 5.r,
                    height: 25.h,
                    onPressed: () {
                      reasonController.clear();
                      HomeCubit.get(context)
                          .returnOrder(
                        orderId: orderId,
                          returns:returns);
                      Navigator.pop(context);
                    },
                    backgorundColor:
                    color.backgroundColor,
                    colorText: ColorConstant
                        .brown),
              ],)
          ],
        ),
      ),
    );
  }
}
