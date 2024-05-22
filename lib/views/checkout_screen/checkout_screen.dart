import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/components/total_card_price_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/layout/layout_screen.dart';
import 'package:mham/models/cart_model.dart';
import 'package:mham/views/checkout_screen/widget/credit_card_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/checkout_screen/widget/info_card.dart';
import 'package:mham/views/driver/home_screen/widget/quantity_container.dart';


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
  const CheckoutScreen({super.key, this.products, this.oneProductName,
    this.price,
    this.productsId,
    this.oneProduct=false,
    required this.totalPrice
  });

  final List<CartProducts>? products;
  final String ?oneProductName;
  final double ?price;
  final double totalPrice;
  final int? productsId;
  final bool oneProduct;

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

    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        clearAllData();
        return true;
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is SuccessCreateOrderState){
            clearAllData();
            Helper.pushReplacement(context: context, widget:
            LayoutScreen());
          }
          if(state is ErrorCreateOrderState){
            showMessageResponse(message: state.error,
                context: context, success: false);
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
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
                    Navigator.pop(context);
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
                        BuildInformationCard(),
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
                                    '(${ products != null
                                        ? products!.length
                                        : 1} ${locale.items})',
                                    style: font.bodyMedium!.copyWith(
                                        color: color.primaryColor.withOpacity(
                                            0.5),
                                        fontSize: 12.sp),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                itemCount: products != null ?
                                products!.length : 1,
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
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150.w,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              products != null
                                                  ?
                                              products![index]
                                                  .product!
                                                  .productsName!
                                                  : oneProductName!,
                                              style: font.bodyMedium!.copyWith(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                products != null ?
                                                products![index].product!.price!.
                                                toString()+' '+ locale.kd :
                                                price.toString() +
                                                    ' ' + locale.kd,
                                                style: font.bodyMedium!.copyWith(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                    ColorConstant.backgroundAuth),
                                              ),
                                              SizedBox(width: 20.w,),
                                              BuildQuantityContainer(
                                                  quantity: products != null
                                                      ?
                                                  products![index]
                                                      .quantity!:1)
                                            ],
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
                        // Text(
                        //   locale.payment,
                        //   style: font.bodyLarge!.copyWith(fontSize: 22.sp),
                        // ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),

                        // BuildCreditCardInformation(),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                        BuildTotalCardPrice(
                            lenghtItems: products != null ?
                            products!.length : 1,
                            totalPrice: totalPrice,
                            totalPriceWithShippingFee: totalPrice + 10),
                        SizedBox(
                          height: 20.h,
                        ),
                       state is LoadingCreateOrderState?
                        Center(child: CircularProgressIndicator(color: color.primaryColor,))
                        :BuildDefaultButton(
                            text: locale.placeOrder,
                            borderRadius: 10.r,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if(!oneProduct){
                                  cubit.createOrder(
                                    address: addressController.text,
                                    anotherMobile: mobileController.text,
                                    location: locationController.text,
                                  );
                                }else{
                                  cubit.createOrderForOneProduct(
                                      address: addressController.text,
                                      anotherMobile: mobileController.text,
                                      location: locationController.text,
                                      id: productsId!);
                                }
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
          );
        },
      ),
    );
  }
}
