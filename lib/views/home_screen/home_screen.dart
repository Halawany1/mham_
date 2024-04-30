import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/components/row_product_and_see_all_component.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/cart_screen/cart_screen.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/home_screen/widget/all_categories.dart';
import 'package:mham/views/home_screen/widget/car_filter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/home_screen/widget/products_not_found.dart';
import 'package:mham/views/home_screen/widget/slider_car_type.dart';
import 'package:mham/views/home_screen/widget/top_app_bar_and_slider.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:mham/views/search_screen/search_screen.dart';
import 'package:mham/views/see_all_screen/see_all_screen.dart';

final CarouselController carouselController = CarouselController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (HomeCubit.get(context).productModel == null) {
      HomeCubit.get(context).getAllProduct();
    }

    final locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is SuccessAddToCart) {
          showMessageResponse(
              message: locale.addedSuccess, context: context, success: true);
          HomeCubit.get(context).getAllProduct();
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
                    title: Text(locale.requestScrap,style: font.bodyLarge!.copyWith(
                      fontSize: 20.sp
                    ),),
                    content: Container(
                      height: 220.h,
                      decoration: BoxDecoration(
                        color: color.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.all(10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.requestScrapSuccess,
                            style: font.bodyMedium!.copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                              locale.requiredPartWillBeFoundSoon,
                              style:
                                  font.bodyMedium!.copyWith(fontSize: 15.sp)),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(locale.keepOrderAndContactNumber,
                              style:
                                  font.bodyMedium!.copyWith(fontSize: 15.sp)),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            children: [
                              Text(
                                locale.orderNumber,
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
                                locale.contactNumber,
                                style:
                                    font.bodyMedium!.copyWith(fontSize: 12.sp),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              SizedBox(
                                width: 120.w,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    '+965 1234 5678',
                                    style: font.bodyMedium!.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
            if(state is ErrorAddScrapState){
              showMessageResponse(message: state.error,
                  context: context, success: false);
            }
          },
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                actions: [
                  Padding(
                    padding:  EdgeInsets.only(right: 15.w,top: 10.h),
                    child: InkWell(
                      onTap: () {
                        if (CacheHelper.getData(key: AppConstant.token) == null) {
                          Helper.push(context, GetStartScreen());
                        } else {
                          Helper.push(context, NotificationScreen());
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.bell,
                        color: color.primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 20.w,top: 10.h),
                    child: InkWell(
                      onTap: () {
                        if (CacheHelper.getData(key: AppConstant.token) != null) {
                          CartCubit.get(context).getCart(
                              token: CacheHelper.getData(key: AppConstant.token));
                          Helper.push(context, CartScreen());
                        } else {
                          Helper.push(context, GetStartScreen());
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.shoppingCart,
                        color: ColorConstant.backgroundAuth,
                      ),
                    ),
                  ),
                ],
                title:  Padding(
                  padding:  EdgeInsets.only(top: 10.h),
                  child: BuildSearchFormField(
                    onTap: () {
                      Helper.push(context, SearchScreen());
                    },
                    readOnly: true,
                  ),
                ),
              ),
              body: cubit.productModel == null
                  ? Center(
                      child: BuildImageLoader(assetName: ImageConstant.logo))
                  : RefreshIndicator(
                backgroundColor: color.backgroundColor,
                color: color.primaryColor,
                onRefresh: () async{
                  HomeCubit.get(context).getAllProduct();
                },
                    child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.all(20.h),
                          child: Center(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  BuildAds(),
                                  Text(
                                    locale.whatAreYouLookingFor,
                                    style: font.bodyMedium,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                 BuildAllCategories(),
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
                                                      mainAxisExtent: 258.h),
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                onTap: () {
                                                  cubit.oneProductModel=null;
                                                  cubit.getProductDetails(id:cubit
                                                      .homeProducts[index]
                                                      .productsId!);
                                                  cubit.increaseReview(cubit
                                                      .homeProducts[index]
                                                      .productsId!);
                                                  Helper.push(
                                                      context,
                                                      DetailsScreen(
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
                                                      .homeProducts[index].averageRate
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

                                  BuildSliderCarType(),
                                  SizedBox(
                                    height: 20.h,
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
      },
    );
  }
}
