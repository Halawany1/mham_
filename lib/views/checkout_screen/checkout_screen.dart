import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/total_card_price_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/error/validation.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/models/cart_model.dart';
import 'package:mham/views/checkout_screen/widget/forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


var addressController = TextEditingController();
var locationController = TextEditingController();
var mobileController = TextEditingController();
var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var cardNumberController = TextEditingController();
var expiryDateController = TextEditingController();
var cvvController = TextEditingController();
var formKey = GlobalKey<FormState>();

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, this.products,this.oneProductName,
    this.price,
    required this.totalPrice
  });

  final List<CartProducts>? products;
  final String ?oneProductName;
  final double ?price;
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    void clearAllData() {
      addressController.clear();
      locationController.clear();
      mobileController.clear();
      firstNameController.clear();
      lastNameController.clear();
      cardNumberController.clear();
      expiryDateController.clear();
      cvvController.clear();
    }

    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: () async {
        if(products!=null){
          Navigator.pop(context);
        }else{
          Helper.pop(context);
        }

        clearAllData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            ImageConstant.splash,
            width: 80.w,
            height: 40.h,
          ),
          leading: InkWell(
              onTap: () {
                clearAllData();
                if(products!=null){
                  Navigator.pop(context);
                }else{
                  Helper.pop(context);
                }
              },
              child: Icon(
                Icons.arrow_back,
                color: color.primaryColor,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale.info,
                      style: font.bodyLarge!.copyWith(fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: color.primaryColor.withOpacity(0.1),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildFormCheckout(
                            inputType: TextInputType.text,
                            hint: locale.hintAddress,
                            title: locale.addressDetails,
                            controller: addressController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.addressDetails, context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.text,
                            suffixIcon: Icon(
                              Icons.location_on_sharp,
                              color: color.primaryColor,
                            ),
                            hint: locale.location,
                            title: locale.location,
                            controller: locationController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.location, context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.number,
                            hint: '1145465788',
                            title: locale.mobile,
                            controller: mobileController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.mobile, context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: BuildFormCheckout(
                                  inputType: TextInputType.text,
                                  hint: 'Akram',
                                  title:locale.firstName,
                                  controller: firstNameController,
                                  validator: (value) {
                                    return Validation.validateField(
                                        value, locale.firstName, context);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 120.w,
                                child: BuildFormCheckout(
                                  inputType: TextInputType.text,
                                  hint: 'Ahmed',
                                  title: locale.lastName,
                                  controller: lastNameController,
                                  validator: (value) {
                                    return Validation.validateField(
                                        value, locale.lastName, context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      locale.yourOrder,
                      style: font.bodyLarge!.copyWith(fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: color.primaryColor.withOpacity(0.1),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                 locale.shipment,
                                style: font.bodyMedium,
                              ),
                              Text(
                                '(${ products!=null?products!.length:1} ${locale.items})',
                                style: font.bodyMedium!.copyWith(
                                    color: color.primaryColor.withOpacity(0.5),
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: products!=null?
                            products!.length:1,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Image.asset(
                                    'assets/images/product.png',
                                    width: 80.h,
                                    height: 80.h,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          products!=null?
                                          products![index]
                                              .product!
                                              .productsName!:oneProductName!,
                                          style: font.bodyMedium!.copyWith(
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        products!=null?
                                        products![index].product!.price!.
                                        toString():price.toString()+' '+locale.kd,
                                        style: font.bodyMedium!.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                ColorConstant.backgroundAuth),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      locale.payment,
                      style: font.bodyLarge!.copyWith(fontSize: 22.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: color.primaryColor.withOpacity(0.1),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(ImageConstant.creditCard),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                locale.credit,
                                style: font.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            locale.addYourCard,
                            style: font.bodyLarge!.copyWith(fontSize: 19.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.number,
                            widthForm: 136.w,
                            hint: '**** **** **** ****',
                            title: locale.cardNumber,
                            controller: cardNumberController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.cardNumber, context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.text,
                            widthForm: 136.w,
                            hint: locale.monthAndYear,
                            title: locale.expiryDate,
                            controller: expiryDateController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.expiryDate, context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.number,
                            hint:
                                locale.enterThreeDigitCode,
                            title: locale.cvv,
                            controller: cvvController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, locale.cvv, context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    BuildTotalCardPrice(
                        lenghtItems:products!=null?
                        products!.length:1,
                        totalPrice: totalPrice,
                        totalPriceWithShippingFee: totalPrice+10),
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildDefaultButton(
                        text: locale.placeOrder,
                        borderRadius: 10.r,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                          }
                        },
                        backgorundColor: color.backgroundColor,
                        colorText: ColorConstant.brown),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
