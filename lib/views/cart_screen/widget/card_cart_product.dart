import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';

class BuildCartCardProduct extends StatelessWidget {
  const BuildCartCardProduct({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);

    var cubit = CartCubit.get(context);
    return Card(
      elevation: 4,
      color: color.scaffoldBackgroundColor,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r), color: color.cardColor),
        width: double.infinity,
        height: 100.h,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  'assets/images/product.png',
                  height: 100.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5.h,
                left: 5.w,
                child: SizedBox(
                    width: 60.w,
                    height: 16.h,
                    child: BuildContainerType(
                        type: cubit.cartModel!.cart!.cartProducts![index]
                            .product!.type!)),
              ),
              Positioned(
                top: 4.h,
                left: 110.w,
                child: SizedBox(
                  width: 140.w,
                  child: Text(
                    cubit.cartModel!.cart!.cartProducts![index].product!
                        .productsName!,
                    overflow: TextOverflow.ellipsis,
                    style: font.bodyMedium!.copyWith(fontSize: 13.sp),
                  ),
                ),
              ),
              if (cubit.cartModel!.cart!.cartProducts![index].product!.isOffer!)
                Positioned(
                  top: 20.h,
                  left: 110.w,
                  child: Text(
                    cubit.cartModel!.cart!.cartProducts![index].product!.price!
                            .toString() +
                        ' ${locale.kd}',
                    style: font.bodyMedium!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: color.backgroundColor.withOpacity(0.5),
                        fontSize: 12.sp,
                        color: color.backgroundColor.withOpacity(0.5)),
                  ),
                ),
              Positioned(
                top: 35.h,
                left: 110.w,
                child: Text(
                  '${cubit.cartModel!.cart!.cartProducts![index].product!.isOffer! ? cubit.cartModel!.cart!.cartProducts![index].product!.offerPrice : cubit.cartModel!.cart!.cartProducts![index].product!.price} KD',
                  style: font.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: color.backgroundColor),
                ),
              ),
              Positioned(
                top: 54.h,
                left: 110.w,
                child: RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: double.parse(cubit.cartModel!.cart!
                      .cartProducts![index].product!.averageRate!
                      .toString()),
                  minRating: 0,
                  direction: Axis.horizontal,
                  unratedColor: color.highlightColor.withOpacity(0.7),
                  allowHalfRating: true,
                  itemCount: 5,
                  maxRating: double.parse(cubit.cartModel!.cart!
                      .cartProducts![index].product!.averageRate!
                      .toString()),
                  itemSize: 12.sp,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {},
                  tapOnlyMode: true,
                ),
              ),
              Positioned(
                top: 50.h,
                right: 12.w,
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          if (cubit.cartModel!.cart!.cartProducts![index]
                                  .quantity! >
                              1) {
                            cubit.updateCart(
                                token:
                                    CacheHelper.getData(key: AppConstant.token),
                                id: cubit.cartModel!.cart!.cartProducts![index]
                                    .product!.productsId!,
                                quantity: cubit.cartModel!.cart!
                                        .cartProducts![index].quantity! -
                                    1);
                          }
                        },
                        child: Icon(FontAwesomeIcons.minus)),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: color.primaryColor),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        cubit.cartModel!.cart!.cartProducts![index].quantity!
                            .toString(),
                        style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    InkWell(
                        onTap: () {
                          cubit.updateCart(
                              token:
                                  CacheHelper.getData(key: AppConstant.token),
                              id: cubit.cartModel!.cart!.cartProducts![index]
                                  .product!.productsId!,
                              quantity: cubit.cartModel!.cart!
                                      .cartProducts![index].quantity! +
                                  1);
                        },
                        child: Icon(FontAwesomeIcons.add)),
                  ],
                ),
              ),
              Positioned(
                top: 65.h,
                right: 5.w,
                child: Row(
                  children: [
                    BuildSmallButton(
                      text: locale.remove,
                      icon: FontAwesomeIcons.trash,
                      withIcon: true,
                      width: 70.w,
                      hieght: 16.h,
                      edit: false,
                      onPressed: () {
                        cubit.deleteCart(
                            token: CacheHelper.getData(key: AppConstant.token),
                            id: cubit
                                .cartModel!.cart!.cartProducts![index].id!);
                      },
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    BuildSmallButton(
                      text: locale.moreDetails,
                      width: 70.w,
                      hieght: 16.h,
                      withIcon: false,
                      onPressed: () {
                        HomeCubit.get(context).oneProductModel = null;
                        print(cubit.cartModel!.cart!.cartProducts![index]
                            .product!.productsId!);
                        HomeCubit.get(context).getProductDetails(
                            id: cubit.cartModel!.cart!.cartProducts![index]
                                .product!.productsId!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(),
                            ));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
