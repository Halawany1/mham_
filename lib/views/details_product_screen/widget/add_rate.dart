import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';

class BuildAddRate extends StatelessWidget {
  const BuildAddRate({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    var locale = AppLocalizations.of(context);
    var font = Theme
        .of(context)
        .textTheme;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(
            height: 20.h,
          ),
          Text(
            locale.addRate,
            style: font.bodyMedium!
                .copyWith(fontSize: 15.sp),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 190.w,
                height: 54.h,
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10.r),
                    color: color.primaryColor
                        .withOpacity(0.1)),
                child: RatingBarIndicator(
                  rating: cubit.rate.toDouble(),
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: () {
                          cubit.changeRate(value: index + 1);
                        },
                        child: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                  unratedColor: color.primaryColor
                      .withOpacity(0.22),
                  itemCount: 5,
                  itemSize: 30.r,
                  direction: Axis.horizontal,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18.h,
          ),
          BuildTextFormField(
              title: locale.comment,
              hint: locale.writeComment,
              cubit: AuthenticationCubit.get(context),
              controller: comment,
              maxLines: 4,
              contentPadding: true,
              withBorder: true,
              validator: (p0) {
                return null;
              },
              keyboardType: TextInputType.text,
              maxLength: 1000),
          SizedBox(
            height: 18.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state is LoadingAddRateState
                  ? Center(
                  child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(color.primaryColor)
                  ))
                  : BuildDefaultButton(
                  text: locale.addRate,
                  width: 80.w,
                  height: 22.h,
                  fontSize: 12.sp,
                  borderRadius: 8.r,
                  onPressed: () {
                    if (cubit.rate != 0) {
                      cubit.addRate(
                          id: cubit.oneProductModel!
                              .product!.productsId!,
                          rate: cubit.rate,
                          comment:
                          comment.text.isEmpty
                              ? null
                              : comment.text);
                    } else {
                      showMessageResponse(
                          message: locale
                              .addAtLeastOneStar,
                          context: context,
                          success: false);
                    }
                  },
                  backgorundColor:
                  color.backgroundColor,
                  colorText: ColorConstant.brown),
            ],
          ),
        ],);
      },
    );
  }
}
