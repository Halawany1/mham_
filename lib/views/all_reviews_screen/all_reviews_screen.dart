import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/details_product_screen/widget/card_reviews.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({super.key, required this.productId});
  final int productId;
  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var locale = AppLocalizations.of(context);

    var color = Theme.of(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              locale.allReviews,
              style: font.bodyLarge!.copyWith(
                  fontSize: 20.sp
              ),
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
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter == 0) {
                if(cubit.productRatingModel!.products!.isNotEmpty){
                  cubit.getProductRating(id: productId,page: cubit.currentPage);
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding:  EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                        BuildCardReviews(index: index),
                        separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                        itemCount: cubit.productRating.length),
                    if(state is LoadingGetProductRatingState)
                      SizedBox(height: 20.h,),
                    if(state is LoadingGetProductRatingState)
                      Center(child: CircularProgressIndicator()),
                    if(cubit.productRating.isEmpty)
                      Center(child: Text(locale.noReviews,
                        style: font.bodyMedium,))
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

