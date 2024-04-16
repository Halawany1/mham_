import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/core/components/material_button_component.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  });

  final dynamic price;
  final String title;
  final double rate;
  final dynamic review;
  final String type;
  final String description;
  final dynamic offerPrice;
  final bool isOffer;

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);


    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Container(
        height: 220.h,
        width: 155.w,
        decoration: BoxDecoration(
          color: color.scaffoldBackgroundColor,
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

                  },
                  child: Icon(FontAwesomeIcons.heart,
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
                top: 90.h,
                right: 8.w,
                child: Image.asset(
                    fit: BoxFit.cover,
                    width: 35.w,
                    'assets/images/hundia.png')),
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
                '($review reviews)',
                style: font.bodyMedium!.copyWith(fontSize: 9.5.sp),
              ),
            ),
            if(isOffer)
              Positioned(
              top: 142.h,
              left: 8.w,
              child: Text(
                price.toString()+' KD',
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
                offerPrice.toString()+' KD':
                price.toString()+ ' KD',
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

                itemSize: 12.sp,
                itemBuilder: (context, _) =>
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (value) {

                },
                tapOnlyMode: true,
              ),
            ),
            Positioned(
              top: 192.h,
              left: 16.w,
              child:  BuildDefaultButton(
                colorText: color.primaryColor,
                backgorundColor: color.backgroundColor,
                height: 17.h,
                fontSize: 10.sp,
                text: 'Add To Cart',
                width: 100.w,
                onPressed: () {

                },),
            ),


          ],
        ),
      ),
    );
  }
}
