import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';

class BuildCartCardProduct extends StatelessWidget {
  const BuildCartCardProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font= Theme.of(context).textTheme;
    return  Card(
      elevation: 4,
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: color.scaffoldBackgroundColor
        ),
        width: double.infinity,
        height: 100.h,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset('assets/images/product.png',
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5.h,
              left: 5.w,
              child: SizedBox(
                  width: 60.w,
                  height: 16.h,
                  child: BuildContainerType(
                      type: 'original')),
            ),
            Positioned(
              top: 4.h,
              left: 110.w,
              child: SizedBox(
                width: 140.w,
                child: Text('Fit Rear Brake Shoe',
                  overflow: TextOverflow.ellipsis,
                  style:font.bodyMedium!.copyWith(
                      fontSize: 13.sp
                  ) ,),
              ),
            ),
            Positioned(
              top: 20.h,
              left: 110.w,
              child: Text(
                '324'+' KD',
                style: font.bodyMedium!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: color.backgroundColor.withOpacity(0.5),
                    fontSize: 12.sp, color:color.backgroundColor.withOpacity(0.5)),
              ),
            ),
            Positioned(
              top: 35.h,
              left: 110.w,
              child: Text(
                '3245'+ ' KD',
                style: font.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: color.backgroundColor),
              ),
            ),
            Positioned(
              top: 54.h,
              left: 110.w,
              child: RatingBar.builder(
                ignoreGestures: true,
                initialRating:4,
                minRating: 4,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                maxRating: 4,
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
              top: 50.h,
              right: 12.w,
              child: Row(children: [
                InkWell(
                    onTap:() {

                    } ,
                    child: Icon(FontAwesomeIcons.minus)),
                SizedBox(width: 5.w,),
                Container(
                  alignment: Alignment.center,
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: color.hintColor),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                  '3',
                    style: font.bodyMedium!.copyWith(
                        fontSize: 12.sp
                    ),
                  ),
                ),
                SizedBox(width: 5.w,),
                InkWell(
                    onTap: () {

                    },
                    child: Icon(FontAwesomeIcons.add)),

              ],),
            ),
            Positioned(
                top: 4.h,
                right: 5.w,
                child: Image.asset('assets/images/hundia.png',)),

            Positioned(
              top: 65.h,
              right: 5.w,
              child: Row(children: [
                BuildSmallButton(text: 'remove',
                  icon: FontAwesomeIcons.trash,
                  withIcon: true,
                  width: 70.w,
                  edit: false,
                  onPressed: () {

                  },),
                SizedBox(width: 12.w,),
                BuildSmallButton(text: 'More Details',
                  width: 70.w,
                  withIcon: false,
                  onPressed: () {

                  },)
              ],),
            )
          ],
        ),

      ),
    );
  }
}
