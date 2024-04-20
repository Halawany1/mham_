import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/cart_screen/widget/card_cart_product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        return Scaffold(
            bottomSheet: Container(
              padding: EdgeInsets.all(12.h),
              width: double.infinity,
              height: 70.h,
              decoration: BoxDecoration(
                color: color.primaryColor,
              ),
              child: BuildDefaultButton(
                borderRadius: 12.r,
                onPressed: () {},
                text: locale.checkOut,
                backgorundColor: color.backgroundColor,
                colorText: color.primaryColor,
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                ImageConstant.splash,
                width: 80.w,
                height: 40.h,
              ),
              leading: InkWell(
                  onTap: () {
                    HomeCubit.get(context).getAllProduct(lang: 'en');
                    Helper.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: color.primaryColor,
                  )),
            ),
            body: state is CartLoadingState || cubit.cartModel == null
                ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
                : Padding(
                    padding: EdgeInsets.all(20.h),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(locale.cart),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                '(${cubit.cartModel!.cart!.cartProducts!.length} ${locale.items})',
                                style: font.bodyMedium!.copyWith(
                                    fontSize: 12.sp, color: color.hintColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      List<String> carModels = [];
                                      if (cubit
                                              .cartModel!
                                              .cart!
                                              .cartProducts![index]
                                              .product!
                                              .availableYears !=
                                          null) {
                                        cubit
                                            .cartModel!
                                            .cart!
                                            .cartProducts![index]
                                            .product!
                                            .availableYears!
                                            .forEach((element) {
                                          carModels.add(element
                                                  .carModel!.car!.carName! +
                                              ' ' +
                                              element.carModel!.modelName! +
                                              ' ' +
                                              element.availableYear.toString());
                                        });
                                      }

                                      HomeCubit.get(context).increaseReview(
                                          cubit
                                              .cartModel!
                                              .cart!
                                              .cartProducts![index]
                                              .product!
                                              .productsId!);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              hideAddedToCart: true,
                                              productId: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .productsId!,
                                              inCart: true,
                                              brand: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .brandName!,
                                              description: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .description!,
                                              isOffer: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .isOffer!,
                                              price: double.parse(cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .price!
                                                  .toString()),
                                              productName: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .productsName!,
                                              rating: double.parse(cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .rating!
                                                  .toString()),
                                              type: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .type!,
                                              category: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .businessCategory!
                                                  .bcNameEn!,
                                              warranty: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .warranty,
                                              placementOfVehile: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .frontOrRear,
                                              volt: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .volt,
                                              tyreWidth: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .tyreWidth,
                                              tyreSpreedRate: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .tyreSpeedRate,
                                              tyreHeight: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .tyreHeight,
                                              tyre_engraving: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .tyreEngraving,
                                              maximumTyreLoad: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .maximumTyreLoad,
                                              number_spark_pulgs: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .numberSparkPulgs,
                                              oilType: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .oilType,
                                              madeIn: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .madeIn,
                                              liter: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .liter,
                                              dimension: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .rimDiameter,
                                              ampere: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .ampere,
                                              manufacturerPartNumber: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .manufacturerPartNumber,
                                              productColor: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .color,
                                              batteryReplacementAvailable: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .batteryReplacementAvailable,
                                              offerPrice: cubit
                                                  .cartModel!
                                                  .cart!
                                                  .cartProducts![index]
                                                  .product!
                                                  .offerPrice,
                                              carModels: carModels,
                                            ),
                                          ));
                                    },
                                    child: BuildCartCardProduct(
                                      index: index,
                                    ),
                                  ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 20.h,
                                  ),
                              itemCount:
                                  cubit.cartModel!.cart!.cartProducts!.length),
                          SizedBox(
                            height: 20.h,
                          ),
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 120.h,
                              decoration: BoxDecoration(
                                color: color.scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.h),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          locale.subTotal,
                                          style: font.bodyMedium!
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          '(${cubit.cartModel!.cart!.cartProducts!.length} items)',
                                          style: font.bodyMedium!.copyWith(
                                              fontSize: 10.sp,
                                              color: color.hintColor),
                                        ),
                                        Spacer(),
                                        Text(
                                          cubit.totalPrice.toStringAsFixed(2) +
                                              ' ${locale.kd}',
                                          style: font.bodyMedium!.copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          locale.shippingFee,
                                          style: font.bodyMedium!
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                        Spacer(),
                                        Text(
                                          '10' + ' ${locale.kd}',
                                          style: font.bodyMedium!.copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          locale.total,
                                          style: font.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                        Spacer(),
                                        Text(
                                          cubit.totalPrice.toStringAsFixed(2) +
                                              ' ${locale.kd}',
                                          style: font.bodyMedium!.copyWith(
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
