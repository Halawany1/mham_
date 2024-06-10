import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/driver/go_link_row_component.dart';
import 'package:mham/core/helper/helper.dart';


class BuildOrderDetailsReturnTimeLine extends StatelessWidget {
  const BuildOrderDetailsReturnTimeLine({
    super.key,
    required this.lenght,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
  });

  final double totalPrice;
  final String createdAt;
  final String status;
  final int lenght;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var cubit = OrderDriverCubit.get(context);
    final locale = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: color.backgroundColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: Padding(
        padding: EdgeInsets.all(12.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  Helper.formatDate(createdAt),
                  style: font.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  status,
                  style: font.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 4.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                if(cubit.returnOrderModel!=null||cubit.returnOrderModel!=null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'Customer Name',
                        style: font.bodyMedium!
                            .copyWith(fontSize: 12.sp,
                            color: color.primaryColor.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        cubit.returnOrderModel!.activeOrder!.customer!.userName!,
                        style: font.bodyMedium!.copyWith(
                          fontSize: 13.sp,

                        ),
                      ),
                      Container(
                        width: 220.w,
                        height: 1.h,
                        color: color.primaryColor.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      BuildGoToLinkRow(
                        assign: true,
                        link: cubit
                            .returnOrderModel!
                            .activeOrder!
                            .location!,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 220.w,
                        height: 1.h,
                        color: color.primaryColor.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Phone Number',
                        style: font.bodyMedium!
                            .copyWith(fontSize: 12.sp,
                            color: color.primaryColor.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        cubit.returnOrderModel!.activeOrder!.customer!.mobile!,
                        style: font.bodyMedium!.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 220.w,
                        height: 1.h,
                        color: color.primaryColor.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        'Address',
                        style: font.bodyMedium!
                            .copyWith(fontSize: 12.sp,
                            color: color.primaryColor.withOpacity(0.5)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        cubit.returnOrderModel!.activeOrder!.address??'',
                        style: font.bodyMedium!.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),


                      if ( cubit.returnOrderModel!.activeOrder!.status=='Delivered'
                          || cubit.returnOrderModel!.activeOrder!.status=='Shipped' )
                        Container(
                          width: 220.w,
                          height: 1.h,
                          color: color.primaryColor.withOpacity(0.2),
                        ),
                      if ( cubit.returnOrderModel!.activeOrder!.status=='Delivered'
                          || cubit.returnOrderModel!.activeOrder!.status=='Shipped' )
                        SizedBox(
                          height: 8.h,
                        ),
                      if ( cubit.returnOrderModel!.activeOrder!.status=='Delivered'
                          || cubit.returnOrderModel!.activeOrder!.status=='Shipped' )
                        BuildGoToLinkRow(link:
                        'cubit.returnOrderModel!.activeOrder!.location!' ,),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: 220.w,
                        height: 1.h,
                        color: color.primaryColor.withOpacity(0.2),
                      ),
                      if(cubit.returnOrderModel!=null)
                        Column(children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            locale.orderIsReturn,
                            style: font.bodyMedium!.copyWith(
                                fontSize: 13.sp,
                                color: color.backgroundColor
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            width: 220.w,
                            height: 1.h,
                            color: color.primaryColor.withOpacity(0.2),
                          ),
                        ],)
                    ],),

                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(
                      locale.quantity,
                      style: font.bodyMedium!.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 25.w,
                      height: 25.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: color.primaryColor),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        lenght.toString(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  children: [
                    Text(
                      locale.totalCost,
                      style: font.bodyMedium!.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        totalPrice.toStringAsFixed(2) + ' ${locale.kd}',
                        style: font.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: color.backgroundColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
