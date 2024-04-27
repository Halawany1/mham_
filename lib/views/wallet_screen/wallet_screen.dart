import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(locale.wallet,style:font.bodyLarge!.copyWith(
                  fontSize: 22.sp
                )),
                SizedBox(height: 30.h,),
                Image.asset('assets/images/wallet.png',
                ),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(locale.transactions,style: font.bodyMedium!.copyWith(
                    fontSize: 20.sp
                  ),),
                  Text(locale.refund,style: font.bodyMedium!.copyWith(
                      fontSize: 20.sp,
                    color: color.backgroundColor
                  ),),
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
