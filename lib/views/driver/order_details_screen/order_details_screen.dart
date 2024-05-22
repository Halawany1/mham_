import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/order_details_screen/card_products.dart';
import 'package:mham/views/order_details_screen/widget/order_details.dart';
import 'package:mham/views/order_details_screen/widget/tracking_order.dart';

var reasonController = TextEditingController();
var formKey = GlobalKey<FormState>();
var imageController = TextEditingController();
XFile? imageFileOne;

class OrderDetailsDriverScreen extends StatelessWidget {
  const OrderDetailsDriverScreen({
    super.key,
     this.closeDetails=false,
  });

  final bool closeDetails;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    var cubit = OrderDriverCubit.get(context);

    return WillPopScope(
      onWillPop: () async {
        Helper.pop(context);
        return true;
      },
      child: BlocConsumer<OrderDriverCubit, OrderDriverState>(
        listener: (context, state) {
          if (state is SuccessCancelOrderDriverState) {
            showMessageResponse(
                message: 'Order Canceled Successfully',
                context: context,
                success: true);
          }
          if (state is ErrorCancelOrderDriverState) {
            showMessageResponse(
                message: state.error, context: context, success: false);
          }
          if(state is ErrorUpdateOrderItemState){
            showMessageResponse(
                message: state.error, context: context, success: false);

          }
        },
        builder: (context, state) {
          var cubit = context.read<OrderDriverCubit>();
          return Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Helper.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: color.primaryColor)),
              centerTitle: true,
              title: Text(
                locale.orderDetails,
                style: font.bodyLarge!.copyWith(fontSize: 22.sp),
              ),
            ),
            body: cubit.driverOrderByIdModel == null ||
                    state is LoadingGetOrderByIdState ||
              state is LoadingUpdateOrderItemState
                ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12.h,
                            ),
                            BuildOrderDetails(
                                lenght: cubit.driverOrderByIdModel!.order!
                                    .orderItems!.length,
                                createdAt: cubit
                                    .driverOrderByIdModel!.order!.createdAt!,
                                status:
                                    cubit.driverOrderByIdModel!.order!.status!,
                                totalPrice: double.parse(cubit
                                    .driverOrderByIdModel!.order!.totalPrice!
                                    .toString())),
                            SizedBox(
                              height: 20.h,
                            ),
                            BuildTrackingOrder(
                                activeProcess: cubit.driverOrderByIdModel!.order!
                                    .deliveredAt != null ? 4 :
                                cubit.driverOrderByIdModel!.order!
                                    .shippedAt != null ? 3 : cubit.driverOrderByIdModel!
                                    .order!
                                    .processingAt != null ? 2 : cubit.driverOrderByIdModel!
                                    .order!
                                    .createdAt != null ? 1:0,
                                shiped: cubit.driverOrderByIdModel!.order!
                                            .shippedAt ==
                                        null
                                    ? true
                                    : false,
                                notClosed: true,
                                createdAt: cubit
                                    .driverOrderByIdModel!.order!.createdAt!,
                                orderId: cubit.driverOrderByIdModel!.order!.id!,
                                stepperData: [
                                  StepperData(
                                      title: StepperText(locale.ordered,
                                          textStyle: font.bodyMedium),
                                      subtitle: StepperText(
                                        locale.orderPlaced +
                                            Helper.trackingTimeFormat(cubit
                                                .driverOrderByIdModel!
                                                .order!
                                                .createdAt!),
                                        textStyle: font.bodyMedium!.copyWith(
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
                                            style: font.bodyMedium!.copyWith(
                                                color: ColorConstant.brown)),
                                      )),
                                  StepperData(
                                      title: StepperText(locale.processing,
                                          textStyle: font.bodyMedium),
                                      subtitle: cubit.driverOrderByIdModel!
                                                      .order!.deliveredAt !=
                                                  null &&
                                              cubit.driverOrderByIdModel!.order!
                                                      .processingAt !=
                                                  null
                                          ? StepperText(
                                              locale.orderPrepared +
                                                  Helper.trackingTimeFormat(
                                                      cubit
                                                          .driverOrderByIdModel!
                                                          .order!
                                                          .processingAt!),
                                              textStyle: font.bodySmall!
                                                  .copyWith(color: Colors.grey))
                                          : null,
                                      iconWidget: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: cubit.driverOrderByIdModel!
                                                            .order!.deliveredAt !=
                                                        null ||
                                                    cubit
                                                            .driverOrderByIdModel!
                                                            .order!
                                                            .processingAt !=
                                                        null
                                                ? color.backgroundColor
                                                : Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.r))),
                                        child: Text('2',
                                            style: font.bodyMedium!.copyWith(
                                                color:ColorConstant.brown)),
                                      )),
                                  StepperData(
                                      title: StepperText(locale.shipped,
                                          textStyle: font.bodyMedium),
                                      subtitle: cubit.driverOrderByIdModel!
                                                      .order!.deliveredAt !=
                                                  null &&
                                              cubit.driverOrderByIdModel!.order!
                                                      .shippedAt !=
                                                  null
                                          ? StepperText(
                                              textStyle: font.bodySmall!
                                                  .copyWith(color: Colors.grey),
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
                                            color: cubit.driverOrderByIdModel!
                                                            .order!.deliveredAt !=
                                                        null ||
                                                    cubit.driverOrderByIdModel!
                                                            .order!.shippedAt !=
                                                        null
                                                ? color.backgroundColor
                                                : Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.r))),
                                        child: Text('3',
                                            style: font.bodyMedium!.copyWith(
                                                color: ColorConstant.brown)),
                                      )),
                                  StepperData(
                                    iconWidget: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: cubit.driverOrderByIdModel!
                                                      .order!.deliveredAt !=
                                                  null
                                              ? Border.all(
                                                  color: color.primaryColor)
                                              : null,
                                          color: cubit.driverOrderByIdModel!
                                                      .order!.deliveredAt !=
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
                                totalPrice: cubit
                                    .driverOrderByIdModel!.order!.totalPrice!
                                    .toDouble()),
                            SizedBox(
                              height: 20.h,
                            ),
                            if (cubit.driverOrderByIdModel!.order!.orderItems!
                                .isNotEmpty)
                              Text(
                                locale.products,
                                style:
                                    font.bodyLarge!.copyWith(fontSize: 22.sp),
                              ),
                            if (cubit.driverOrderByIdModel!.order!.orderItems!
                                .isNotEmpty)
                              SizedBox(
                                height: 25.h,
                              ),
                            ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 20.h,
                              ),
                              itemBuilder: (context, index) =>
                                  BuildCardProductDetailsForDriver(
                                      index: index,
                                      notClosed: closeDetails,
                                      opened:
                                          cubit.openAndCloseDetailsContainer),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.driverOrderByIdModel!.order!
                                  .orderItems!.length,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            if(!closeDetails)
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
                                            style: font.bodyMedium!.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: ColorConstant.error),
                                          ),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                BuildTextFormField(
                                                  cubit:
                                                      AuthenticationCubit.get(
                                                          context),
                                                  title: locale.cancelOrder,
                                                  contentPadding: true,
                                                  hint: locale.reason,
                                                  validator: (String? value) {
                                                    return Validation
                                                        .validateField(
                                                            value,
                                                            locale.reason,
                                                            context);
                                                  },
                                                  controller: reasonController,
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
                                                    hint: locale.enterReasonImage,
                                                    cubit:
                                                        AuthenticationCubit.get(
                                                            context),
                                                    controller: imageController,
                                                    withBorder: true,
                                                    validator: (value) {
                                                      return Validation.validateField(value,
                                                          locale.image, context);
                                                    },
                                                    onTap: () async {
                                                      final ImagePicker picker =
                                                          ImagePicker();
                                                      imageFileOne =
                                                          await picker
                                                              .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        // alternatively, use ImageSource.gallery
                                                        maxWidth: 400,
                                                      );
                                                      if (imageFileOne == null)
                                                        return;
                                                      final String imagePath =
                                                          imageFileOne!.path;
                                                      final String imageName =
                                                          imagePath.substring(
                                                              imagePath
                                                                      .lastIndexOf(
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
                                                        color:
                                                            color.primaryColor),
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
                                                          : imageFileOne!.path,
                                                      lang: LayoutCubit.get(
                                                              context)
                                                          .lang,
                                                      reason:
                                                          reasonController.text,
                                                      id: cubit
                                                          .driverOrderByIdModel!
                                                          .order!
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
          );
        },
      ),
    );
  }
}
