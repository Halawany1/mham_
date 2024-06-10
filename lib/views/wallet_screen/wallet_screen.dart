import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/transiaction_cubit/transiaction_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/get_start_screen/get_start_screen.dart';
import 'package:mham/views/wallet_screen/widget/card_transiaction.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme
        .of(context)
        .textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return BlocBuilder<TransiactionCubit, TransiactionState>(
      builder: (context, state) {
        var cubit = TransiactionCubit.get(context);
        return Scaffold(
          body: CacheHelper.getData(key: AppConstant.token) == null ?
          GetStartScreen() :
          cubit.transiactionModel==null?
          Center(
              child: BuildImageLoader(assetName: ImageConstant.logo))
              :
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(locale.wallet, style: font.bodyLarge!.copyWith(
                        fontSize: 22.sp
                    )),
                    SizedBox(height: 30.h,),
                    Image.asset('assets/images/wallet.png',
                    ),
                    SizedBox(height: 30.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(locale.transactions, style: font.bodyMedium!
                            .copyWith(
                            fontSize: 20.sp
                        ),),
                        Text(locale.refund, style: font.bodyMedium!.copyWith(
                            fontSize: 20.sp,
                            color: color.backgroundColor
                        ),),
                      ],),
                    SizedBox(height: 30.h,),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder:(context, index) =>
                        BuildCardTransiaction(index: index),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cubit.transiactionModel!.transactions!.length)
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
