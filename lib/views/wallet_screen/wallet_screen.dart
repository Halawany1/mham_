import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:mham/views/wallet_screen/widget/refunds.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    if (TransiactionCubit.get(context).transiactionModel == null) {
      TransiactionCubit.get(context).getTransiaction();
    }
    if (TransiactionCubit.get(context).refundsModel == null) {
      TransiactionCubit.get(context).getRefunds();
    }
    return BlocBuilder<TransiactionCubit, TransiactionState>(
      builder: (context, state) {
        var cubit = TransiactionCubit.get(context);
        return Scaffold(
          body: CacheHelper.getData(key: AppConstant.token, token: true) == null
              ? GetStartScreen()
              : cubit.transiactionModel == null || cubit.walletModel == null
          ||cubit.refundsModel==null
                  ? Center(
                      child: BuildImageLoader(assetName: ImageConstant.logo))
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(locale.wallet,
                                    style: font.bodyLarge!
                                        .copyWith(fontSize: 22.sp)),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/wallet.png',
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: 8.h,
                                      left: 20.w,
                                      child: Text(
                                        'Available Balance',
                                        style: font.bodyMedium!.copyWith(
                                            color: color.cardColor
                                                .withOpacity(0.6)),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30.h,
                                      left: 20.w,
                                      child: Text(
                                        cubit.walletModel!.wallet!.balance!
                                                .toString() +
                                            ' ' +
                                            locale.kd,
                                        style: font.bodyMedium!
                                            .copyWith(color: color.cardColor),
                                      ),
                                    ),
                                    Positioned(
                                      top: 60.h,
                                      left: 20.w,
                                      child: Text(
                                        cubit.walletModel!.wallet!.user!
                                            .userName!,
                                        style: font.bodyMedium!
                                            .copyWith(color: color.cardColor),
                                      ),
                                    ),
                                    Positioned(
                                      top: 95.h,
                                      left: 20.w,
                                      child: Text(
                                        'For any questions',
                                        style: font.bodyMedium!.copyWith(
                                            color: color.cardColor,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Positioned(
                                      top: 106.h,
                                      left: 20.w,
                                      child: Text(
                                        '+0096550538386',
                                        style: font.bodyMedium!.copyWith(
                                            color: color.cardColor,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                    Positioned(
                                        top: 90.h,
                                        right: 20.w,
                                        child: Image.asset(
                                          ImageConstant.logo,
                                          width: 30.w,
                                          height: 30.w,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.changeRefund(false);
                                      },
                                      child: Text(
                                        locale.transactions,
                                        style: font.bodyMedium!
                                            .copyWith(fontSize: 20.sp),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        cubit.changeRefund(true);
                                      },
                                      child: Text(
                                        locale.refund,
                                        style: font.bodyMedium!.copyWith(
                                            fontSize: 20.sp,
                                            color: color.backgroundColor),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                if (!cubit.refund)
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          BuildCardTransiaction(index: index),
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount: cubit.transiactionModel!
                                          .transactions!.length),
                                if (cubit.refund)
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          BuildCardRefunds(index: index),
                                      separatorBuilder: (context, index) =>
                                          Divider(),
                                      itemCount: cubit.refundsModel!
                                          .refunds!.length)
                              ],
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
