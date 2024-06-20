import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/all_reviews_screen/all_reviews_screen.dart';
import 'package:mham/views/details_product_screen/widget/add_rate.dart';
import 'package:mham/views/details_product_screen/widget/all_images_with_select.dart';
import 'package:mham/views/details_product_screen/widget/all_product_details.dart';
import 'package:mham/views/details_product_screen/widget/bottom_sheet.dart';
import 'package:mham/views/details_product_screen/widget/card_reviews.dart';
import 'package:mham/views/details_product_screen/widget/rating_summary.dart';

var comment = TextEditingController();

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    this.hideAddedToCart = false,
  });

  final bool hideAddedToCart;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    var cubit = context.read<HomeCubit>();
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        cubit.resetQuantity();
        cubit.changeRate(value: 0);
        Helper.pop(context);
        cubit.productDetailsContainer = false;
        return true;
      },
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is SuccessAddToCart) {
            cubit.productModel = null;
            cubit.resetQuantity();
            Helper.pop(context);
          }
        },
        builder: (context, state) {
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is SuccessAddRateState) {
                cubit.getProductRating(
                    id: cubit.oneProductModel!.product!.productsId!);
                showMessageResponse(
                    message: locale.addRateSuccess,
                    context: context,
                    success: true);
                comment.clear();
                cubit.changeRate(value: 0);
              }
              if (state is NoInternetHomeState) {
                showMessageResponse(
                    message: locale.noInternetConnection,
                    context: context,
                    success: false);
              }
            },
            builder: (context, state) {
              var cubit = context.read<HomeCubit>();
              return Scaffold(
                bottomSheet: cubit.oneProductModel != null &&
                        state is! LoadingGetProductDetailsState&&
                  CacheHelper.getData(key: AppConstant.token,token: true) != null
                    ? !hideAddedToCart &&cubit.oneProductModel!.
                product!.qntInStock!=0
                    ? BuildBottomSheet()
                        : null
                    : null,
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset(
                    ImageConstant.splash,
                    width: 80.w,
                    height: 40.h,
                  ),
                  leading: InkWell(
                      onTap: () {
                        cubit.resetQuantity();
                        cubit.changeRate(value: 0);
                        Helper.pop(context);
                        cubit.productDetailsContainer = false;
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: color.primaryColor,
                      )),
                ),
                body: cubit.oneProductModel != null &&
                        state is! LoadingGetProductDetailsState
                    ? SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BuildImageWithSelectImages(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: SizedBox(
                                        width: 245.w,
                                        child: Text(
                                          cubit.oneProductModel!.product!
                                              .productsName!,
                                          style: font.bodyLarge!
                                              .copyWith(fontSize: 25.sp),
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                        '${cubit.oneProductModel!.product!.averageRate == null ? 0 : cubit.oneProductModel!.product!.averageRate!.toInt()}/5'),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: ColorConstant.backgroundAuth,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                if (cubit.oneProductModel!.product!.isOffer! ==
                                    true)
                                  Text(
                                    cubit.oneProductModel!.product!.price!
                                            .toString() +
                                        ' ${locale.kd}',
                                    style: font.bodyMedium!.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: color.backgroundColor
                                            .withOpacity(0.5),
                                        fontSize: 15.sp,
                                        color: color.backgroundColor
                                            .withOpacity(0.5)),
                                  ),
                                if (cubit.oneProductModel!.product!.isOffer! ==
                                    true)
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${cubit.oneProductModel!.product!.isOffer! == true ? cubit.oneProductModel!.product!.offerPrice!.toString() : cubit.oneProductModel!.product!.price!.toString()} ${locale.kd}',
                                      style: font.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: color.backgroundColor),
                                    ),
                                    if (cubit.oneProductModel!.product!
                                                .inCart ==
                                            false &&
                                        cubit.oneProductModel!.product!
                                                .inCart !=
                                            null)
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                cubit.changeQuantity(
                                                    increase: false);
                                              },
                                              child:
                                                  Icon(FontAwesomeIcons.minus)),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 30.w,
                                            height: 30.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: color.primaryColor),
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            child: Text(
                                              cubit.quantity.toString(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                cubit.changeQuantity(
                                                    increase: true);
                                              },
                                              child:
                                                  Icon(FontAwesomeIcons.add)),
                                        ],
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                BuildAllProductDetails(),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  locale.productRatings,
                                  style: font.bodyMedium,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                BuildRatingSummary(),
                                SizedBox(
                                  height: 25.h,
                                ),
                                if (cubit.oneProductModel!.product!.rateCount !=
                                    0)
                                  Row(
                                    children: [
                                      Text(
                                        locale.reviews,
                                        style: font.bodyMedium,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        '(${cubit.oneProductModel!.product!.rateCount} ${locale.reviews})',
                                        style: font.bodyMedium!.copyWith(
                                            fontSize: 13.sp,
                                            color: color.primaryColor
                                                .withOpacity(0.5)),
                                      ),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            Helper.push(
                                                context: context,
                                                widget: AllReviewsScreen(
                                                    productId: cubit
                                                        .oneProductModel!
                                                        .product!
                                                        .productsId!),
                                                withAnimate: true);
                                          },
                                          child: Text(
                                            locale.seeAll,
                                            style: font.bodyMedium!.copyWith(
                                                fontSize: 13.sp,
                                                color: color.primaryColor),
                                          ))
                                    ],
                                  ),
                                if (cubit.oneProductModel!.product!.rateCount !=
                                    0)
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ListView.separated(
                                  itemCount: cubit.productRating.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      BuildCardReviews(
                                    index: index,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 15.h,
                                  ),
                                ),
                                if (CacheHelper.getData(
                                        key: AppConstant.token,token: true) !=
                                    null)
                                  BuildAddRate(),
                                SizedBox(
                                  height: 90.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: BuildImageLoader(assetName: ImageConstant.logo)),
              );
            },
          );
        },
      ),
    );
  }
}
