import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/controller/order_driver_cubit/order_driver_cubit.dart';
import 'package:mham/core/components/laoding_animation_component.dart';
import 'package:mham/core/components/snak_bar_component.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/constent/image_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/views/driver/home_screen/widget/top_app_bar.dart';
import 'package:mham/views/driver/time_line_screen/widget/with_no_return.dart';
import 'package:mham/views/driver/time_line_screen/widget/with_return.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var color = Theme.of(context);
    var font = Theme.of(context).textTheme;
    var reasonController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    if(OrderDriverCubit.get(context).timeLineOrderModel == null){
      OrderDriverCubit.get(context).getAssignedOrder(driverId:
      CacheHelper.getData(key:AppConstant.driverId));
    }
    if(OrderDriverCubit.get(context).returnOrderModel == null){
      OrderDriverCubit.get(context).getReturnOrderAssigned(driverId:
      CacheHelper.getData(key:AppConstant.driverId));
    }
    print(OrderDriverCubit.get(context).returnOrderModel);
    return WillPopScope(
      onWillPop: () async {
        Helper.pop(context);
        return true;
      },
      child: BlocConsumer<OrderDriverCubit, OrderDriverState>(
        listener: (context, state) {
          if (state is SuccessCancelOrderDriverState) {
            showMessageResponse(
                message: locale.orderCancelSucess,
                context: context,
                success: true);
          }
          if (state is ErrorCancelOrderDriverState) {
            showMessageResponse(
                message: state.error, context: context, success: false);
          }
          if (state is ErrorUpdateOrderItemState) {
            showMessageResponse(
                message: state.error, context: context, success: false);
          }
        },
        builder: (context, state) {
          var cubit = context.read<OrderDriverCubit>();
          return Scaffold(
            appBar: topAppBar(context),
            body:
            cubit.timeLineOrderModel == null&&
                cubit.returnOrderModel == null?
            Center(child: Text(locale.noOrdersFound))
                :
            cubit.timeLineOrderModel == null && cubit.returnOrderModel == null
                    ? Center(
                        child: BuildImageLoader(assetName: ImageConstant.logo))
                    : RefreshIndicator(
              backgroundColor: color.primaryColor,
              color: color.backgroundColor,
              onRefresh: () async{
                cubit.getAssignedOrder(driverId: CacheHelper.getData(key:
                AppConstant.driverId));
              },
                      child:
                      cubit.returnOrderModel!=null?
                      buildWithReturn(cubit, locale, font,
                          color, formKey, reasonController, context)
                          :
                      buildWithNoReturn(cubit, locale,
                          font, color, formKey, reasonController, context),
                    ),
          );
        },
      ),
    );
  }

}
