import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';
import 'package:mham/views/home_screen/widget/car_filter.dart';
import 'package:mham/views/home_screen/widget/products_not_found.dart';
import 'package:mham/views/see_all_screen/widget/filter.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key,
     this.carType=false,
    required this.title});

  final String title;
  final bool carType;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return WillPopScope(
          onWillPop: ()async {
            cubit.productModel = null;
            CacheHelper.removeData(
                key: AppConstant.businessId);
            CacheHelper.removeData(
                key: AppConstant.carId);
            Helper.pop(context);
            cubit.getAllProduct();
            return true;
          },
          child: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  if (cubit.productModel!.totalPages! >
                      cubit.productModel!.currentPage!) {
                    if (context.mounted) {
                      if(!carType){
                        cubit.getAllProduct(
                          busniessId:
                          CacheHelper.getData(key: AppConstant.businessId),
                          page: cubit.productModel!.currentPage! + 1,
                        );
                      }else{
                        cubit.getAllProduct(
                          carId:
                          CacheHelper.getData(key: AppConstant.carId),
                          page: cubit.productModel!.currentPage! + 1,
                        );
                      }

                    }
                  } else {
                    return false;
                  }
                }
                return false;
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Column(
                      children: [
                        Image.asset(
                          ImageConstant.splash,
                          width: 80.w,
                          height: 40.w,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  cubit.productModel = null;
                                  CacheHelper.removeData(
                                      key: AppConstant.businessId);
                                  CacheHelper.removeData(
                                      key: AppConstant.carId);
                                  Helper.pop(context);
                                  cubit.getAllProduct();
                                },
                                child: Icon(
                                  LayoutCubit.get(context).lang == 'en'
                                      ? FontAwesomeIcons.arrowLeft
                                      : FontAwesomeIcons.arrowRight,
                                  color: color.primaryColor,
                                )),
                            SizedBox(
                              width: 20.w,
                            ),
                            BuildSearchFormField(
                              width: 230.w,
                              onSave: (value) {
                                cubit.productModel = null;
                                cubit.allProducts.clear();
                                if (value!.isNotEmpty) {
                                  if(!carType){
                                    cubit.getAllProduct(
                                      busniessId:
                                      CacheHelper.getData(key: AppConstant.businessId),
                                      search: value,
                                    );
                                  }else{
                                    cubit.getAllProduct(
                                      carId:
                                      CacheHelper.getData(key: AppConstant.carId),
                                      search: value,
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        // if (CacheHelper.getData(key: AppConstant.businessId) ==
                        //         1 ||
                        //     CacheHelper.getData(key: AppConstant.businessId) ==
                        //         6||carType)
                        //   BuildCarFilter(),
                        // if (CacheHelper.getData(key: AppConstant.businessId) ==
                        //         1 ||
                        //     CacheHelper.getData(key: AppConstant.businessId) ==
                        //         6||carType)
                        //   SizedBox(
                        //     height: 10.h,
                        //   ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: font.bodyMedium,
                            ),
                            GestureDetector(
                              onTap: () {
                                filterPopUp(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.filter,
                                color: color.primaryColor,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        cubit.productModel == null ||
                                state is LoadingGetAllProduct
                            ? Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Center(
                                  child: BuildImageLoader(
                                    assetName: ImageConstant
                                        .logo, // Replace with your asset path
                                  ),
                                ),
                              )
                            : cubit.allProducts.isEmpty
                                ? BuildNotFoundProduct()
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cubit.allProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10.h,
                                            crossAxisSpacing: 4.w,
                                            mainAxisExtent: 258.h),
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        cubit.oneProductModel=null;
                                        cubit.getProductDetails(
                                            id: cubit.allProducts[index]
                                                .productsId!);
                                        cubit.increaseReview(cubit
                                            .allProducts[index].productsId!);
                                        Helper.push(context: context,widget:
                                        DetailsScreen(
                                        ),);
                                      },
                                      child: BuildProductCard(
                                        outOfStock:cubit.allProducts[index].qntInStock==0,
                                        id: cubit
                                            .allProducts[index].productsId!,
                                        inCart:
                                            cubit.allProducts[index].inCart ??
                                                false,
                                        inFavorite: cubit.allProducts[index]
                                                .inFavourite ??
                                            false,
                                        isOffer:
                                            cubit.allProducts[index].isOffer!,
                                        offerPrice:
                                            cubit.allProducts[index].offerPrice,
                                        description: cubit.allProducts[index]
                                            .businessCategory!.bcNameEn!,
                                        type: cubit.allProducts[index].type!,
                                        rate: double.parse(cubit
                                            .allProducts[index].averageRate
                                            .toString()),
                                        review: cubit
                                            .allProducts[index].reviewCount,
                                        price: cubit.allProducts[index].price!,
                                        title: cubit
                                            .allProducts[index].productsName!,
                                      ),
                                    ),
                                  ),
                      ],
                    ),
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
