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
  const CheckoutScreen({super.key, this.products});

  final List<CartProducts>? products;

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
                      'Information',
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
                            hint: 'Building number, Floor number, Flat number',
                            title: 'Address Details',
                            controller: addressController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, 'Address Details', context);
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
                            hint: 'Location',
                            title: 'Location',
                            controller: locationController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, 'Location', context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.number,
                            hint: '1145465788',
                            title: 'Mobile Number',
                            controller: mobileController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, 'Mobile Number', context);
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
                                  title: 'First Name',
                                  controller: firstNameController,
                                  validator: (value) {
                                    return Validation.validateField(
                                        value, 'First Name', context);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 120.w,
                                child: BuildFormCheckout(
                                  inputType: TextInputType.text,
                                  hint: 'Ahmed',
                                  title: 'Last Name',
                                  controller: lastNameController,
                                  validator: (value) {
                                    return Validation.validateField(
                                        value, 'Last Name', context);
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
                      'Your Order',
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
                                'Shipment ',
                                style: font.bodyMedium,
                              ),
                              Text(
                                '(${products!.length} item)',
                                style: font.bodyMedium!.copyWith(
                                    color: color.primaryColor.withOpacity(0.5),
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          ListView.builder(
                            itemCount: products!.length,
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
                                          products![index]
                                              .product!
                                              .productsName!,
                                          style: font.bodyMedium!.copyWith(
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        products![index].product!.price!.toString(),
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
                      'Payment',
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
                                'Credit Card',
                                style: font.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Add Your Card',
                            style: font.bodyLarge!.copyWith(fontSize: 19.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.number,
                            widthForm: 136.w,
                            hint: '**** **** **** ****',
                            title: 'Card Number',
                            controller: cardNumberController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, 'Card Number', context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.text,
                            widthForm: 136.w,
                            hint: 'Month  /  Year',
                            title: 'Expiry Date',
                            controller: expiryDateController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, 'Expiry Date', context);
                            },
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          BuildFormCheckout(
                            inputType: TextInputType.number,
                            hint:
                                'Enter the 3 digit code on the back of your card ',
                            title: 'CVV',
                            controller: cvvController,
                            validator: (value) {
                              return Validation.validateField(
                                  value, 'CVV', context);
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
                        lenghtItems: 3,
                        totalPrice: 12213,
                        totalPriceWithShippingFee: 123213),
                    SizedBox(
                      height: 20.h,
                    ),
                    BuildDefaultButton(
                        text: 'Place Order',
                        borderRadius: 10.r,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('3e4sa');
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
