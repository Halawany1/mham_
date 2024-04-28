import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/home_screen/widget/category.dart';
import 'package:mham/views/see_all_screen/see_all_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildAllCategories extends StatelessWidget {
  const BuildAllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var locale = AppLocalizations.of(context);
    return Column(children: [
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          BuildCategory(
            image: ImageConstant.carParts,
            text: locale.spareParts,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 1);
              cubit.getAllProduct(
                busniessId: 1,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.spareParts,
                  ));
            },
          ),
          BuildCategory(
            image: ImageConstant.tires,
            text: locale.tiresAndWheels,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 4);
              cubit.getAllProduct(
                busniessId: 4,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.tiresAndWheels,
                  ));
            },
          ),
          BuildCategory(
            image: ImageConstant.batteries,
            text: locale.batteries,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 5);
              cubit.getAllProduct(

                busniessId: 5,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.batteries,
                  ));
            },
          ),
        ],
      ),
      SizedBox(
        height: 15.h,
      ),
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          BuildCategory(
            image: ImageConstant.motorOil,
            text: locale.motorOil,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 3);
              cubit.getAllProduct(
                busniessId: 3,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.motorOil,
                  ));
            },
          ),
          BuildCategory(
            image: ImageConstant.rimCover,
            text: locale.rimCover,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 9);
              cubit.getAllProduct(
                busniessId: 9,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.rimCover,
                  ));
            },
          ),
          BuildCategory(
            image: ImageConstant.accessories,
            text: locale.accessories,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 2);
              cubit.getAllProduct(
                busniessId: 2,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.accessories,
                  ));
            },
          ),
        ],
      ),
      SizedBox(
        height: 15.h,
      ),
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          BuildCategory(
            image: ImageConstant.rim,
            text: locale.rim,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 8);
              cubit.getAllProduct(
                busniessId: 8,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.rim,
                  ));
            },
          ),
          BuildCategory(
            image: ImageConstant.sparkPlugs,
            text: locale.sparkPlugs,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 6);
              cubit.getAllProduct(
                busniessId: 6,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.sparkPlugs,
                  ));
            },
          ),
          BuildCategory(
            image: ImageConstant.liquids,
            text: locale.liquids,
            onTap: () {
              CacheHelper.saveData(
                  key: AppConstant.businessId,
                  value: 7);
              cubit.getAllProduct(
                busniessId: 7,
              );
              Helper.push(
                  context,
                  SeeAllScreen(
                    title: locale.liquids,
                  ));
            },
          ),
        ],
      ),

    ],);
  }
}
