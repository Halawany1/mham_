import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mham/controller/Authentication_cubit/authentication_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/go_link_row_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/components/text_form_field_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/views/driver/order_details_screen/check_box_list_tile.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';

var reasonController = TextEditingController();
var formKey = GlobalKey<FormState>();
class BuildCardProductDetailsForDriver extends StatelessWidget {
  const BuildCardProductDetailsForDriver({
    super.key,
    required this.opened,
     this.index,
    this.notClosed = false,
  });

  final bool opened;
  final bool notClosed;
  final int ?index;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<OrderDriverCubit, OrderDriverState>(
      builder: (context, state) {
        var cubit = context.read<OrderDriverCubit>();
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: color.backgroundColor),
              borderRadius:notClosed?
              BorderRadius.circular(18.r)
              :BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.openAndCloseDetailsProduct();
                  },
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
                                      type: cubit.driverOrderByIdModel!.order!.orderItems![index!].product!.type!,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 90.w,
                                  child: SizedBox(
                                    width: 140.w,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      cubit.driverOrderByIdModel!.order!
                                          .orderItems![index!].product!.productsName!,
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
                                        cubit.driverOrderByIdModel!
                                            .order!.orderItems![index!].unitPrice!.toString() + ' ${locale.kd}',
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
                                          Border.all(color: color.primaryColor),
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      style: font.bodyMedium!
                                          .copyWith(fontSize: 13.sp),
                                      5.toString(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          if (!notClosed)
                            Icon(
                              !opened
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down_outlined,
                              color: color.backgroundColor,
                            ),
                          if (notClosed)
                            Text(
                              cubit.driverOrderByIdModel!.order!.orderItems![index!].product!.status!,
                              style: font.bodyMedium!.copyWith(
                                color: Colors.green,
                                fontSize: 12.sp
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
                if (opened&&!notClosed)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(),
                      SizedBox(
                        height: 10.h,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.6,
                        ),
                        itemBuilder: (context, i) => BuildCheckBoxListTile(
                          text: cubit.checkboxListTiles[i].title,
                          value: cubit.checkStatus[index!][i],
                          changeValue: (value) {
                            cubit.changeCheckboxListTile(
                              orderId:cubit.driverOrderByIdModel!.order!.id! ,
                              id:
                              cubit.driverOrderByIdModel!.order!.
                              orderItems![this.index!].id!,
                                index: i, value: cubit.checkStatus[index!][i]);
                          },
                        ),
                      ),
                      if (cubit.checkboxListTiles[0].value ||
                          cubit.checkboxListTiles[1].value)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: color.backgroundColor,
                                  radius: 5.r,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Trader Information',
                                  style: font.bodyLarge!.copyWith(
                                      fontSize: 15.sp,
                                      color: color.backgroundColor),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 5.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.driverOrderByIdModel!.order!.customer!.userName!,
                                    style: font.bodyMedium!
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    cubit.driverOrderByIdModel!.order!.customer!.mobile!,
                                    style: font.bodyMedium!
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    cubit.driverOrderByIdModel!.order!.address!,
                                    style: font.bodyMedium!
                                        .copyWith(fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  BuildGoToLinkRow(link: cubit.driverOrderByIdModel!.order!.location! ,),
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
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
