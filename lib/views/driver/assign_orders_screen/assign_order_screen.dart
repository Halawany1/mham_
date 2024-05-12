import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/driver/card_order_gird_component.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:mham/views/driver/order_details_screen/order_details_screen.dart';

class AssignOrdersDriverScreen extends StatelessWidget {
  const AssignOrdersDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    var layoutCubit = LayoutCubit.get(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BuildTopAppBarInDriver(hideHello: true,),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Assigned Orders',
                      style: font.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        showMenu<String>(
                          context: context,
                          position: RelativeRect.fromLTRB(
                              layoutCubit.lang == 'en' ? 120.w : 30.w,
                              170.h,
                              layoutCubit.lang == 'en' ? 30.w : 120.w,
                              0),
                          elevation: 5,
                          color: color.scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          items: [],
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.filter,
                        color: color.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.h),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        mainAxisExtent: 220.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async{
                          Helper.push(context:
                          context,widget: OrderDetailsDriverScreen(index: index,));
                          // if(await canLaunchUrl(Uri.parse('https://maps.app.goo.gl/LCUHzLvmpePdVXmB9'))){
                          //   launchUrl(Uri.parse('https://maps.app.goo.gl/LCUHzLvmpePdVXmB9'));
                          // }
                        },
                        child: BuildCardOrderGrid( index: index),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

}
