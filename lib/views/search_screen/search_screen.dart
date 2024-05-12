import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/controller/layout_cubit/layout_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/components/search_form_filed_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';
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
            cubit.getAllProduct();
            Helper.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    cubit.getAllProduct();
                    Helper.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: color.primaryColor)),
              backgroundColor: color.scaffoldBackgroundColor,
              title: BuildSearchFormField(
                width: 250.w,
                onSave: (value) {
                  cubit.allProducts.clear();
                  cubit.getAllProduct(
                  search: value
                  );

                },
              ),
            ),
            body: Padding(
              padding:  EdgeInsets.all(20.h),
              child:
              state is LoadingGetAllProduct?
              Center(child: BuildImageLoader(assetName: ImageConstant.logo)):
              cubit.allProducts.isEmpty?
              Center(child: BuildNotFoundProduct())
              :GridView.builder(
                shrinkWrap: true,
                physics:  BouncingScrollPhysics(),
                itemCount: cubit.allProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 4.w,
                    mainAxisExtent: 258.h),
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () {
                        cubit.oneProductModel=null;
                        cubit.getProductDetails(id:cubit
                            .allProducts[index]
                            .productsId!);
                        cubit.increaseReview(cubit
                            .allProducts[index]
                            .productsId!);
                        Helper.push(context: context,widget:
                        DetailsScreen(
                        ));
                      },
                      child: BuildProductCard(
                        id: cubit.allProducts[index].productsId!,
                        inFavorite: cubit.allProducts[index].inFavourite??false,
                        inCart: cubit.allProducts[index].inCart??false,
                        isOffer: cubit.allProducts[index].isOffer!,
                        offerPrice: cubit.allProducts[index].offerPrice,
                        description: cubit
                            .allProducts[index].businessCategory!
                            .bcNameEn!,
                        type: cubit.allProducts[index].type!,
                        rate: double.parse(
                            cubit.allProducts[index].averageRate.toString()),
                        review: cubit.allProducts[index].reviewCount,
                        price: cubit.allProducts[index].price!,
                        title: cubit.allProducts[index].productsName!,
                      ),
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
