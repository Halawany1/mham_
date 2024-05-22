import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/multi_selected_item_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/home_screen/widget/request_scrap.dart';

class BuildCarFilter extends StatelessWidget {
  const BuildCarFilter({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    var cubit = HomeCubit.get(context);
    return Stack(
      children: [
        Image.asset(
          ImageConstant.carFilter,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        if (cubit.myScrapModel != null)
          Positioned(
            top: 60.h,
            right: 20.w,
            child: BuildDefaultButton(
                text: cubit.myScrapModel!.scraps!.isNotEmpty&&
                    cubit.myScrapModel!.scraps![0].status != "Rejected"
                    ? cubit.myScrapModel!.scraps![0].status!
                    : locale.requestScrap,
                height: 17.h,
                withBorder: true,
                width: 100.w,
                borderRadius: 5.r,
                fontSize: 8.sp,
                onPressed: () {
                  if (cubit.myScrapModel!.scraps!.isEmpty ||
                      cubit.myScrapModel!.scraps![0].status == "Rejected") {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return BuildRequestScrap();
                      },
                    );
                  }
                },
                backgorundColor: cubit.myScrapModel!.scraps!.isNotEmpty&&
                    cubit.myScrapModel!.scraps![0].status != "Rejected"
                    ? Colors.grey
                    : color.scaffoldBackgroundColor,
                colorText: color.primaryColor),
          ),
        Positioned(
          top: 5.h,
          left: 12.w,
          child: Text(
            locale.enterYourData,
            style: font.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
        Positioned(
          top: 30.h,
          left: 12.w,
          child: BuildMultiSelectDropDownWidget(
              text: locale.selectType,
              controller: HomeCubit.get(context).carController,
              onOptionSelected: (value) {
                HomeCubit.get(context).selectCarModels(value: value);
                HomeCubit.get(context).removeSelectionCarModels();
                HomeCubit.get(context).getAllProduct(
                  busniessId: CacheHelper.getData(key: AppConstant.businessId),
                  carId: HomeCubit.get(context)
                          .carController
                          .selectedOptions
                          .isEmpty
                      ? null
                      : HomeCubit.get(context)
                          .carController
                          .selectedOptions
                          .first
                          .value,
                );
              },
              selectedOptions: HomeCubit.get(context).selectedCarType,
              options: HomeCubit.get(context).carType),
        ),
        Positioned(
          top: 62.h,
          left: 12.w,
          child: BuildMultiSelectDropDownWidget(
              text: locale.selectModel,
              controller: HomeCubit.get(context).modelController,
              onOptionSelected: (value) {
                HomeCubit.get(context).selectCarYear(value: value);
                HomeCubit.get(context).removeSelectionYearModels();
                HomeCubit.get(context).getAllProduct(
                  busniessId: CacheHelper.getData(key: AppConstant.businessId),
                  carModelId: HomeCubit.get(context)
                          .modelController
                          .selectedOptions
                          .isEmpty
                      ? null
                      : HomeCubit.get(context)
                          .modelController
                          .selectedOptions
                          .first
                          .value,
                  carId: HomeCubit.get(context)
                          .carController
                          .selectedOptions
                          .isEmpty
                      ? null
                      : HomeCubit.get(context)
                          .carController
                          .selectedOptions
                          .first
                          .value,
                );
              },
              selectedOptions: HomeCubit.get(context).selectedCarModels,
              options: HomeCubit.get(context).carModels),
        ),
        Positioned(
          top: 94.h,
          left: 12.w,
          child: BuildMultiSelectDropDownWidget(
              text: locale.selectYear,
              controller: HomeCubit.get(context).yearController,
              onOptionSelected: (value) {
                HomeCubit.get(context).getAllProduct(
                  busniessId: CacheHelper.getData(key: AppConstant.businessId),
                  availableYearId: HomeCubit.get(context)
                          .yearController
                          .selectedOptions
                          .isEmpty
                      ? null
                      : HomeCubit.get(context)
                          .yearController
                          .selectedOptions
                          .first
                          .value,
                  carModelId: HomeCubit.get(context)
                          .modelController
                          .selectedOptions
                          .isEmpty
                      ? null
                      : HomeCubit.get(context)
                          .modelController
                          .selectedOptions
                          .first
                          .value,
                  carId: HomeCubit.get(context)
                          .carController
                          .selectedOptions
                          .isEmpty
                      ? null
                      : HomeCubit.get(context)
                          .carController
                          .selectedOptions
                          .first
                          .value,
                );
              },
              selectedOptions: HomeCubit.get(context).selectedCarYears,
              options: HomeCubit.get(context).carYears),
        ),
      ],
    );
  }
}
