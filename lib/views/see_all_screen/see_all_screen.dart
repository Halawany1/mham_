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

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({
    super.key,
    required this.title
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();

        return WillPopScope(
          onWillPop: () async{
            cubit.productModel=null;
            CacheHelper.removeData(key: AppConstant.businessId);
            Helper.pop(context);
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
                      cubit.getAllProduct(
                        busniessId:
                        CacheHelper.getData(key: AppConstant.businessId),
                        lang: LayoutCubit.get(context).lang,
                        page: cubit.productModel!.currentPage! + 1,
                      );
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
                                  cubit.productModel=null;
                                  CacheHelper.removeData(key: AppConstant.businessId);
                                  Helper.pop(context);
                                },
                                child: Icon(
                                  LayoutCubit.get(context).lang == 'en'
                                      ? FontAwesomeIcons.arrowLeft
                                      : FontAwesomeIcons.arrowRight,
                                  color: color.hoverColor,
                                )),
                            SizedBox(
                              width: 20.w,
                            ),
                              BuildSearchFormField(
                                width: 248.w,
                                onSave: (value) {
                                  cubit.productModel=null;
                                  cubit.allProducts.clear();
                                  if(value!.isNotEmpty){
                                    cubit.getAllProduct(
                                      busniessId: CacheHelper.getData(key:
                                      AppConstant.businessId),
                                        lang: LayoutCubit.get(context).lang,
                                        search: value);
                                  }

                                },

                              ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        // if( CacheHelper.getData(key: AppConstant.businessId)==1||
                        //     CacheHelper.getData(key: AppConstant.businessId)==6)
                        //   BuildCarFilter(),
                        // if( CacheHelper.getData(key: AppConstant.businessId)==1||
                        //     CacheHelper.getData(key: AppConstant.businessId)==6)
                        //   SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(title,style: font.bodyMedium,),
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
                                assetName:
                                ImageConstant.logo, // Replace with your asset path
                              ),
                            ),
                          )
                              :
                          cubit.allProducts.isEmpty?
                          BuildNotFoundProduct()
                              :
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.allProducts.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 4.w,
                                mainAxisExtent: 230.h),
                            itemBuilder: (context, index) =>
                                InkWell(
                                  onTap: () {
                                    List<String>carModels=[];
                                    if(cubit.allProducts[index].availableYears!=null){
                                      cubit.allProducts[index].availableYears!.forEach((element) {
                                        carModels.add(element.carModel!.car!
                                            .carName!+' '+
                                            element.carModel!.modelName!+' '+
                                            element.availableYear.toString());
                                      });
                                    }

                                    cubit.increaseReview(cubit.allProducts[index].productsId!);
                                    LayoutCubit.get(context).changeHideNav(true);
                                  Helper.push(context, DetailsScreen(
                                    productId:cubit
                                        .allProducts[index]
                                        .productsId! ,
                                    inCart: cubit
                                        .allProducts[index]
                                        .inCart??false,
                                    brand: cubit
                                        .allProducts[index]
                                        .brandName!,
                                    description: cubit
                                        .allProducts[index]
                                        .description!,
                                    isOffer: cubit
                                        .allProducts[index]
                                        .isOffer!,
                                    price: double.parse(cubit
                                        .allProducts[index]
                                        .price!.toString()),
                                    productName: cubit
                                        .allProducts[index]
                                        .productsName!,
                                    rating: double.parse(cubit
                                        .allProducts[index]
                                        .rating!.toString()),
                                    type: cubit
                                        .allProducts[index]
                                        .type!,
                                    category: cubit
                                        .allProducts[index]
                                        .businessCategory!
                                        .bcNameEn!,
                                    warranty: cubit
                                        .allProducts[index]
                                        .warranty,
                                    placementOfVehile: cubit
                                        .allProducts[index]
                                        .frontOrRear,
                                    volt: cubit
                                        .allProducts[index]
                                        .volt,
                                    tyreWidth: cubit
                                        .allProducts[index]
                                        .tyreWidth,
                                    tyreSpreedRate: cubit
                                        .allProducts[index]
                                        .tyreSpeedRate,
                                    tyreHeight: cubit
                                        .allProducts[index]
                                        .tyreHeight,
                                    tyre_engraving: cubit
                                        .allProducts[index]
                                        .tyreEngraving,
                                    maximumTyreLoad: cubit
                                        .allProducts[index]
                                        .maximumTyreLoad,
                                    number_spark_pulgs: cubit
                                        .allProducts[index]
                                        .numberSparkPulgs,
                                    oilType: cubit
                                        .allProducts[index]
                                        .oilType,
                                    madeIn: cubit
                                        .allProducts[index]
                                        .madeIn,
                                    liter: cubit
                                        .allProducts[index]
                                        .liter,
                                    dimension: cubit
                                        .allProducts[index]
                                        .rimDiameter,
                                    ampere: cubit
                                        .allProducts[index]
                                        .ampere,
                                    manufacturerPartNumber: cubit
                                        .allProducts[index]
                                        .manufacturerPartNumber,
                                    productColor: cubit
                                        .allProducts[index]
                                        .color,
                                    batteryReplacementAvailable:
                                    cubit
                                        .allProducts[index]
                                        .batteryReplacementAvailable,
                                    offerPrice:   cubit
                                        .allProducts[index]
                                        .offerPrice,
                                    carModels: carModels,
                                  ));
                                  },
                                  child: BuildProductCard(
                                    id:  cubit.allProducts[index].productsId!,
                                    inCart: cubit.allProducts[index].inCart??false,
                                    inFavorite: cubit.allProducts[index].inFavourite??false,
                                    isOffer: cubit.allProducts[index].isOffer!,
                                    offerPrice: cubit.allProducts[index].offerPrice,
                                    description: cubit
                                        .allProducts[index].businessCategory!
                                        .bcNameEn!,
                                    type: cubit.allProducts[index].type!,
                                    rate: double.parse(
                                        cubit.allProducts[index].rating.toString()),
                                    review: cubit.allProducts[index].reviewCount,
                                    price: cubit.allProducts[index].price!,
                                    title: cubit.allProducts[index].productsName!,
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
