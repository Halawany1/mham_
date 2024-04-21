import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:rating_summary/rating_summary.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.description,
    required this.price,
    required this.type,
    required this.rating,
    required this.brand,
    required this.productId,
    required this.rateStarFive,
    required this.rateStarFour,
    required this.rateStarOne,
    required this.rateStarThree,
    required this.rateStarTwo,
    required this.inCart,
    this.tyreSpreedRate,
    this.maximumTyreLoad,
    this.batteryReplacementAvailable,
    this.tyre_engraving,
    required this.productName,
    this.oilType,
    this.ampere,
    this.liter,
    this.tyreWidth,
    this.tyreHeight,
    this.volt,
    this.productColor,
    this.frontOrRear,
    this.number_spark_pulgs,
    this.availableYears,
    required this.isOffer,
    this.offerPrice,
    this.tyreEngraving,
    this.rimDiameter,
    this.numberSparkPulgs,
    this.carModels,
    this.category = null,
    this.dimension = null,
    this.madeIn = null,
    this.manufacturerPartNumber = null,
    this.placementOfVehile = null,
    this.warranty = null,
    this.hideAddedToCart = false,
  });

  final dynamic price;
  final String? category;
  final String brand;
  final String type;
  final int productId;
  final String productName;
  final String? madeIn;
  final String? manufacturerPartNumber;
  final String? placementOfVehile;
  final int? dimension;
  final String? warranty;
  final String description;
  final int? tyreSpreedRate;
  final int? maximumTyreLoad;
  final int? tyre_engraving;
  final int? tyreHeight;
  final int? tyreWidth;
  final int? volt;
  final int? ampere;
  final int? liter;
  final String? productColor;
  final int? number_spark_pulgs;
  final int? frontOrRear;
  final String? oilType;
  final double rating;
  final bool isOffer;
  final List<String>? availableYears;
  final int? numberSparkPulgs;
  final int? tyreEngraving;
  final int? rimDiameter;
  final dynamic offerPrice;
  final bool? batteryReplacementAvailable;
  final bool inCart;
  final List<String>? carModels;
  final bool hideAddedToCart;
  final double rateStarOne;
  final double rateStarTwo;
  final double rateStarThree;
  final double rateStarFour;
  final double rateStarFive;


  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is SuccessAddToCart) {
          cubit.productModel = null;
          cubit.resetQuantity();
          Helper.pop(context);
        }
      },
      builder: (context, state) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return WillPopScope(
              onWillPop: () async {
                cubit.resetQuantity();
                if (hideAddedToCart) {
                  Navigator.pop(context);
                } else {
                  Helper.pop(context);
                }
                return true;
              },
              child: Scaffold(
                bottomSheet: !hideAddedToCart
                    ? Container(
                        color: color.hoverColor,
                        padding: EdgeInsets.all(15.h),
                        child: BuildDefaultButton(
                            text:
                                inCart ? locale.addedToCart : locale.addToCart,
                            borderRadius: 12.r,
                            height: 32.h,
                            onPressed: () {
                              if (!inCart) {
                                if (CacheHelper.getData(
                                        key: AppConstant.token) ==
                                    null) {
                                  Helper.push(context, GetStartScreen());
                                } else {
                                  CartCubit.get(context).addToCart(
                                      token: CacheHelper.getData(
                                          key: AppConstant.token),
                                      id: productId,
                                      quantity: cubit.quantity);
                                }
                              }
                            },
                            backgorundColor:
                                inCart ? Colors.grey : color.backgroundColor,
                            colorText: color.primaryColor),
                      )
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
                body: SingleChildScrollView(
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
                                        type: type,
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
                                itemBuilder: (context, index) => Container(
                                      decoration: index == 0
                                          ? BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              border: Border.all(
                                                  color: color.backgroundColor,
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
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 8.w,
                                    ),
                                itemCount: 5),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: SizedBox(
                                  width: 245.w,
                                  child: Text(
                                    productName,
                                    style: font.bodyLarge!
                                        .copyWith(fontSize: 25.sp),
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text('${rating.toInt()}/5'),
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
                          if (isOffer == true)
                            Text(
                              price.toString() + ' ${locale.kd}',
                              style: font.bodyMedium!.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor:
                                      color.backgroundColor.withOpacity(0.5),
                                  fontSize: 15.sp,
                                  color:
                                      color.backgroundColor.withOpacity(0.5)),
                            ),
                          if (isOffer == true)
                            SizedBox(
                              height: 5.h,
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${isOffer == true ? offerPrice.toString() : price.toString()} ${locale.kd}',
                                style: font.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: color.backgroundColor),
                              ),
                              if (!inCart)
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          cubit.changeQuantity(increase: false);
                                        },
                                        child: Icon(FontAwesomeIcons.minus)),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: color.primaryColor),
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
                                          cubit.changeQuantity(increase: true);
                                        },
                                        child: Icon(FontAwesomeIcons.add)),
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
                                border:
                                    Border.all(color: color.backgroundColor),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r))),
                            child: Padding(
                              padding: EdgeInsets.all(12.h),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cubit.openAndCloseDetailsContainer();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          locale.productDetails,
                                          style: font.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.sp),
                                        ),
                                        Icon(
                                          !cubit.productDetailsContainer
                                              ? Icons.keyboard_arrow_up_outlined
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
                                          style: font.bodyMedium!.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  locale.category,
                                                  style: font.bodyMedium,
                                                ),
                                                Text(
                                                  category!,
                                                  style: font.bodyMedium!
                                                      .copyWith(
                                                          color: color
                                                              .backgroundColor),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                if (madeIn != null)
                                                  Text(
                                                    locale.madeIn,
                                                    style: font.bodyMedium,
                                                  ),
                                                if (madeIn != null)
                                                  Text(
                                                    madeIn!,
                                                    style: font.bodyMedium!
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  locale.brand,
                                                  style: font.bodyMedium,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: SizedBox(
                                                    width: 90.w,
                                                    child: Text(brand,
                                                        style: font.bodyMedium!
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
                                                Text(type,
                                                    style: font.bodyMedium!
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
                                            if (manufacturerPartNumber != null)
                                              Text(
                                                locale.manufacturerPartNumber,
                                                style: font.bodyMedium,
                                              ),
                                            if (manufacturerPartNumber != null)
                                              Text(
                                                manufacturerPartNumber!
                                                    .toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (manufacturerPartNumber != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (frontOrRear != null)
                                              Text(
                                                locale.placementOnVehicle,
                                                style: font.bodyMedium,
                                              ),
                                            if (frontOrRear != null)
                                              Text(
                                                frontOrRear!.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (frontOrRear != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (rimDiameter != null)
                                              Text(
                                                '${locale.assembledProductDimensions}\n(L x W x H)',
                                                style: font.bodyMedium,
                                              ),
                                            if (rimDiameter != null)
                                              Text(
                                                rimDiameter!.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (rimDiameter != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (warranty != null)
                                              Text(
                                                locale.warranty,
                                                style: font.bodyMedium,
                                              ),
                                            if (warranty != null)
                                              Text(
                                                warranty!,
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (warranty != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            Text(
                                              locale.description,
                                              style: font.bodyMedium,
                                            ),
                                            Text(
                                              description,
                                              style: font.bodyMedium!.copyWith(
                                                  color: color.backgroundColor),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            if (maximumTyreLoad != null)
                                              Text(
                                                locale.maximumTyreLoad,
                                                style: font.bodyMedium,
                                              ),
                                            if (maximumTyreLoad != null)
                                              Text(
                                                maximumTyreLoad.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (maximumTyreLoad != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (tyreEngraving != null)
                                              Text(
                                                locale.tyreEngraving,
                                                style: font.bodyMedium,
                                              ),
                                            if (tyreEngraving != null)
                                              Text(
                                                tyreEngraving.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (tyreEngraving != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (tyreHeight != null)
                                              Text(
                                                locale.tyreHeight,
                                                style: font.bodyMedium,
                                              ),
                                            if (tyreHeight != null)
                                              Text(
                                                tyreHeight.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (tyreHeight != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (tyreWidth != null)
                                              Text(
                                                locale.tyreWidth,
                                                style: font.bodyMedium,
                                              ),
                                            if (tyreWidth != null)
                                              Text(
                                                tyreWidth.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (tyreWidth != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (volt != null)
                                              Text(
                                                locale.volt,
                                                style: font.bodyMedium,
                                              ),
                                            if (volt != null)
                                              Text(
                                                volt.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (volt != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (ampere != null)
                                              Text(
                                                locale.ampere,
                                                style: font.bodyMedium,
                                              ),
                                            if (ampere != null)
                                              Text(
                                                ampere.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (ampere != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (liter != null)
                                              Text(
                                                locale.liters,
                                                style: font.bodyMedium,
                                              ),
                                            if (liter != null)
                                              Text(
                                                liter.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (liter != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (productColor != null)
                                              Text(
                                                locale.color,
                                                style: font.bodyMedium,
                                              ),
                                            if (productColor != null)
                                              Text(
                                                productColor.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (productColor != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (numberSparkPulgs != null)
                                              Text(
                                                locale.numberOfSparkPulgs,
                                                style: font.bodyMedium,
                                              ),
                                            if (numberSparkPulgs != null)
                                              Text(
                                                numberSparkPulgs.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (numberSparkPulgs != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (oilType != null)
                                              Text(
                                                locale.oilType,
                                                style: font.bodyMedium,
                                              ),
                                            if (oilType != null)
                                              Text(
                                                oilType.toString(),
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                        color: color
                                                            .backgroundColor),
                                              ),
                                            if (oilType != null)
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            if (availableYears != null)
                                              Text(
                                                'Car Models',
                                                style: font.bodyMedium,
                                              ),
                                            if (availableYears != null)
                                              ListView.builder(
                                                itemCount: carModels!.length,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    Text(
                                                  carModels![index],
                                                  style: font.bodyMedium!
                                                      .copyWith(
                                                          color: color
                                                              .backgroundColor),
                                                ),
                                              ),
                                            if (availableYears != null)
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
                          RatingSummary(
                            counter: 13,
                            average:rating,
                            averageStyle: font.bodyMedium!.copyWith(
                              fontSize: 19.sp
                            ),
                            showAverage: true,
                            backgroundColor: Colors.grey.shade400,
                            counterFiveStars: rateStarFive.toInt(),
                            counterFourStars: rateStarFour.toInt(),
                            counterThreeStars: rateStarThree.toInt(),
                            counterTwoStars: rateStarTwo.toInt(),
                            counterOneStars: rateStarOne.toInt(),
                          ),
                          SizedBox(
                            height: 90.h,
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
