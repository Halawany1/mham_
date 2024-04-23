import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/drop_down_menu.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/pop_up_sure_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/models/order_model.dart';
import 'package:mham/models/return_order_model.dart';

var reasonController = TextEditingController();

class BuildCardProductDetails extends StatelessWidget {
  const BuildCardProductDetails({
    super.key,
    required this.index,
    required this.opened,
    required this.onTap,
    this.carModels,
    this.returnProduct = false,
    required this.orders,
    required this.quantity,
  });

  final Orders orders;
  final int index;
  final bool opened;
  final bool returnProduct;
  final VoidCallback onTap;
  final List<String>? carModels;
  final List<String>quantity;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme
        .of(context)
        .textTheme;
    final locale = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: color.backgroundColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 220.w,
                        height: 45.h,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.asset(
                                'assets/images/product.png',
                                height: 80.h,
                                width: 80.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 5.w,
                              top: 2.h,
                              child: SizedBox(
                                width: 35.w,
                                height: 16.w,
                                child: BuildContainerType(
                                  type: orders.carts![0].cartProducts![index]
                                      .product!.type!,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 90.w,
                              child: SizedBox(
                                width: 140.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  orders.carts![0].cartProducts![index].product!
                                      .productsName!,
                                  style: font.bodyMedium!.copyWith(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 90.w,
                              top: 25.h,
                              child: SizedBox(
                                width: 85.w,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text(
                                    (orders.carts![0].cartProducts![index]
                                        .quantity! *
                                        orders
                                            .carts![0]
                                            .cartProducts![index]
                                            .product!
                                            .price)
                                        .toStringAsFixed(2) +
                                        ' ${locale.kd}',
                                    style: font.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                        color: color.backgroundColor),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 200.w,
                              top: 25.h,
                              child: Container(
                                alignment: Alignment.center,
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: color.disabledColor),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Text(
                                  style: font.bodyMedium!
                                      .copyWith(fontSize: 13.sp),
                                  orders.carts![0].cartProducts![index].quantity
                                      .toString(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Icon(
                        !opened
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down_outlined,
                        color: color.backgroundColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (opened)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    locale.specifications,
                    style:
                    font.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            locale.category,
                            style: font.bodyMedium,
                          ),
                          Text(
                            orders.carts![0].cartProducts![index].product!
                                .businessCategory!.bcNameEn!,
                            style: font.bodyMedium!
                                .copyWith(color: color.backgroundColor),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          if (orders.carts![0].cartProducts![index].product!
                              .madeIn !=
                              null)
                            Text(
                              locale.madeIn,
                              style: font.bodyMedium,
                            ),
                          if (orders.carts![0].cartProducts![index].product!
                              .madeIn !=
                              null)
                            Text(
                              orders.carts![0].cartProducts![index].product!
                                  .madeIn!,
                              style: font.bodyMedium!
                                  .copyWith(color: color.backgroundColor),
                            ),
                        ],
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  orders.carts![0].cartProducts![index].product!
                                      .brandName!,
                                  style: font.bodyMedium!
                                      .copyWith(color: color.backgroundColor)),
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
                              orders.carts![0].cartProducts![index].product!
                                  .type!,
                              style: font.bodyMedium!
                                  .copyWith(color: color.backgroundColor)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (orders.carts![0].cartProducts![index].product!
                          .manufacturerPartNumber !=
                          null)
                        Text(
                          locale.manufacturerPartNumber,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .manufacturerPartNumber !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .manufacturerPartNumber!,
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .manufacturerPartNumber !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .frontOrRear !=
                          null)
                        Text(
                          locale.placementOnVehicle,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .frontOrRear !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .frontOrRear!,
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .frontOrRear !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .rimDiameter !=
                          null)
                        Text(
                          '${locale.assembledProductDimensions}\n(L x W x H)',
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .rimDiameter !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .rimDiameter!
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .rimDiameter !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .warranty !=
                          null)
                        Text(
                          locale.warranty,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .warranty !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .warranty!,
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .warranty !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      Text(
                        locale.description,
                        style: font.bodyMedium,
                      ),
                      Text(
                        orders.carts![0].cartProducts![index].product!
                            .description!,
                        style: font.bodyMedium!
                            .copyWith(color: color.backgroundColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (orders.carts![0].cartProducts![index].product!
                          .maximumTyreLoad !=
                          null)
                        Text(
                          locale.maximumTyreLoad,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .maximumTyreLoad !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .maximumTyreLoad
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .maximumTyreLoad !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreEngraving !=
                          null)
                        Text(
                          locale.tyreEngraving,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreEngraving !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .tyreEngraving
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreEngraving !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreHeight !=
                          null)
                        Text(
                          locale.tyreHeight,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreHeight !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .tyreHeight
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreHeight !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreWidth !=
                          null)
                        Text(
                          locale.tyreWidth,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreWidth !=
                          null)
                        Text(
                          orders
                              .carts![0].cartProducts![index].product!.tyreWidth
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .tyreWidth !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!.volt !=
                          null)
                        Text(
                          locale.volt,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!.volt !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!.volt
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!.volt !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.ampere !=
                          null)
                        Text(
                          locale.ampere,
                          style: font.bodyMedium,
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.ampere !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!.ampere
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.ampere !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.liter !=
                          null)
                        Text(
                          locale.liters,
                          style: font.bodyMedium,
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.liter !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!.liter
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.liter !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.color !=
                          null)
                        Text(
                          locale.color,
                          style: font.bodyMedium,
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.color !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!.color
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders
                          .carts![0].cartProducts![index].product!.color !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .numberSparkPulgs !=
                          null)
                        Text(
                          locale.numberOfSparkPulgs,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .numberSparkPulgs !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!
                              .numberSparkPulgs
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .numberSparkPulgs !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .oilType !=
                          null)
                        Text(
                          locale.oilType,
                          style: font.bodyMedium,
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .oilType !=
                          null)
                        Text(
                          orders.carts![0].cartProducts![index].product!.oilType
                              .toString(),
                          style: font.bodyMedium!
                              .copyWith(color: color.backgroundColor),
                        ),
                      if (orders.carts![0].cartProducts![index].product!
                          .oilType !=
                          null)
                        SizedBox(
                          height: 10.h,
                        ),
                      if (carModels!.isNotEmpty)
                        Text(
                          locale.carModels,
                          style: font.bodyMedium,
                        ),
                      if (carModels!.isNotEmpty)
                        ListView.builder(
                          itemCount: carModels!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              Text(
                                carModels![index],
                                style: font.bodyMedium!
                                    .copyWith(color: color.backgroundColor),
                              ),
                        ),
                      if (carModels!.isNotEmpty)
                        SizedBox(
                          height: 10.h,
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildDefaultButton(
                              text: returnProduct
                                  ? 'Return Product'
                                  : locale.cancelItem,
                              width: 100.w,
                              height: 30.h,
                              borderRadius: 8.r,
                              onPressed: () {
                                if (returnProduct) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: color.cardColor,
                                        surfaceTintColor: color.cardColor,
                                        shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(
                                              8.r),
                                        ),
                                        title: Text(
                                          'Return Product',
                                          style: font.bodyLarge!.copyWith(
                                              fontSize: 15.sp
                                          ),
                                        ),
                                        content: SizedBox(
                                          height: 290.h,
                                          child: Column(
                                            children: [
                                              Text(
                                                textAlign: TextAlign.center,
                                                'Are you sure you want to Return this Product? This can’t be undone.',
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                    fontSize: 14.sp
                                                ),),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              BuildTextFormField(
                                                  withBorder: true,
                                                  title: 'Reason',
                                                  hint: 'Write a reason...',
                                                  controller: reasonController,
                                                  contentPadding: true,
                                                  cubit: AuthenticationCubit
                                                      .get(context),
                                                  validator: (value) {
                                                    return Validation
                                                        .validateField(value,
                                                        'Reason', context);
                                                  },
                                                  maxLines: 5,
                                                  keyboardType:
                                                  TextInputType.text,
                                                  maxLength: 1000),
                                              SizedBox(height: 15.h,),
                                              BuildDropDownMenu(list: quantity,
                                                valueName: 'quantity',
                                                value: HomeCubit
                                                    .get(context)
                                                    .quantityValue,
                                                onChange: (value) {
                                                  HomeCubit.get(context)
                                                      .changeQuantityValue(
                                                      value: value!);
                                                },),
                                              SizedBox(height: 20.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  BuildDefaultButton(
                                                      text: 'Cancel',
                                                      width: 90.w,
                                                      height: 25.h,
                                                      borderRadius: 5.r,
                                                      onPressed: () {
                                                        reasonController.clear();
                                                        HomeCubit.get(context).quantityValue=null;
                                                        Navigator.pop(context);
                                                      },
                                                      backgorundColor:
                                                      color
                                                          .scaffoldBackgroundColor,
                                                      colorText: color
                                                          .primaryColor),
                                                  BuildDefaultButton(
                                                      text: 'Return',
                                                      width: 90.w,
                                                      borderRadius: 5.r,
                                                      height: 25.h,
                                                      onPressed: () {
                                                        List<Map<String,dynamic>>returns = [
                                                        ];
                                                        returns.add({
                                                          'cartProduct_id':orders.carts![0]
                                                              .cartProducts![index]
                                                              .productId,
                                                          "reason": reasonController.text,
                                                          "quantity":
                                                          int.parse(HomeCubit.get(context)
                                                              .quantityValue!)
                                                        });
                                                        reasonController.clear();
                                                        HomeCubit.get(context).quantityValue=null;
                                                        HomeCubit.get(context)
                                                            .returnOrder(
                                                            returns:returns);
                                                        Navigator.pop(context);
                                                      },
                                                      backgorundColor:
                                                      color.backgroundColor,
                                                      colorText: ColorConstant
                                                          .brown),
                                                ],)
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return confirmPopUp(
                                        context: context,
                                        onPress: () {
                                          HomeCubit.get(context).cancelProduct(
                                              orderId:
                                              orders.carts![0].orderId!,
                                              productId: orders
                                                  .carts![0]
                                                  .cartProducts![index]
                                                  .product!
                                                  .productsId!);
                                          Navigator.pop(context);
                                        },
                                        title: locale.cancelItem,
                                        content: locale.areYourSureToCancelItem,
                                      );
                                    },
                                  );
                                }
                              },
                              backgorundColor: color.backgroundColor,
                              colorText: color.primaryColor),
                        ],
                      )
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
