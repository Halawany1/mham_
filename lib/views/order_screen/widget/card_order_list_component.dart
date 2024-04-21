import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/components/pop_up_sure_component.dart';
import 'package:mham/core/components/small_button_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/order_screen/order_screen.dart';

class BuildCardOrderList extends StatelessWidget {
  const BuildCardOrderList({
    super.key,
    required this.index,
    required this.totalPrice,
  });

  final int index;
  final double totalPrice;

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
                    Helper.formatDate(cubit.allOrders[index].createdAt!),
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
                          cubit.allOrders[index].status.toString(),
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
                            cubit.allOrders[index].carts!.length.toString(),
                            style: font.bodyMedium!.copyWith(fontSize: 12.sp),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        BuildSmallButton(
                          withIcon: false,
                          edit: false,
                          width: 75.w,
                          hieght: 17.h,
                          text: locale.cancelOrder,
                          onPressed: () {
                          showDialog(context: context,
                              builder: (context) {
                                return confirmPopUp(context: context,
                                    onPress: () {
                                  cubit.cancelOrder(id: cubit.allOrders[index].orderId!);
                                  Navigator.pop(context);
                                    }, title:  locale.cancelOrder,
                                    content:
                                    locale.areYourSureToCancelOrder);
                              },);
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
