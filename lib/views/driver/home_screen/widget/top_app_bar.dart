import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/notification_screen/notification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class BuildTopAppBarInDriver extends StatelessWidget {
  const BuildTopAppBarInDriver({super.key,this.hideHello=false});
  final bool hideHello;

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var locale = AppLocalizations.of(context);
    return  Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color:LayoutCubit.get(context).theme?null:color.backgroundColor ,
          gradient:LayoutCubit.get(context).theme?
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(235, 170, 43, 1), // 100% opacity
              Color.fromRGBO(235, 170, 43, 0.08), // 8% opacity
            ],
            stops: [0.0, 1.0],
          ):null,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
          )
      ),
      child: Stack(
        children: [
          if(!hideHello)
          Positioned(
            top: 8.h,
            left: 18.w,
            right: 18.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${locale.hi}, Yousef',style: font.bodyLarge!.copyWith(
                        fontSize: 15.sp
                    ),),
                    Text(locale.niceToSeeYouAgain,style: font.bodySmall,),
                  ],
                ),
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: color.cardColor,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: Image.network('https://t3.ftcdn.net/jpg/03/02/88/46/360_F_302884605_actpipOdPOQHDTnFtp4zg4RtlWzhOASp.jpg',
                      fit: BoxFit.cover,
                      width: 35.w,
                      height: 35  .h,
                      isAntiAlias: true,

                    ),
                  ),
                )
              ],),
          ),
          Positioned(
            top: 65.h,
            left: 20.w,
            right: 20.w,
            child: Row(

              children: [
                SizedBox(
                  width: 285.w,
                  child: TextFormField(
                    style: font.bodyMedium!.copyWith(
                        fontSize: 12.sp
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide.none
                      ),
                      hintText: locale.search,
                      fillColor: color.cardColor,
                      filled: true,
                      prefixIcon: Icon(Icons.search),

                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                GestureDetector(
                    onTap: () {
                      Helper.push(context: context,widget: NotificationScreen(),withAnimate: true);
                    },
                    child: Icon(FontAwesomeIcons.bell, size: 22.r,color: color.primaryColor,)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
