import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/components/row_product_and_see_all_component.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/cart_screen/cart_screen.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/home_screen/widget/car_filter.dart';
import 'package:mham/views/home_screen/widget/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/home_screen/widget/products_not_found.dart';
import 'package:mham/views/search_screen/search_screen.dart';
import 'package:mham/views/see_all_screen/see_all_screen.dart';

final CarouselController _carouselController = CarouselController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (HomeCubit.get(context).productModel == null) {
      HomeCubit.get(context).getAllProduct(lang: 'en');
    }

    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is SuccessAddToCart) {
          showMessageResponse(
              message: locale.addedSuccess, context: context, success: true);
          HomeCubit.get(context).getAllProduct(lang: 'en');
        }
      },
      builder: (context, cartState) {
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is SuccessAddScrapState) {
              showDialog(
                context: context,
                builder: (context) {
                  var color = Theme.of(context);
                  return AlertDialog(
                    backgroundColor: color.cardColor,
                    title: Text('Request Scrap'),
                    content: Container(
                      height: 220.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFE4E4E4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your request has been sent successfully.',
                            style: font.bodyMedium!.copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                              'The required part will be found as soon as possible.',
                              style:
                                  font.bodyMedium!.copyWith(fontSize: 15.sp)),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text('Keep the order number and contact number.',
                              style:
                                  font.bodyMedium!.copyWith(fontSize: 15.sp)),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Order number:',
                                style:
                                    font.bodyMedium!.copyWith(fontSize: 14.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                '#' + state.data.createScrap!.id.toString(),
                                style: font.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold,fontSize: 15.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'contact number:',
                                style:
                                    font.bodyMedium!.copyWith(fontSize: 12.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                '+965 1234 5678',
                                style: font.bodyMedium!.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return Scaffold(
              body: cubit.productModel == null
                  ? Center(
                      child: BuildImageLoader(assetName: ImageConstant.logo))
                  : SafeArea(
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
                                        Helper.push(context, SearchScreen());
                                      },
                                      readOnly: true,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(CacheHelper.getData(key: AppConstant.token) == null){
                                          Helper.push(context, GetStartScreen());
                                        }else{

                                        }

                                      },
                                      child: Icon(
                                        FontAwesomeIcons.bell,
                                        color: color.primaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(CacheHelper.getData(key: AppConstant.token) != null){
                                          CartCubit.get(context).getCart(
                                              token: CacheHelper.getData(
                                                  key: AppConstant.token));
                                          Helper.push(context, CartScreen());
                                        }else{
                                          Helper.push(context, GetStartScreen());
                                        }

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
                                CarouselSlider(
                                    items: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.network(
                                          "https://img.freepik.com/free-psd/car-rental-horizontal-banner-template-with-toy-car_23-2149442089.jpg?t=st=1713425769~exp=1713429369~hmac=d7f8bf92e9672fa739a6752958ac751c1a0203ad1efd3ff7f54c567869cbad15&w=1380",
                                          width: double.infinity,
                                          height: 90.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.network(
                                          "https://img.freepik.com/free-psd/banner-mechanic-shop-template_23-2148747138.jpg?t=st=1713425689~exp=1713429289~hmac=fedb5c4723e821bf2e3fda573c094e0d4d5da9ab88e9d3c55403cbf94532e821&w=1380",
                                          width: double.infinity,
                                          height: 90.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        child: Image.network(
                                          "https://img.freepik.com/free-psd/motorbike-extreme-sport-facebook-template_23-2149859119.jpg?t=st=1713425861~exp=1713429461~hmac=1a80b95a7fc4a6e7292cd15c0323f3dc6859657e11eec5a20d5d69b6dfe5ccc6&w=1380",
                                          width: double.infinity,
                                          height: 90.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                    options: CarouselOptions(
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.3,
                                      scrollDirection: Axis.horizontal,
                                    )),
                                SizedBox(
                                  height: 22.h,
                                ),
                                Text(
                                  locale.whatAreYouLookingFor,
                                  style: font.bodyMedium,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                          lang: 'en',
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
                                SizedBox(
                                  height: 30.h,
                                ),
                                BuildCarFilter(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                BuildRowTextAndSeeAll(
                                  text: locale.products,
                                  empty: false,
                                  onTap: () {
                                    cubit.productModel = null;
                                    Helper.push(
                                        context,
                                        SeeAllScreen(
                                          title: locale.products,
                                        ));
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                state is LoadingGetAllProduct ||
                                    cartState is CartLoadingState
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: color.primaryColor,
                                      ))
                                    : cubit.homeProducts.isEmpty
                                        ? BuildNotFoundProduct()
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                cubit.homeProducts.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisSpacing: 10.h,
                                                    crossAxisSpacing: 4.w,
                                                    mainAxisExtent: 230.h),
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                              onTap: () {
                                                List<String> carModels = [];
                                                if (cubit.homeProducts[index]
                                                        .availableYears !=
                                                    null) {
                                                  cubit.homeProducts[index]
                                                      .availableYears!
                                                      .forEach((element) {
                                                    carModels.add(element
                                                            .carModel!
                                                            .car!
                                                            .carName! +
                                                        ' ' +
                                                        element.carModel!
                                                            .modelName! +
                                                        ' ' +
                                                        element.availableYear
                                                            .toString());
                                                  });
                                                }

                                                cubit.increaseReview(cubit
                                                    .homeProducts[index]
                                                    .productsId!);
                                                Helper.push(
                                                    context,
                                                    DetailsScreen(
                                                      productId: cubit
                                                          .homeProducts[index]
                                                          .productsId!,
                                                      inCart: cubit
                                                              .homeProducts[
                                                                  index]
                                                              .inCart ??
                                                          false,
                                                      brand: cubit
                                                          .homeProducts[index]
                                                          .brandName!,
                                                      description: cubit
                                                          .homeProducts[index]
                                                          .description!,
                                                      isOffer: cubit
                                                          .homeProducts[index]
                                                          .isOffer!,
                                                      price: double.parse(cubit
                                                          .homeProducts[index]
                                                          .price!
                                                          .toString()),
                                                      productName: cubit
                                                          .homeProducts[index]
                                                          .productsName!,
                                                      rating: double.parse(cubit
                                                          .homeProducts[index]
                                                          .rating!
                                                          .toString()),
                                                      type: cubit
                                                          .homeProducts[index]
                                                          .type!,
                                                      category: cubit
                                                          .homeProducts[index]
                                                          .businessCategory!
                                                          .bcNameEn!,
                                                      warranty: cubit
                                                          .homeProducts[index]
                                                          .warranty,
                                                      placementOfVehile: cubit
                                                          .homeProducts[index]
                                                          .frontOrRear,
                                                      volt: cubit
                                                          .homeProducts[index]
                                                          .volt,
                                                      tyreWidth: cubit
                                                          .homeProducts[index]
                                                          .tyreWidth,
                                                      tyreSpreedRate: cubit
                                                          .homeProducts[index]
                                                          .tyreSpeedRate,
                                                      tyreHeight: cubit
                                                          .homeProducts[index]
                                                          .tyreHeight,
                                                      tyre_engraving: cubit
                                                          .homeProducts[index]
                                                          .tyreEngraving,
                                                      maximumTyreLoad: cubit
                                                          .homeProducts[index]
                                                          .maximumTyreLoad,
                                                      number_spark_pulgs: cubit
                                                          .homeProducts[index]
                                                          .numberSparkPulgs,
                                                      oilType: cubit
                                                          .homeProducts[index]
                                                          .oilType,
                                                      madeIn: cubit
                                                          .homeProducts[index]
                                                          .madeIn,
                                                      liter: cubit
                                                          .homeProducts[index]
                                                          .liter,
                                                      dimension: cubit
                                                          .homeProducts[index]
                                                          .rimDiameter,
                                                      ampere: cubit
                                                          .homeProducts[index]
                                                          .ampere,
                                                      manufacturerPartNumber: cubit
                                                          .homeProducts[index]
                                                          .manufacturerPartNumber,
                                                      productColor: cubit
                                                          .homeProducts[index]
                                                          .color,
                                                      batteryReplacementAvailable:
                                                          cubit
                                                              .homeProducts[
                                                                  index]
                                                              .batteryReplacementAvailable,
                                                      offerPrice: cubit
                                                          .homeProducts[index]
                                                          .offerPrice,
                                                      carModels: carModels,
                                                    ));
                                              },
                                              child: BuildProductCard(
                                                id: cubit.homeProducts[index]
                                                    .productsId!,
                                                inCart: cubit
                                                        .homeProducts[index]
                                                        .inCart ??
                                                    false,
                                                inFavorite: cubit
                                                        .homeProducts[index]
                                                        .inFavourite ??
                                                    false,
                                                isOffer: cubit
                                                    .homeProducts[index]
                                                    .isOffer!,
                                                offerPrice: cubit
                                                    .homeProducts[index]
                                                    .offerPrice,
                                                description: cubit
                                                    .homeProducts[index]
                                                    .businessCategory!
                                                    .bcNameEn!,
                                                type: cubit
                                                    .homeProducts[index].type!,
                                                rate: double.parse(cubit
                                                    .homeProducts[index].rating
                                                    .toString()),
                                                review: cubit
                                                    .homeProducts[index]
                                                    .reviewCount,
                                                price: cubit
                                                    .homeProducts[index].price!,
                                                title: cubit.homeProducts[index]
                                                    .productsName!,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          cubit.changeTypeCarIndex(
                                              value: cubit.index > 0
                                                  ? cubit.index - 1
                                                  : 4);
                                          _carouselController
                                              .jumpToPage(cubit.index);
                                        },
                                        child: Icon(Icons.arrow_back_ios)),
                                    Container(
                                      width: 250.w,
                                      height: 57.h,
                                      decoration: BoxDecoration(
                                        color: color.cardColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: CarouselSlider(
                                          carouselController:
                                              _carouselController,
                                          items: List.generate(5, (index) {
                                            double width = cubit.index == index
                                                ? 57.w
                                                : 30.w;
                                            double height = cubit.index == index
                                                ? 57.w
                                                : 30.w;

                                            return Image.asset(
                                              ImageConstant.cars(index),
                                              width: width,
                                              height: height,
                                            );
                                          }),
                                          options: CarouselOptions(
                                            height: 57.h,
                                            viewportFraction: 0.2,
                                            initialPage: 0,
                                            onPageChanged: (index, reason) {
                                              cubit.changeTypeCarIndex(
                                                  value: index);
                                            },
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            enlargeFactor: 0.2,
                                            scrollDirection: Axis.horizontal,
                                          )),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          cubit.changeTypeCarIndex(
                                              value: cubit.index == 4
                                                  ? 0
                                                  : cubit.index + 1);
                                          _carouselController
                                              .jumpToPage(cubit.index);
                                        },
                                        child: Icon(Icons.arrow_forward_ios))
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
      },
    );
  }
}
