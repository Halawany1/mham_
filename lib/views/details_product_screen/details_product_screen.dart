import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return WillPopScope(
          onWillPop: () async {
            cubit.resetQuantity();
            Helper.pop(context);
            return true;
          },
          child: Scaffold(
            bottomSheet: Container(
              color: color.hoverColor,
              padding: EdgeInsets.all(15.h),
              child: BuildDefaultButton(
                  text: 'Add to Cart',
                  borderRadius: 12.r,
                  height: 32.h,
                  onPressed: () {

                  },
                  backgorundColor: color.backgroundColor,
                  colorText: color.primaryColor),
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
                    cubit.resetQuantity();
                    Helper.pop(context);
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
                                    type: cubit.homeProducts[index].type!,
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
                              decoration:index==0? BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: color.backgroundColor,width:2.w)
                              ):null,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.asset(
                                  'assets/images/product.png',
                                  fit: BoxFit.cover,
                                  width: 90.w,
                                  height: 90.w,
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => SizedBox(width: 8.w,),
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
                                cubit.homeProducts[index].productsName!,
                                style:
                                    font.bodyLarge!.copyWith(fontSize: 25.sp),
                                maxLines: 3,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text('${cubit.homeProducts[index].rating!}/5'),
                          SizedBox(
                            width: 5.w,
                          ),
                          const Icon(Icons.star),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (cubit.homeProducts[index].isOffer == true)
                        Text(
                          cubit.homeProducts[index].price.toString() +
                              ' ${locale.kd}',
                          style: font.bodyMedium!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor:
                                  color.backgroundColor.withOpacity(0.5),
                              fontSize: 15.sp,
                              color: color.backgroundColor.withOpacity(0.5)),
                        ),
                      if (cubit.homeProducts[index].isOffer == true)
                        SizedBox(
                          height: 5.h,
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${cubit.homeProducts[index].isOffer == true ? cubit.homeProducts[index].offerPrice : cubit.homeProducts[index].price} ${locale.kd}',
                            style: font.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: color.backgroundColor),
                          ),
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
                                  border: Border.all(color: color.hintColor),
                                  borderRadius: BorderRadius.circular(5.r),
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
                            border: Border.all(color: color.backgroundColor),
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
                                          : Icons.keyboard_arrow_down_rounded,
                                      color: color.backgroundColor,
                                    )
                                  ],
                                ),
                              ),
                              if (cubit.productDetailsContainer)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              cubit.homeProducts[index]
                                                  .businessCategory!.bcNameEn!,
                                              style: font.bodyMedium!.copyWith(
                                                  color: color.backgroundColor),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            if (cubit.homeProducts[index]
                                                    .madeIn !=
                                                null)
                                              Text(
                                                locale.madeIn,
                                                style: font.bodyMedium,
                                              ),
                                            if (cubit.homeProducts[index]
                                                    .madeIn !=
                                                null)
                                              Text(
                                                cubit.homeProducts[index]
                                                    .madeIn!,
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
                                                child: Text(
                                                    cubit.homeProducts[index]
                                                        .brandName!,
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
                                            Text(
                                                cubit.homeProducts[index].type!,
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
                                        if (cubit.homeProducts[index]
                                                .manufacturerPartNumber !=
                                            null)
                                          Text(
                                            locale.manufacturerPartNumber,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .manufacturerPartNumber !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index]
                                                .manufacturerPartNumber!,
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .manufacturerPartNumber !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .frontOrRear !=
                                            null)
                                          Text(
                                            locale.placementOnVehicle,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .frontOrRear !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index]
                                                .frontOrRear!,
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .frontOrRear !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .rimDiameter !=
                                            null)
                                          Text(
                                            '${locale.assembledProductDimensions}\n(L x W x H)',
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .rimDiameter !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index]
                                                .rimDiameter!
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .rimDiameter !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit
                                                .homeProducts[index].warranty !=
                                            null)
                                          Text(
                                            locale.warranty,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit
                                                .homeProducts[index].warranty !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].warranty!,
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit
                                                .homeProducts[index].warranty !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        Text(
                                          locale.description,
                                          style: font.bodyMedium,
                                        ),
                                        Text(
                                          cubit
                                              .homeProducts[index].description!,
                                          style: font.bodyMedium!.copyWith(
                                              color: color.backgroundColor),
                                        ),
                                        if (cubit.homeProducts[index]
                                                .maximumTyreLoad !=
                                            null)
                                          Text(
                                            locale.maximumTyreLoad,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .maximumTyreLoad !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index]
                                                .maximumTyreLoad
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .maximumTyreLoad !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreEngraving !=
                                            null)
                                          Text(
                                            locale.tyreEngraving,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreEngraving !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index]
                                                .tyreEngraving
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreEngraving !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreHeight !=
                                            null)
                                          Text(
                                            locale.tyreHeight,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreHeight !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].tyreHeight
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreHeight !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreWidth !=
                                            null)
                                          Text(
                                            locale.tyreWidth,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreWidth !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].tyreWidth
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .tyreWidth !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index].volt !=
                                            null)
                                          Text(
                                            locale.volt,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index].volt !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].volt
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index].volt !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index].ampere !=
                                            null)
                                          Text(
                                            locale.ampere,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index].ampere !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].ampere
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index].ampere !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index].liter !=
                                            null)
                                          Text(
                                            locale.liters,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index].liter !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].liter
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index].liter !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index].color !=
                                            null)
                                          Text(
                                            locale.color,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index].color !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].color
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index].color !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .numberSparkPulgs !=
                                            null)
                                          Text(
                                            locale.numberOfSparkPulgs,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index]
                                                .numberSparkPulgs !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index]
                                                .numberSparkPulgs
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index]
                                                .numberSparkPulgs !=
                                            null)
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        if (cubit.homeProducts[index].oilType !=
                                            null)
                                          Text(
                                            locale.oilType,
                                            style: font.bodyMedium,
                                          ),
                                        if (cubit.homeProducts[index].oilType !=
                                            null)
                                          Text(
                                            cubit.homeProducts[index].oilType
                                                .toString(),
                                            style: font.bodyMedium!.copyWith(
                                                color: color.backgroundColor),
                                          ),
                                        if (cubit.homeProducts[index].oilType !=
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
                        height: 50.h,
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
