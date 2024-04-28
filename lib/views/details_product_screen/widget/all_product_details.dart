import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuildAllProductDetails extends StatelessWidget {
  const BuildAllProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    var font = Theme.of(context).textTheme;
    var locale = AppLocalizations.of(context);
    return Container(
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
    );
  }
}

