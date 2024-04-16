import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/multi_selected_item_component.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/components/row_product_and_see_all_component.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/cart_screen/cart_screen.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';
import 'package:mham/views/home_screen/widget/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/home_screen/widget/products_not_found.dart';
import 'package:mham/views/search_screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    var color = Theme.of(context);
    var font = Theme
        .of(context)
        .textTheme;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          body: cubit.productModel==null?
              Center(child:
              BuildImageLoader(assetName: ImageConstant.logo))
              :SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BuildSearchFormField(
                            onTap: () {

                              cubit.allProducts.clear();
                             Helper.push(context, SearchScreen());
                            },
                            readOnly: true,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(FontAwesomeIcons.bell,
                            color: color.primaryColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              Helper.push(context, CartScreen());
                            },
                            child: Icon(
                              FontAwesomeIcons.shoppingCart,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            ImageConstant.ads,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.h),
                            child: Text(
                              textAlign: TextAlign.center,
                              locale.startYourjournyWithUs,
                              style: font.bodyMedium?.copyWith(
                                  fontSize: 15.sp,
                                  color: color.backgroundColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        locale.whatAreYouLookingFor,
                        style: font.bodyMedium,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCategory(
                            image: ImageConstant.carParts,
                            text: locale.spareParts,
                            onTap: () {},
                          ),
                          BuildCategory(
                            image: ImageConstant.tires,
                            text: locale.tiresAndWheels,
                            onTap: () {},
                          ),
                          BuildCategory(
                            image: ImageConstant.batteries,
                            text: locale.batteries,
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCategory(
                            image: ImageConstant.motorOil,
                            text: locale.motorOil,
                            onTap: () {},
                          ),
                          BuildCategory(
                            image: ImageConstant.rimCover,
                            text: locale.rimCover,
                            onTap: () {},
                          ),
                          BuildCategory(
                            image: ImageConstant.accessories,
                            text: locale.accessories,
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BuildCategory(
                            image: ImageConstant.rim,
                            text: locale.rim,
                            onTap: () {},
                          ),
                          BuildCategory(
                            image: ImageConstant.sparkPlugs,
                            text: locale.sparkPlugs,
                            onTap: () {},
                          ),
                          BuildCategory(
                            image: ImageConstant.liquids,
                            text:locale.liquids,
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            ImageConstant.carFilter,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),

                          Positioned(
                            top: 60.h,
                            right: 20.w,
                            child: BuildDefaultButton(text: locale.requestScrap,
                                height: 17.h,
                                withBorder: true,
                                width: 90.w,
                                borderRadius: 5.r,
                                fontSize: 8.sp,
                                onPressed: () {

                                },
                                backgorundColor: color.scaffoldBackgroundColor,
                                colorText: color.primaryColor),
                          ),
                          Positioned(
                            top: 5.h,
                            left: 12.w,
                            child: Text(locale.enterYourData,
                              style: font.bodyMedium!.copyWith(
                                  color: color.cardColor
                              ),),
                          ),
                          Positioned(
                            top: 30.h,
                            left: 12.w,
                            child: BuildMultiSelectDropDownWidget(
                                text: locale.selectType,
                                controller: cubit.carController,
                                onOptionSelected: (value) {
                                  cubit.selectCarModels(value: value);
                                  cubit.removeSelectionCarModels();
                                  cubit.getAllProduct(
                                    lang: 'en',
                                    carId: cubit.carController.selectedOptions
                                        .isEmpty
                                        ? null
                                        : cubit.carController.selectedOptions
                                        .first.value,
                                  );
                                },
                                selectedOptions: cubit.selectedCarType,
                                options: cubit.carType),
                          ),
                          Positioned(
                            top: 62.h,
                            left: 12.w,
                            child: BuildMultiSelectDropDownWidget(
                                text: locale.selectModel,
                                controller: cubit.modelController,
                                onOptionSelected: (value) {
                                  cubit.selectCarYear(value: value);
                                  cubit.removeSelectionYearModels();
                                  cubit.getAllProduct(
                                    lang: 'en',
                                    carModelId: cubit.modelController
                                        .selectedOptions.isEmpty
                                        ? null
                                        : cubit.modelController.selectedOptions
                                        .first.value,
                                    carId: cubit.carController.selectedOptions
                                        .isEmpty
                                        ? null
                                        : cubit.carController.selectedOptions
                                        .first.value,
                                  );
                                },
                                selectedOptions: cubit.selectedCarModels,
                                options: cubit.carModels),
                          ),
                          Positioned(
                            top: 94.h,
                            left: 12.w,
                            child: BuildMultiSelectDropDownWidget(
                                text: locale.selectYear,
                                controller: cubit.yearController,
                                onOptionSelected: (value) {
                                  cubit.getAllProduct(
                                    lang: 'en',
                                    availableYearId: cubit.yearController
                                        .selectedOptions.isEmpty
                                        ? null
                                        : cubit.yearController.selectedOptions
                                        .first.value,
                                    carModelId: cubit.modelController
                                        .selectedOptions.isEmpty
                                        ? null
                                        : cubit.modelController.selectedOptions
                                        .first.value,
                                    carId: cubit.carController.selectedOptions
                                        .isEmpty
                                        ? null
                                        : cubit.carController.selectedOptions
                                        .first.value,
                                  );
                                },
                                selectedOptions: cubit.selectedCarYears,
                                options: cubit.carYears),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      BuildRowTextAndSeeAll(
                        text: locale.products,
                        empty: false,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      cubit.homeProducts.isEmpty?
                        BuildNotFoundProduct()
                          : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cubit.homeProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 4.w,
                            mainAxisExtent: 230.h),
                        itemBuilder: (context, index) =>
                            InkWell(
                              onTap: () {
                                cubit.increaseReview(cubit.homeProducts[index].productsId!);
                                LayoutCubit.get(context).changeHideNav(true);
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    DetailsScreen(index: index),));
                              },
                              child: BuildProductCard(
                                isOffer: cubit.homeProducts[index].isOffer!,
                                offerPrice: cubit.homeProducts[index].offerPrice,
                                description: cubit
                                    .homeProducts[index].businessCategory!
                                    .bcNameEn!,
                                type: cubit.homeProducts[index].type!,
                                rate: double.parse(
                                    cubit.homeProducts[index].rating.toString()),
                                review: cubit.homeProducts[index].reviewCount,
                                price: cubit.homeProducts[index].price!,
                                title: cubit.homeProducts[index].productsName!,
                              ),
                            ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      Text(
                        locale.findOutWhatFitsYourTypeOfCar,
                        style: font.bodyMedium,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back_ios),
                          Container(
                              width: 250.w,
                              height: 57.h,
                              decoration: BoxDecoration(
                                color: color.cardColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Image.asset(
                                      ImageConstant.cars(0),
                                      width: 30.w,
                                      height: 30.w,
                                    ),
                                    Image.asset(
                                      ImageConstant.cars(1),
                                      width: 30.w,
                                      height: 30.w,
                                    ),
                                    Image.asset(
                                      ImageConstant.cars(2),
                                      width: 30.w,
                                      height: 30.w,
                                    ),
                                    Image.asset(
                                      ImageConstant.cars(3),
                                      width: 30.w,
                                      height: 30.w,
                                    ),
                                    Image.asset(
                                      ImageConstant.cars(4),
                                      width: 30.w,
                                      height: 30.w,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ])),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
