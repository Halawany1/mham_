import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/product_card_component.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/details_product_screen/details_product_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(locale.favorite, style: font.bodyLarge!.copyWith(
              fontSize: 20.sp
            )),
            leading: InkWell(
                onTap: () {
                  Helper.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: color.primaryColor,
                )),
          ),
          body: state is LoadingGetAllProduct
              ? Center(child:
          BuildImageLoader(assetName: ImageConstant.logo))
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         cubit.favoriteProducts.isEmpty?
                             Center(
                               child: Padding(
                                 padding:  EdgeInsets.only(top: 120.h),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                   Image.asset(ImageConstant.noFavourite,
                                     width: 90.w,height: 90.w,),
                                   SizedBox(height: 30.h,),
                                   Text(
                                     textAlign: TextAlign.center,
                                       style: font.bodyMedium!.copyWith(
                                         fontSize: 15.sp,
                                         color: color.primaryColor.withOpacity(0.5)
                                       ),
                                       locale.addingFavourite)
                                 ],),
                               ),
                             )

                             :GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.favoriteProducts.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 4.w,
                                    mainAxisExtent: 258.h),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                cubit.oneProductModel = null;
                                cubit.getProductDetails(
                                    id: cubit
                                        .favoriteProducts[index].productsId!);
                                cubit.increaseReview(cubit
                                    .favoriteProducts[index].productsId!);
                                Helper.push(context: context,widget: DetailsScreen() );
                              },
                              child: BuildProductCard(
                                id: cubit.favoriteProducts[index].productsId!,
                                inCart:
                                    cubit.favoriteProducts[index].inCart ??
                                        false,
                                inFavorite: cubit.favoriteProducts[index]
                                        .inFavourite ??
                                    false,
                                isOffer:
                                    cubit.favoriteProducts[index].isOffer!,
                                offerPrice:
                                    cubit.favoriteProducts[index].offerPrice,
                                description: cubit.favoriteProducts[index]
                                    .businessCategory!.bcNameEn!,
                                type: cubit.favoriteProducts[index].type!,
                                rate: double.parse(cubit
                                    .favoriteProducts[index].averageRate
                                    .toString()),
                                review:
                                    cubit.favoriteProducts[index].reviewCount,
                                price: cubit.favoriteProducts[index].price!,
                                title: cubit
                                    .favoriteProducts[index].productsName!,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
