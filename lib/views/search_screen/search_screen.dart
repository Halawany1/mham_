import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/home_screen/widget/products_not_found.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var color = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();

        return WillPopScope(
          onWillPop: () async{
            Helper.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Helper.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: color.primaryColor)),
              backgroundColor: color.scaffoldBackgroundColor,
              title: BuildSearchFormField(
                onSave: (value) {
                  cubit.allProducts.clear();
                  cubit.getAllProduct(lang: 'en',
                  search: value
                  );

                },
              ),
            ),
            body: Padding(
              padding:  EdgeInsets.all(20.h),
              child:cubit.allProducts.isEmpty?
              Center(child: BuildNotFoundProduct())
              :GridView.builder(
                shrinkWrap: true,
                physics:  BouncingScrollPhysics(),
                itemCount: cubit.allProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 4.w,
                    mainAxisExtent: 230.h),
                itemBuilder: (context, index) =>
                    BuildProductCard(
                      isOffer: cubit.allProducts[index].isOffer!,
                      offerPrice: cubit.allProducts[index].offerPrice,
                      description: cubit
                          .allProducts[index].businessCategory!
                          .bcNameEn!,
                      type: cubit.allProducts[index].type!,
                      rate: double.parse(
                          cubit.allProducts[index].rating.toString()),
                      review: cubit.allProducts[index].reviewCount,
                      price: cubit.allProducts[index].price!,
                      title: cubit.allProducts[index].productsName!,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
