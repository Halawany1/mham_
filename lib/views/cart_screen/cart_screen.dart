import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/cart_cubit/cart_cubit.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/cart_screen/widget/card_cart_product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
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
                    Helper.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: color.primaryColor,
                  )),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Cart'),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemBuilder: (context, index) => BuildCartCardProduct(),
                        separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                        itemCount: 10)
                  ],
                ),
              ),
            ));
      },
    );
  }
}
