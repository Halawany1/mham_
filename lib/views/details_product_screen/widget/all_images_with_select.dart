import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/small_container_for_type_component.dart';
import 'package:mham/core/constent/app_constant.dart';

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
          color: color.cardColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Stack(
              children: [
                if(cubit.oneProductModel!
                    .product!.image==null)
                Image.asset(
                  'assets/images/product.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 210.h,
                ),
                if(cubit.oneProductModel!
                    .product!.image!=null)
                  Image.network(
                    AppConstant.baseImage+cubit.oneProductModel!
                        .product!.image!,
                    fit: BoxFit.fill,
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

              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

