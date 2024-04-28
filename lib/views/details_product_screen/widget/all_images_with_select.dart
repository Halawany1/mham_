import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';

class BuildImageWithSelectImages extends StatelessWidget {
  const BuildImageWithSelectImages({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var cubit = HomeCubit.get(context);
    return Column(
      children: [
        Card(
          elevation: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/product.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 210.h,
                ),
                Positioned(
                    top: 10.h,
                    left: 8.w,
                    child: BuildContainerType(
                      type: cubit.oneProductModel!
                          .product!.type!,
                    )),
                Positioned(
                  bottom: 10.h,
                  right: 8.w,
                  child: Image.asset(
                    'assets/images/hundia.png',
                    width: 50.w,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 90.w,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  Container(
                    decoration: index == 0
                        ? BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(
                            10.r),
                        border: Border.all(
                            color: color
                                .backgroundColor,
                            width: 2.w))
                        : null,
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10.r),
                      child: Image.asset(
                        'assets/images/product.png',
                        fit: BoxFit.cover,
                        width: 90.w,
                        height: 90.w,
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) =>
                  SizedBox(
                    width: 8.w,
                  ),
              itemCount: 5),
        ),
      ],
    );
  }
}

