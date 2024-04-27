import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/details_product_screen/widget/card_reviews.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        if (hideAddedToCart) {
          Navigator.pop(context);
        } else {
          Helper.pop(context);
        }
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
                showMessageResponse(
                    message: locale.addRateSuccess,
                    context: context,
                    success: true);
                comment.clear();
                cubit.changeRate(value: 0);
              }
            },
            builder: (context, state) {
              var cubit = context.read<HomeCubit>();
              return Scaffold(
                bottomSheet: cubit.oneProductModel != null &&
                        state is! LoadingGetProductDetailsState
                    ? !hideAddedToCart
                        ? Container(
                            color: color.hoverColor,
                            padding: EdgeInsets.all(15.h),
                            child: BuildDefaultButton(
                                text: cubit.oneProductModel!.product!.inCart!
                                    ? locale.addedToCart
                                    : locale.addToCart,
                                borderRadius: 12.r,
                                height: 32.h,
                                onPressed: () {
                                  if (!cubit
                                      .oneProductModel!.product!.inCart!) {
                                    if (CacheHelper.getData(
                                            key: AppConstant.token) ==
                                        null) {
                                      Helper.push(context, GetStartScreen());
                                    } else {
                                      CartCubit.get(context).addToCart(
                                          token: CacheHelper.getData(
                                              key: AppConstant.token),
                                          id: cubit.oneProductModel!.product!
                                              .productsId!,
                                          quantity: cubit.quantity);
                                    }
                                  }
                                },
                                backgorundColor:
                                    cubit.oneProductModel!.product!.inCart!
                                        ? Colors.grey
                                        : color.backgroundColor,
                                colorText: color.primaryColor),
                          )
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
                        if (hideAddedToCart) {
                          Navigator.pop(context);
                        } else {
                          Helper.pop(context);
                        }
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
                                Card(
                                  elevation: 4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.r),
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/product.png',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 210.h,
                                        ),
                                        Positioned(
                                            top: 10.h,
                                            left: 8.w,
                                            child: BuildContainerType(
                                              type: cubit.oneProductModel!
                                                  .product!.type!,
                                            )),
                                        Positioned(
                                          bottom: 10.h,
                                          right: 8.w,
                                          child: Image.asset(
                                            'assets/images/hundia.png',
                                            width: 50.w,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 90.w,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          Container(
                                            decoration: index == 0
                                                ? BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    border: Border.all(
                                                        color: color
                                                            .backgroundColor,
                                                        width: 2.w))
                                                : null,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: Image.asset(
                                                'assets/images/product.png',
                                                fit: BoxFit.cover,
                                                width: 90.w,
                                                height: 90.w,
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                      itemCount: 5),
                                ),
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
                                    if (!cubit
                                        .oneProductModel!.product!.inCart!)
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
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: color.backgroundColor),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r))),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.h),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            cubit
                                                .openAndCloseDetailsContainer();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                locale.productDetails,
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20.sp),
                                              ),
                                              Icon(
                                                !cubit.productDetailsContainer
                                                    ? Icons
                                                        .keyboard_arrow_up_outlined
                                                    : Icons
                                                        .keyboard_arrow_down_rounded,
                                                color: color.backgroundColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        if (cubit.productDetailsContainer)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Divider(),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                locale.specifications,
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        locale.category,
                                                        style: font.bodyMedium,
                                                      ),
                                                      Text(
                                                        cubit
                                                            .oneProductModel!
                                                            .product!
                                                            .businessCategory!
                                                            .bcNameEn!,
                                                        style: font.bodyMedium!
                                                            .copyWith(
                                                                color: color
                                                                    .backgroundColor),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      if (cubit
                                                              .oneProductModel!
                                                              .product!
                                                              .madeIn !=
                                                          null)
                                                        Text(
                                                          locale.madeIn,
                                                          style:
                                                              font.bodyMedium,
                                                        ),
                                                      if (cubit
                                                              .oneProductModel!
                                                              .product!
                                                              .madeIn !=
                                                          null)
                                                        Text(
                                                          cubit.oneProductModel!
                                                              .product!.madeIn!,
                                                          style: font
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: color
                                                                      .backgroundColor),
                                                        ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 50.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        locale.brand,
                                                        style: font.bodyMedium,
                                                      ),
                                                      FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: SizedBox(
                                                          width: 90.w,
                                                          child: Text(
                                                              cubit
                                                                  .oneProductModel!
                                                                  .product!
                                                                  .brandName!,
                                                              style: font
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color: color
                                                                          .backgroundColor)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        locale.type,
                                                        style: font.bodyMedium,
                                                      ),
                                                      Text(
                                                          cubit.oneProductModel!
                                                              .product!.type!,
                                                          style: font
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: color
                                                                      .backgroundColor)),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .manufacturerPartNumber !=
                                                      null)
                                                    Text(
                                                      locale
                                                          .manufacturerPartNumber,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .manufacturerPartNumber !=
                                                      null)
                                                    Text(
                                                      cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .manufacturerPartNumber!
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .manufacturerPartNumber !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .frontOrRear !=
                                                      null)
                                                    Text(
                                                      locale.placementOnVehicle,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .frontOrRear !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.frontOrRear!
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .frontOrRear !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .rimDiameter !=
                                                      null)
                                                    Text(
                                                      '${locale.assembledProductDimensions}\n(L x W x H)',
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .rimDiameter !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.rimDiameter!
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .rimDiameter !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.warranty !=
                                                      null)
                                                    Text(
                                                      locale.warranty,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.warranty !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.warranty!,
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.warranty !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  Text(
                                                    locale.description,
                                                    style: font.bodyMedium,
                                                  ),
                                                  Text(
                                                    cubit.oneProductModel!
                                                        .product!.description!,
                                                    style: font.bodyMedium!
                                                        .copyWith(
                                                            color: color
                                                                .backgroundColor),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .maximumTyreLoad !=
                                                      null)
                                                    Text(
                                                      locale.maximumTyreLoad,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .maximumTyreLoad !=
                                                      null)
                                                    Text(
                                                      cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .maximumTyreLoad
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .maximumTyreLoad !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreEngraving !=
                                                      null)
                                                    Text(
                                                      locale.tyreEngraving,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreEngraving !=
                                                      null)
                                                    Text(
                                                      cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreEngraving
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreEngraving !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreHeight !=
                                                      null)
                                                    Text(
                                                      locale.tyreHeight,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreHeight !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.tyreHeight
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .tyreHeight !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.tyreWidth !=
                                                      null)
                                                    Text(
                                                      locale.tyreWidth,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.tyreWidth !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.tyreWidth
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.tyreWidth !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.volt !=
                                                      null)
                                                    Text(
                                                      locale.volt,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.volt !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.volt
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.volt !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.ampere !=
                                                      null)
                                                    Text(
                                                      locale.ampere,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.ampere !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.ampere
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.ampere !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.liter !=
                                                      null)
                                                    Text(
                                                      locale.liters,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.liter !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.liter
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.liter !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.color !=
                                                      null)
                                                    Text(
                                                      locale.color,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.color !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.color
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.color !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .numberSparkPulgs !=
                                                      null)
                                                    Text(
                                                      locale.numberOfSparkPulgs,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .numberSparkPulgs !=
                                                      null)
                                                    Text(
                                                      cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .numberSparkPulgs
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .numberSparkPulgs !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.oilType !=
                                                      null)
                                                    Text(
                                                      locale.oilType,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.oilType !=
                                                      null)
                                                    Text(
                                                      cubit.oneProductModel!
                                                          .product!.oilType
                                                          .toString(),
                                                      style: font.bodyMedium!
                                                          .copyWith(
                                                              color: color
                                                                  .backgroundColor),
                                                    ),
                                                  if (cubit.oneProductModel!
                                                          .product!.oilType !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .availableYears !=
                                                      null)
                                                    Text(
                                                      locale.carModels,
                                                      style: font.bodyMedium,
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .availableYears !=
                                                      null)
                                                    ListView.builder(
                                                      itemCount: cubit
                                                          .modelsCar.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Text(
                                                        cubit.modelsCar[index],
                                                        style: font.bodyMedium!
                                                            .copyWith(
                                                                color: color
                                                                    .backgroundColor),
                                                      ),
                                                    ),
                                                  if (cubit
                                                          .oneProductModel!
                                                          .product!
                                                          .availableYears !=
                                                      null)
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                RatingSummary(
                                  counter: cubit.oneProductModel!.product!
                                              .rateCount ==
                                          0
                                      ? 1
                                      : cubit
                                          .oneProductModel!.product!.rateCount!,
                                  average: cubit.oneProductModel!.product!
                                              .averageRate ==
                                          null
                                      ? 0
                                      : cubit.oneProductModel!.product!
                                          .averageRate!
                                          .toDouble(),
                                  averageStyle: font.bodyMedium!
                                      .copyWith(fontSize: 19.sp),
                                  showAverage: true,
                                  backgroundColor: Colors.grey.shade400,
                                  counterFiveStars: cubit
                                              .oneProductModel!
                                              .product!
                                              .ratePercentage!
                                              .fiveStar ==
                                          null
                                      ? 0
                                      : cubit.oneProductModel!.product!
                                          .ratePercentage!.fiveStar!
                                          .toInt(),
                                  counterFourStars: cubit
                                              .oneProductModel!
                                              .product!
                                              .ratePercentage!
                                              .fourStar ==
                                          null
                                      ? 0
                                      : cubit.oneProductModel!.product!
                                          .ratePercentage!.fourStar!
                                          .toInt(),
                                  counterThreeStars: cubit
                                              .oneProductModel!
                                              .product!
                                              .ratePercentage!
                                              .threeStar ==
                                          null
                                      ? 0
                                      : cubit.oneProductModel!.product!
                                          .ratePercentage!.threeStar!
                                          .toInt(),
                                  counterTwoStars: cubit
                                              .oneProductModel!
                                              .product!
                                              .ratePercentage!
                                              .twoStar ==
                                          null
                                      ? 0
                                      : cubit.oneProductModel!.product!
                                          .ratePercentage!.twoStar!
                                          .toInt(),
                                  counterOneStars: cubit
                                              .oneProductModel!
                                              .product!
                                              .ratePercentage!
                                              .oneStar ==
                                          null
                                      ? 0
                                      : cubit.oneProductModel!.product!
                                          .ratePercentage!.oneStar!
                                          .toInt(),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
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
                                        onPressed: () {},
                                        child: Text(
                                          locale.seeAll,
                                          style: font.bodyMedium!.copyWith(
                                              fontSize: 13.sp,
                                              color: color.primaryColor),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListView.separated(
                                  itemCount: cubit.oneProductModel!.product!
                                      .productRating!.length,
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
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  locale.addRate,
                                  style: font.bodyMedium!
                                      .copyWith(fontSize: 15.sp),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 190.w,
                                      height: 54.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          color: color.primaryColor
                                              .withOpacity(0.1)),
                                      child: RatingBarIndicator(
                                        rating: cubit.rate.toDouble(),
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            cubit.changeRate(value: index + 1);
                                          },
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        unratedColor: color.primaryColor
                                            .withOpacity(0.22),
                                        itemCount: 5,
                                        itemSize: 30.r,
                                        direction: Axis.horizontal,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                BuildTextFormField(
                                    title: locale.comment,
                                    hint: locale.writeComment,
                                    cubit: AuthenticationCubit.get(context),
                                    controller: comment,
                                    maxLines: 4,
                                    contentPadding: true,
                                    withBorder: true,
                                    validator: (p0) {
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    maxLength: 1000),
                                SizedBox(
                                  height: 18.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    state is LoadingAddRateState
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: color.primaryColor,
                                          ))
                                        : BuildDefaultButton(
                                            text: locale.addRate,
                                            width: 80.w,
                                            height: 22.h,
                                            borderRadius: 8.r,
                                            onPressed: () {
                                              if (cubit.rate != 0) {
                                                cubit.addRate(
                                                    id: cubit.oneProductModel!
                                                        .product!.productsId!,
                                                    rate: cubit.rate,
                                                    comment:
                                                        comment.text.isEmpty
                                                            ? null
                                                            : comment.text);
                                              } else {
                                                showMessageResponse(
                                                    message: locale
                                                        .addAtLeastOneStar,
                                                    context: context,
                                                    success: false);
                                              }
                                            },
                                            backgorundColor:
                                                color.backgroundColor,
                                            colorText: ColorConstant.brown),
                                  ],
                                ),
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
