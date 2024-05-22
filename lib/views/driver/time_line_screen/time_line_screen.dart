import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/go_link_row_component.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:mham/views/driver/order_details_screen/card_products.dart';
import 'package:mham/views/driver/order_details_screen/check_box_list_tile.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';
import 'package:mham/views/order_details_screen/widget/order_details.dart';
import 'package:mham/views/order_details_screen/widget/tracking_order.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var reasonController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    if(OrderDriverCubit.get(context).timeLineOrderModel == null){
      OrderDriverCubit.get(context).getAssignedOrder(driverId:
      CacheHelper.getData(key:AppConstant.driverId));
    }
    return WillPopScope(
      onWillPop: () async {
        Helper.pop(context);
        return true;
      },
      child: BlocConsumer<OrderDriverCubit, OrderDriverState>(
        listener: (context, state) {
          if (state is SuccessCancelOrderDriverState) {
            showMessageResponse(
                message: locale.orderCancelSucess,
                context: context,
                success: true);
          }
          if (state is ErrorCancelOrderDriverState) {
            showMessageResponse(
                message: state.error, context: context, success: false);
          }
          if (state is ErrorUpdateOrderItemState) {
            showMessageResponse(
                message: state.error, context: context, success: false);
          }
        },
        builder: (context, state) {
          var cubit = context.read<OrderDriverCubit>();
          return Scaffold(
            appBar: topAppBar(context),
            body:
            cubit.emptyTimeLineAndAssign?
            Center(child: Text(locale.noOrdersFound))
                :
            cubit.timeLineOrderModel == null
                    ? Center(
                        child: BuildImageLoader(assetName: ImageConstant.logo))
                    : RefreshIndicator(
              backgroundColor: color.primaryColor,
              color: color.backgroundColor,
              onRefresh: () async{
                cubit.getAssignedOrder(driverId: CacheHelper.getData(key:
                AppConstant.driverId));
              },
                      child: SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(20.h),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  BuildOrderDetails(
                                      lenght: cubit.timeLineOrderModel!
                                          .activeOrder!.orderItems!.length,
                                      createdAt: cubit.timeLineOrderModel!
                                          .activeOrder!.createdAt!,
                                      status: cubit.timeLineOrderModel!
                                          .activeOrder!.status!,
                                      totalPrice: double.parse(cubit
                                          .timeLineOrderModel!
                                          .activeOrder!
                                          .totalPrice!
                                          .toString())),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  BuildTrackingOrder(
                                      activeProcess: cubit.timeLineOrderModel!
                                                  .activeOrder!.status ==
                                              "Ordered"
                                          ? 1
                                          : cubit.timeLineOrderModel!.activeOrder!
                                                      .status ==
                                                  "Processing"
                                              ? 2
                                              : cubit.timeLineOrderModel!
                                                          .activeOrder!.status ==
                                                      "Shipped"
                                                  ? 3
                                                  : 4,
                                      shiped: cubit.timeLineOrderModel!
                                                  .activeOrder!.shippedAt ==
                                              null
                                          ? true
                                          : false,
                                      notClosed: true,
                                      createdAt: cubit.timeLineOrderModel!
                                          .activeOrder!.createdAt!,
                                      orderId: cubit
                                          .timeLineOrderModel!.activeOrder!.id!,
                                      stepperData: [
                                        StepperData(
                                            title: StepperText(locale.ordered,
                                                textStyle: font.bodyMedium),
                                            subtitle: StepperText(
                                              locale.orderPlaced +
                                                  Helper.trackingTimeFormat(cubit
                                                      .timeLineOrderModel!
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
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .deliveredAt !=
                                                        null &&
                                                    cubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .processingAt !=
                                                        null
                                                ? StepperText(
                                                    locale.orderPrepared +
                                                        Helper.trackingTimeFormat(cubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .processingAt!),
                                                    textStyle:
                                                        font.bodySmall!.copyWith(color: Colors.grey))
                                                : null,
                                            iconWidget: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: cubit
                                                                  .timeLineOrderModel!
                                                                  .activeOrder!
                                                                  .deliveredAt !=
                                                              null ||
                                                          cubit
                                                                  .timeLineOrderModel!
                                                                  .activeOrder!
                                                                  .processingAt !=
                                                              null ||
                                                      cubit
                                                          .timeLineOrderModel!
                                                          .activeOrder!
                                                          .shippedAt !=
                                                          null
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
                                            subtitle: cubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .deliveredAt !=
                                                        null &&
                                                    cubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .shippedAt !=
                                                        null
                                                ? StepperText(
                                                    textStyle: font.bodySmall!
                                                        .copyWith(
                                                            color: Colors.grey),
                                                    locale.deliverItem +
                                                        Helper.trackingTimeFormat(
                                                            cubit
                                                                .driverOrderByIdModel!
                                                                .order!
                                                                .shippedAt!))
                                                : null,
                                            iconWidget: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: cubit
                                                                  .timeLineOrderModel!
                                                                  .activeOrder!
                                                                  .deliveredAt !=
                                                              null ||
                                                          cubit
                                                                  .timeLineOrderModel!
                                                                  .activeOrder!
                                                                  .shippedAt !=
                                                              null
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
                                                border: cubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .deliveredAt !=
                                                        null
                                                    ? Border.all(
                                                        color: color.primaryColor)
                                                    : null,
                                                color: cubit
                                                            .timeLineOrderModel!
                                                            .activeOrder!
                                                            .deliveredAt !=
                                                        null
                                                    ? color.backgroundColor
                                                    : Colors.grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.r))),
                                          ),
                                          title: StepperText(locale.delivered,
                                              textStyle: font.bodyMedium),
                                        ),
                                      ],
                                      totalPrice: cubit.timeLineOrderModel!
                                          .activeOrder!.totalPrice!
                                          .toDouble()),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  if (cubit.timeLineOrderModel!.activeOrder!
                                      .orderItems!.isNotEmpty)
                                    Text(
                                      locale.products,
                                      style: font.bodyLarge!
                                          .copyWith(fontSize: 22.sp),
                                    ),
                                  if (cubit.timeLineOrderModel!.activeOrder!
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
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
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
                                                                child:
                                                                    BuildContainerType(
                                                                  type: cubit
                                                                      .timeLineOrderModel!
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
                                                                      .timeLineOrderModel!
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
                                                                            .timeLineOrderModel!
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
                                                                  5.toString(),
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
                                                                .timeLineOrderModel!
                                                                .activeOrder!
                                                                .id!,
                                                            id: cubit
                                                                .timeLineOrderModel!
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
                                                                    .timeLineOrderModel!
                                                                    .activeOrder!
                                                                    .customer!
                                                                    .userName!,
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
                                                                    .timeLineOrderModel!
                                                                    .activeOrder!
                                                                    .customer!
                                                                    .mobile!,
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
                                                                    .timeLineOrderModel!
                                                                    .activeOrder!
                                                                    .address!,
                                                                style: font
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            13.sp),
                                                              ),
                                                              SizedBox(
                                                                height: 3.h,
                                                              ),
                                                              BuildGoToLinkRow(
                                                                index: index,
                                                                assign: true,
                                                                link: cubit
                                                                    .timeLineOrderModel!
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
                                                                                .timeLineOrderModel!
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
                                    itemCount: cubit.timeLineOrderModel!
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
                                                                .timeLineOrderModel!
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
                        ),
                    ),
          );
        },
      ),
    );
  }
}
