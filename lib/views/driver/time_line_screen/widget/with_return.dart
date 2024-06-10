import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/go_link_row_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/driver/order_details_screen/check_box_list_tile.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';
import 'package:mham/views/driver/time_line_screen/widget/order_details_for_return.dart';
import 'package:mham/views/order_details_screen/widget/tracking_order.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

SafeArea buildWithReturn(OrderDriverCubit cubit, AppLocalizations locale,
    TextTheme font, ThemeData color, GlobalKey<FormState> formKey,
    TextEditingController reasonController, BuildContext context) {

  return SafeArea(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            SizedBox(
              height: 12.h,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(locale.returnOrder,
                    style: font.bodyMedium,),
                ],
              ),
            SizedBox(height: 20.h,),
            BuildOrderDetailsReturnTimeLine(
                lenght: cubit.returnOrderModel!
                    .activeOrder!.orderItems!.length,
                createdAt: cubit.returnOrderModel!
                    .activeOrder!.createdAt!,
                status: cubit.returnOrderModel!
                    .activeOrder!.status!,
                totalPrice: double.parse(cubit
                    .returnOrderModel!
                    .activeOrder!
                    .totalPrice!
                    .toString())),
            SizedBox(
              height: 20.h,
            ),
            BuildTrackingOrder(
                activeProcess: cubit.returnOrderModel!
                    .activeOrder!.status ==
                    "Ordered"
                    ? 1
                    : cubit.returnOrderModel!.activeOrder!
                    .status ==
                    "Processing"
                    ? 2
                    : cubit.returnOrderModel!
                    .activeOrder!.status ==
                    "Shipped"
                    ? 3
                    : 4,
                shiped: cubit.returnOrderModel!
                    .activeOrder!.shippedAt ==
                    null
                    ? true
                    : false,
                notClosed: true,
                createdAt: cubit.returnOrderModel!
                    .activeOrder!.createdAt!,
                orderId: cubit
                    .returnOrderModel!.activeOrder!.id!,
                stepperData: [
                  StepperData(
                      title: StepperText(locale.ordered,
                          textStyle: font.bodyMedium),
                      subtitle: StepperText(
                        locale.orderPlaced +
                            Helper.trackingTimeFormat(cubit
                                .returnOrderModel!
                                .activeOrder!
                                .createdAt!),
                        textStyle: font.bodyMedium!
                            .copyWith(
                            fontSize: 12.sp,
                            color: color.primaryColor
                                .withOpacity(0.7)),
                      ),
                      iconWidget: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color.backgroundColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.r))),
                        child: Text('1',
                            style: font.bodyMedium!
                                .copyWith(
                                color: ColorConstant
                                    .brown)),
                      )),
                  StepperData(
                      title: StepperText(locale.processing,
                          textStyle: font.bodyMedium),
                      subtitle: cubit
                          .returnOrderModel!
                          .activeOrder!
                          .status=="Shipped"||
                          cubit
                              .returnOrderModel!
                              .activeOrder!
                              .status=="Delivered"||
                          cubit
                              .returnOrderModel!
                              .activeOrder!
                              .status=="Processing"
                          ? StepperText(
                          locale.orderPrepared +
                              Helper.trackingTimeFormat(cubit
                                  .returnOrderModel!
                                  .activeOrder!
                                  .processingAt!),
                          textStyle:
                          font.bodySmall!.copyWith(color: color.primaryColor.withOpacity(0.8)))
                          : null,
                      iconWidget: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: cubit
                                .returnOrderModel!
                                .activeOrder!
                                .status=="Shipped"||
                                cubit
                                    .returnOrderModel!
                                    .activeOrder!
                                    .status=="Delivered"||
                                cubit
                                    .returnOrderModel!
                                    .activeOrder!
                                    .status=="Processing"
                                ? color.backgroundColor
                                : Colors.grey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.r))),
                        child: Text('2',
                            style: font.bodyMedium!
                                .copyWith(
                                color: ColorConstant
                                    .brown)),
                      )),
                  StepperData(
                      title: StepperText(locale.shipped,
                          textStyle: font.bodyMedium),
                      subtitle:cubit
                          .returnOrderModel!
                          .activeOrder!
                          .status=="Shipped"||
                          cubit
                              .returnOrderModel!
                              .activeOrder!
                              .status=="Delivered"
                          ? StepperText(
                          textStyle: font.bodySmall!
                              .copyWith(
                              color: color.primaryColor.withOpacity(0.8)),
                          locale.deliverItem +
                              Helper.trackingTimeFormat(
                                  cubit
                                      .returnOrderModel!
                                      .activeOrder!
                                      .shippedAt!))
                          : null,
                      iconWidget: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: cubit
                                .returnOrderModel!
                                .activeOrder!
                                .status=="Shipped"||
                                cubit
                                    .returnOrderModel!
                                    .activeOrder!
                                    .status=="Delivered"
                                ? color.backgroundColor
                                : Colors.grey,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.r))),
                        child: Text('3',
                            style: font.bodyMedium!
                                .copyWith(
                                color: ColorConstant
                                    .brown)),
                      )),
                  StepperData(
                    iconWidget: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                          cubit
                              .returnOrderModel!
                              .activeOrder!
                              .status=="Delivered"
                              ? Border.all(
                              color: color.primaryColor)
                              : null,
                          color:  cubit
                              .returnOrderModel!
                              .activeOrder!
                              .status=="Delivered"
                              ? color.backgroundColor
                              : Colors.grey,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.r))),
                    ),
                    title: StepperText(locale.delivered,
                        textStyle: font.bodyMedium),
                  ),
                ],
                totalPrice: cubit.returnOrderModel!
                    .activeOrder!.totalPrice!
                    .toDouble()),
            SizedBox(
              height: 20.h,
            ),
            if (cubit.returnOrderModel!.activeOrder!
                .orderItems!.isNotEmpty)
              Text(
                locale.products,
                style: font.bodyLarge!
                    .copyWith(fontSize: 22.sp),
              ),
            if (cubit.returnOrderModel!.activeOrder!
                .orderItems!.isNotEmpty)
              SizedBox(
                height: 25.h,
              ),
            ListView.separated(
              separatorBuilder: (context, index) =>
                  SizedBox(
                    height: 20.h,
                  ),
              itemBuilder: (context, index) => Container(
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit
                              .openAndCloseDetailsProduct();
                        },
                        child: Container(
                          width: double.infinity,
                          child: Directionality(
                            textDirection:
                            TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 220.w,
                                  height: 45.h,
                                  child: Stack(
                                    children: [
                                      if(cubit
                                          .returnOrderModel!
                                          .activeOrder!
                                          .orderItems![
                                      index]
                                          .product!
                                          .productsImg!=null)
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              10.r),
                                          child: Image.network(
                                            AppConstant.baseImage+cubit
                                                .returnOrderModel!
                                                .activeOrder!
                                                .orderItems![
                                            index]
                                                .product!
                                                .productsImg!,
                                            height: 80.h,
                                            width: 80.w,
                                            fit: BoxFit.fill,
                                          ),
                                        ),

                                      if(cubit
                                          .returnOrderModel!
                                          .activeOrder!
                                          .orderItems![
                                      index]
                                          .product!
                                          .productsImg==null)

                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              10.r),
                                          child: Image.asset(
                                            'assets/images/product.png',
                                            height: 80.h,
                                            width: 80.w,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      Positioned(
                                        left: 5.w,
                                        top: 2.h,
                                        child: SizedBox(
                                          width: 35.w,
                                          height: 16.w,
                                          child:
                                          BuildContainerType(
                                            type: cubit
                                                .returnOrderModel!
                                                .activeOrder!
                                                .orderItems![
                                            index]
                                                .product!
                                                .type!,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 90.w,
                                        child: SizedBox(
                                          width: 140.w,
                                          child: Text(
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                            cubit
                                                .returnOrderModel!
                                                .activeOrder!
                                                .orderItems![
                                            index]
                                                .product!
                                                .productsName!,
                                            style: font
                                                .bodyMedium!
                                                .copyWith(
                                              fontSize:
                                              15.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 90.w,
                                        top: 25.h,
                                        child: SizedBox(
                                          width: 85.w,
                                          height: 20.h,
                                          child: FittedBox(
                                            fit: BoxFit
                                                .cover,
                                            child: Text(
                                              cubit
                                                  .returnOrderModel!
                                                  .activeOrder!
                                                  .orderItems![
                                              index]
                                                  .product!
                                                  .price!
                                                  .toString() +
                                                  ' ${locale.kd}',
                                              style: font.bodyMedium!.copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize:
                                                  12.sp,
                                                  color: color
                                                      .backgroundColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 200.w,
                                        top: 25.h,
                                        child: Container(
                                          alignment:
                                          Alignment
                                              .center,
                                          width: 20.w,
                                          height: 20.w,
                                          decoration:
                                          BoxDecoration(
                                            border: Border.all(
                                                color: color
                                                    .primaryColor),
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                5.r),
                                          ),
                                          child: Text(
                                            style: font
                                                .bodyMedium!
                                                .copyWith(
                                                fontSize:
                                                13.sp),
                                            cubit
                                                .returnOrderModel!
                                                .activeOrder!
                                                .orderItems![
                                            index].quantity.toString(),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(
                                  true
                                      ? Icons
                                      .keyboard_arrow_up
                                      : Icons
                                      .keyboard_arrow_down_outlined,
                                  color:
                                  color.backgroundColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (true)
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Divider(),
                            SizedBox(
                              height: 10.h,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount: 4,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.6,
                              ),
                              itemBuilder: (context, i) =>
                                  BuildCheckBoxListTile(
                                    text: cubit
                                        .checkboxListTiles[i]
                                        .title,
                                    value: cubit
                                        .checkStatus[index][i],
                                    changeValue: (value) {
                                      cubit.changeCheckboxListTile(
                                          orderId: cubit
                                              .returnOrderModel!
                                              .activeOrder!
                                              .id!,
                                          id: cubit
                                              .returnOrderModel!
                                              .activeOrder!
                                              .orderItems![
                                          index]
                                              .id!,
                                          index: i,
                                          value:
                                          cubit.checkStatus[
                                          index][i]);
                                    },
                                  ),
                            ),
                            if (cubit.checkboxListTiles[0]
                                .value ||
                                cubit.checkboxListTiles[1]
                                    .value)
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: color
                                            .backgroundColor,
                                        radius: 5.r,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Trader Information',
                                        style: font
                                            .bodyLarge!
                                            .copyWith(
                                            fontSize:
                                            15.sp,
                                            color: color
                                                .backgroundColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets
                                        .symmetric(
                                        horizontal:
                                        22.w,
                                        vertical: 5.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          cubit
                                              .returnOrderModel!
                                              .activeOrder!
                                              .orderItems![index].
                                          product!.trader!.user!.userName!,
                                          style: font
                                              .bodyMedium!
                                              .copyWith(
                                              fontSize:
                                              13.sp),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          cubit
                                              .returnOrderModel!
                                              .activeOrder!
                                              .orderItems![index].
                                          product!.trader!.user!.mobile!,
                                          style: font
                                              .bodyMedium!
                                              .copyWith(
                                              fontSize:
                                              13.sp),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          cubit
                                              .returnOrderModel!
                                              .activeOrder!
                                              .orderItems![index]
                                              .product!
                                              .address![0].address!,
                                          style: font.bodyMedium
                                          !.copyWith(fontSize: 13.sp),
                                        ),

                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        BuildGoToLinkRow(
                                          index: index,
                                          assign: true,
                                          link: cubit
                                              .returnOrderModel!
                                              .activeOrder!
                                              .location!,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            SizedBox(
                              height: 12.h,
                            ),
                            BuildDefaultButton(
                                text: locale.cancelItem,
                                width: 100.w,
                                height: 26.h,
                                fontSize: 12.sp,
                                borderRadius: 8.r,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Form(
                                        key: formKey,
                                        child: AlertDialog(
                                          backgroundColor:
                                          color.scaffoldBackgroundColor,
                                          title: Text(
                                            locale.cancelOrder,
                                            style: font.bodyMedium!
                                                .copyWith(
                                                fontWeight:
                                                FontWeight.bold,
                                                color: ColorConstant
                                                    .error),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                BuildTextFormField(
                                                  cubit: AuthenticationCubit
                                                      .get(context),
                                                  title: locale.cancelOrder,
                                                  contentPadding: true,
                                                  hint: locale.reason,
                                                  validator:
                                                      (String? value) {
                                                    return Validation
                                                        .validateField(
                                                        value,
                                                        locale.reason,
                                                        context);
                                                  },
                                                  controller:
                                                  reasonController,
                                                  keyboardType:
                                                  TextInputType.text,
                                                  maxLength: 1000,
                                                  maxLines: 5,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                BuildTextFormField(
                                                    title: locale.image,
                                                    hint:
                                                    locale.enterReasonImage,
                                                    cubit:
                                                    AuthenticationCubit
                                                        .get(context),
                                                    controller:
                                                    imageController,
                                                    withBorder: true,
                                                    validator: (value) {
                                                      return null;
                                                    },
                                                    onTap: () async {
                                                      final ImagePicker
                                                      picker =
                                                      ImagePicker();
                                                      imageFileOne =
                                                      await picker
                                                          .pickImage(
                                                        source: ImageSource
                                                            .gallery,
                                                        // alternatively, use ImageSource.gallery
                                                        maxWidth: 400,
                                                      );
                                                      if (imageFileOne ==
                                                          null) return;
                                                      final String
                                                      imagePath =
                                                          imageFileOne!
                                                              .path;
                                                      final String
                                                      imageName =
                                                      imagePath.substring(
                                                          imagePath.lastIndexOf(
                                                              '/') +
                                                              1);

                                                      // Set the image filename to the imageController
                                                      imageController.text =
                                                          imageName;
                                                    },
                                                    readOnly: true,
                                                    keyboardType:
                                                    TextInputType.text,
                                                    maxLength: 100)
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                reasonController.clear();
                                                imageController.clear();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                locale.cancel,
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                    color: color
                                                        .primaryColor),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.cancelItemOrder(
                                                      image: imageFileOne ==
                                                          null
                                                          ? ''
                                                          : imageFileOne!
                                                          .path,
                                                      lang:
                                                      LayoutCubit.get(
                                                          context)
                                                          .lang,
                                                      reason:
                                                      reasonController
                                                          .text,
                                                      id: cubit
                                                          .returnOrderModel!
                                                          .activeOrder!.orderItems![index]
                                                          .id!);
                                                  reasonController.clear();
                                                  imageController.clear();
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Text(
                                                locale.ok,
                                                style: font.bodyMedium!
                                                    .copyWith(
                                                    color: ColorConstant
                                                        .error),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                backgorundColor:
                                color.backgroundColor,
                                colorText:
                                ColorConstant.brown)
                          ],
                        )
                    ],
                  ),
                ),
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cubit.returnOrderModel!
                  .activeOrder!.orderItems!.length,
            ),
            SizedBox(
              height: 30.h,
            ),
            BuildDefaultButton(
                text: locale.cancelOrder,
                width: 120.w,
                height: 26.h,
                fontSize: 14.sp,
                borderRadius: 8.r,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Form(
                        key: formKey,
                        child: AlertDialog(
                          backgroundColor:
                          color.scaffoldBackgroundColor,
                          title: Text(
                            locale.cancelOrder,
                            style: font.bodyMedium!
                                .copyWith(
                                fontWeight:
                                FontWeight.bold,
                                color: ColorConstant
                                    .error),
                          ),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                BuildTextFormField(
                                  cubit: AuthenticationCubit
                                      .get(context),
                                  title: locale.cancelOrder,
                                  contentPadding: true,
                                  hint: locale.reason,
                                  validator:
                                      (String? value) {
                                    return Validation
                                        .validateField(
                                        value,
                                        locale.reason,
                                        context);
                                  },
                                  controller:
                                  reasonController,
                                  keyboardType:
                                  TextInputType.text,
                                  maxLength: 1000,
                                  maxLines: 5,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                BuildTextFormField(
                                    title: locale.image,
                                    hint:
                                    locale.enterReasonImage,
                                    cubit:
                                    AuthenticationCubit
                                        .get(context),
                                    controller:
                                    imageController,
                                    withBorder: true,
                                    validator: (value) {
                                      return Validation.validateField(value,
                                          locale.image, context);
                                    },
                                    onTap: () async {
                                      final ImagePicker
                                      picker =
                                      ImagePicker();
                                      imageFileOne =
                                      await picker
                                          .pickImage(
                                        source: ImageSource
                                            .gallery,
                                        // alternatively, use ImageSource.gallery
                                        maxWidth: 400,
                                      );
                                      if (imageFileOne ==
                                          null) return;
                                      final String
                                      imagePath =
                                          imageFileOne!
                                              .path;
                                      final String
                                      imageName =
                                      imagePath.substring(
                                          imagePath.lastIndexOf(
                                              '/') +
                                              1);

                                      // Set the image filename to the imageController
                                      imageController.text =
                                          imageName;
                                    },
                                    readOnly: true,
                                    keyboardType:
                                    TextInputType.text,
                                    maxLength: 100)
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                reasonController.clear();
                                imageController.clear();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                locale.cancel,
                                style: font.bodyMedium!
                                    .copyWith(
                                    color: color
                                        .primaryColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (formKey.currentState!
                                    .validate()) {
                                  cubit.cancelOrder(
                                      image: imageFileOne ==
                                          null
                                          ? ''
                                          : imageFileOne!
                                          .path,
                                      lang:
                                      LayoutCubit.get(
                                          context)
                                          .lang,
                                      reason:
                                      reasonController
                                          .text,
                                      id: cubit
                                          .returnOrderModel!
                                          .activeOrder!
                                          .id!);
                                  reasonController.clear();
                                  imageController.clear();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                locale.ok,
                                style: font.bodyMedium!
                                    .copyWith(
                                    color: ColorConstant
                                        .error),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                backgorundColor: color.backgroundColor,
                colorText: ColorConstant.brown)
          ],
        ),
      ),
    ),
  );
}
