import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/total_card_price_component.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/cart_screen/widget/card_cart_product.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/cart_screen/widget/cart_empty.dart';
import 'package:mham/views/checkout_screen/checkout_screen.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        return Scaffold(
            bottomSheet: cubit.cartModel != null
                ? cubit.cartModel!.cart!.cartProducts!.isEmpty
                    ? null
                    : Container(
                        padding: EdgeInsets.all(12.h),
                        width: double.infinity,
                        height: 70.h,
                        decoration: BoxDecoration(
                          color: color.cardColor,
                        ),
                        child: BuildDefaultButton(
                            borderRadius: 12.r,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckoutScreen(
                                      totalPrice: cubit.totalPrice,
                                      products:
                                          cubit.cartModel!.cart!.cartProducts!,
                                    ),
                                  ));
                            },
                            text: locale.checkOut,
                            backgorundColor: color.backgroundColor,
                            colorText: ColorConstant.brown),
                      )
                : null,
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                ImageConstant.splash,
                width: 80.w,
                height: 40.h,
              ),
              leading: InkWell(
                  onTap: () {
                    HomeCubit.get(context).getAllProduct();
                    Helper.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: color.primaryColor,
                  )),
            ),
            body: state is CartLoadingState || cubit.cartModel == null
                ? Center(child: BuildImageLoader(assetName: ImageConstant.logo))
                : Padding(
                    padding: EdgeInsets.all(20.h),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(locale.cart),
                              SizedBox(
                                width: 5.w,
                              ),
                              if (cubit.cartModel!.cart!.cartProducts!.length >
                                  0)
                                Text(
                                  '(${cubit.cartModel!.cart!.cartProducts!.length} ${locale.items})',
                                  style: font.bodyMedium!.copyWith(
                                      fontSize: 12.sp,
                                      color:
                                          color.primaryColor.withOpacity(0.5)),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          if (cubit.cartModel!.cart!.cartProducts!.length > 0)
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        HomeCubit.get(context).oneProductModel=null;
                                        HomeCubit.get(context).getProductDetails(
                                            id: cubit
                                                .cartModel!
                                                .cart!
                                                .cartProducts![index]
                                                .product!
                                                .productsId!);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreen(
                                                  ),
                                            ));
                                      },
                                      child: BuildCartCardProduct(
                                        hideRate: true,
                                        index: index,
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 20.h,
                                    ),
                                itemCount: cubit
                                    .cartModel!.cart!.cartProducts!.length),
                          if (cubit.cartModel!.cart!.cartProducts!.length == 0)
                            Padding(
                              padding:
                              EdgeInsets.only(top: 50.h),
                              child: BuildCartEmpty(),
                            ),
                          SizedBox(
                            height: 20.h,
                          ),
                          if (cubit.cartModel!.cart!.cartProducts!.length > 0)
                            BuildTotalCardPrice(
                                lenghtItems:
                                    cubit.cartModel!.cart!.cartProducts!.length,
                                totalPrice: cubit.totalPrice,
                                totalPriceWithShippingFee:
                                    cubit.totalPrice + 10),
                          SizedBox(
                            height: 60.h,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
