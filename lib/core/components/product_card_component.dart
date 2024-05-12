import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/color_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/checkout_screen/checkout_screen.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';

class BuildProductCard extends StatelessWidget {
  const BuildProductCard({
    super.key,
    required this.title,
     this.price=null,
    required this.rate,
    required this.review,
    required this.type,
    required this.description,
    required this.offerPrice,
    required this.isOffer,
    required this.inCart,
    required this.inFavorite,
    required this.id,
  });

  final dynamic price;
  final String title;
  final double rate;
  final dynamic review;
  final String type;
  final String description;
  final dynamic offerPrice;
  final bool isOffer;
  final bool inCart;
  final bool inFavorite;
  final int id;

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return Card(
      elevation: 4,
      color:LayoutCubit.get(context).theme?
      color.scaffoldBackgroundColor:color.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Container(
        height: 220.h,
        width: 155.w,
        decoration: BoxDecoration(
          color: LayoutCubit.get(context).theme?
          color.scaffoldBackgroundColor
          :color.cardColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                    fit: BoxFit.cover,
                    width: 155.w,
                    height: 84.h,
                    'assets/images/product.png')),

            Positioned(
                top: 10.h,
                right: 8.w,
                child: InkWell(
                  onTap: () {
                    if(CacheHelper.getData(key: AppConstant.token)==null){
                      Helper.push(context: context,widget: GetStartScreen());
                    }else{
                      HomeCubit.get(context).addAndRemoveFavorite(
                          busniessId:
                          CacheHelper.getData(key: AppConstant.businessId),
                          id: id);
                    }

                  },
                  child: Icon(
                   inFavorite?
                   FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,
                    color:inFavorite?
                    Colors.red:ColorConstant.brown,
                  ),
                )),
            Positioned(
              top: 10.h,
              left: 8.w,
              child: BuildContainerType(
                type: type,
              )
            ),
            Positioned(
              top: 90.h,
              left: 8.w,
              right: Helper.isArabic(title)? 8.w : null,
              child: SizedBox(
                width: 90.w,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: font.bodyMedium!.copyWith(fontSize: 15.sp),
                ),
              ),
            ),
            Positioned(
              top: 108.h,
              left: 8.w,
              right: 5.w,
              child: SizedBox(
                width: 140.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  description,
                  style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                ),
              ),
            ),
            Positioned(
              top: 125.h,
              left: 8.w,
              child: Text(
                '($review ${locale.reviews})',
                style: font.bodyMedium!.copyWith(fontSize: 9.5.sp),
              ),
            ),
            if(isOffer)
              Positioned(
              top: 142.h,
              left: 8.w,
              child: Text(
                price.toString()+' ${locale.kd}',
                style: font.bodyMedium!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: color.backgroundColor.withOpacity(0.5),
                    fontSize: 12.sp, color:color.backgroundColor.withOpacity(0.5)),
              ),
            ),
            Positioned(
              top: isOffer?158.h:145.h,
              left: 8.w,
              right: 5.w,
              child: Text(
                isOffer?
                offerPrice.toString()+' ${locale.kd}':
                price.toString()+ ' ${locale.kd}',
                style: font.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: color.backgroundColor),
              ),
            ),
            Positioned(
              top: !isOffer?170.h:175.h,
              left: 8.w,
              child: RatingBar.builder(
                ignoreGestures: true,
                initialRating: rate,
                minRating: rate,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                maxRating: rate,
                unratedColor: color.highlightColor.withOpacity(0.8),
                itemSize: 12.sp,
                itemBuilder: (context, _) =>
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (value) {},
                tapOnlyMode: true,
              ),
            ),
            Positioned(
              top: 192.h,
              left: 18.5.w,
              child:  BuildDefaultButton(
                colorText: ColorConstant.brown,
                backgorundColor:inCart?
                    Colors.grey:color.backgroundColor,
                height: 17.h,
                fontSize: 10.sp,
                text: inCart?
                locale.addedToCart: locale.addToCart,
                width: 100.w,
                onPressed: () {
                  if(!inCart){
                    if(CacheHelper.getData(key: AppConstant.token)==null){
                      Helper.push(context: context,widget: GetStartScreen());
                    }else{
                      CartCubit.get(context).addToCart(token: CacheHelper.getData(key: AppConstant.token),
                          id: id, quantity: 1);
                    }

                  }

                },),
            ),

            Positioned(
              top: 222.h,
              left: 18.5.w,
              child:  BuildDefaultButton(
                colorText: color.cardColor,
                backgorundColor:color.primaryColor,
                height: 17.h,
                fontSize: 10.sp,
                text: locale.buyNow,
                width: 100.w,
                onPressed: () {
                  if(CacheHelper.getData(key: AppConstant.token)==null){
                    Helper.push(context: context,widget: GetStartScreen());

                  }else{
                    Helper.push(context: context, widget: CheckoutScreen(
                      totalPrice: double.parse(price.toString()),
                      oneProductName: title,
                      price: double.parse(price.toString()),
                    ),
                      withAnimate: true
                    );
                  }

                },),
            ),
          ],
        ),
      ),
    );
  }
}
