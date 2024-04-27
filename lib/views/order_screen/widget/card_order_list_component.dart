import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/pop_up_sure_component.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/order_details_screen/order_details_screen.dart';
import 'package:mham/views/order_screen/order_screen.dart';
import 'package:mham/views/recent_purchases_screen/widget/return_order_popup.dart';

class BuildCardOrderList extends StatelessWidget {
  const BuildCardOrderList({
    super.key,
    required this.index,
    required this.totalPrice,
    required this.quantity,
    required this.orderId,
    required this.createdAt,
    required this.status,
    required this.returns,
     this.returnOrder=false,
  });

  final int index;
  final double totalPrice;
  final String createdAt;
  final String status;
  final int orderId;
  final int quantity;
  final bool returnOrder;
  final List<Map<String, dynamic>> returns;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var cubit = context.read<HomeCubit>();
    final locale = AppLocalizations.of(context);
    return Card(
      elevation: 4,
      color: color.scaffoldBackgroundColor,
      child: Container(
        height: 103.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color.cardColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 38.r,
                backgroundColor: color.backgroundColor,
                child: Text(
                  '${index + 1}',
                  style: font.bodyMedium,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Helper.formatDate(createdAt),
                    overflow: TextOverflow.ellipsis,
                    style: font.bodyMedium!.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    totalPrice.toStringAsFixed(2) + ' ${locale.kd}',
                    style: font.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: color.backgroundColor),
                  ),
                  SizedBox(
                    width: 195.w,
                    child: Row(
                      children: [
                        Text(
                         status.toString(),
                          style: font.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: Colors.green),
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          width: 22.w,
                          height: 22.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: color.primaryColor),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            quantity.toString(),
                            style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                          ),
                        ),
                          SizedBox(
                          width: 10.w,
                        ),
                          BuildSmallButton(
                          withIcon: false,
                          width: 75.w,
                          hieght: 17.h,
                          text: locale.moreDetails,
                          onPressed: () {
                            Helper.push(
                                context,
                                OrderDetailsScreen(
                                  returns: returns,
                                  currentIndex: index,
                                  totalPrice: totalPrice,
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
