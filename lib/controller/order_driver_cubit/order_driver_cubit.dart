import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/check_box_tile_model.dart';
import 'package:mham/models/driver_order_model.dart';
import 'package:mham/models/order_by_id.dart';

part 'order_driver_state.dart';

class OrderDriverCubit extends Cubit<OrderDriverState> {
  OrderDriverCubit() : super(OrderDriverInitial());
  static OrderDriverCubit get(context) => BlocProvider.of(context);

  List<CheckboxListTileModel> checkboxListTiles = [
    CheckboxListTileModel(value: true, title: 'Ordered'),
    CheckboxListTileModel(value: false, title: 'Processing'),
    CheckboxListTileModel(value: false, title: 'Shipped'),
    CheckboxListTileModel(value: false, title: 'Delivered'),
  ];

  void changeCheckboxListTile({required int index,required bool value}) {
    checkboxListTiles.forEach((element) {
      element.value=false;
    });
    checkboxListTiles[index].value=value;
    emit(ChangeCheckBoxListTileState());
  }


  bool openAndCloseDetailsContainer = false;

  void openAndCloseDetailsProduct() {
    openAndCloseDetailsContainer = !openAndCloseDetailsContainer;
    emit(ChangeProductDetailsContainerState());
  }


  DriverOrderModel? driverOrderModel;

  void getAllOrders() async {
    if (await Helper.hasConnection()) {
      emit(LoadingGetAllOrdersState());
      DioHelper.getData(
        url:  ApiConstant.orderDriver,
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {

        driverOrderModel = DriverOrderModel.fromJson(value.data);
        // orderModel!.orders!.forEach((element) {
        //   allOrders.add(element);
        // });
        // orderModel!.orders!.forEach((element) {
        //   if (element.status == 'Delivered') {
        //     recentPurchases.add(element);
        //   }
        // });
        // recentPurchases.forEach((element) {
        //   bool flag = false;
        //   element.orderItems!.forEach((element) {
        //     if (!element.returnProduct!.isEmpty) {
        //       flag = true;
        //     }
        //   });
        //   if (!flag) {
        //     returnsOrder.add(element);
        //   }
        // });
        emit(SuccessGetAllOrdersState());
      }).catchError((error) {
        print(error.toString());
        if(error is DioError){
          print(error.response!.data);
        }
        emit(ErrorGetAllOrdersState(error.toString()));
      });
    } else {
      emit(NoInternetHomeState());
    }
  }
  DriverOrderByIdModel ?driverOrderByIdModel;
  void getOrderById({required int id}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingGetOrderByIdState());
      DioHelper.getData(
        url:  ApiConstant.orderDriver+'/$id',
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        driverOrderByIdModel =
            DriverOrderByIdModel.fromJson(value.data);
        // orderModel!.orders!.forEach((element) {
        //   allOrders.add(element);
        // });
        // orderModel!.orders!.forEach((element) {
        //   if (element.status == 'Delivered') {
        //     recentPurchases.add(element);
        //   }
        // });
        // recentPurchases.forEach((element) {
        //   bool flag = false;
        //   element.orderItems!.forEach((element) {
        //     if (!element.returnProduct!.isEmpty) {
        //       flag = true;
        //     }
        //   });
        //   if (!flag) {
        //     returnsOrder.add(element);
        //   }
        // });
        emit(SuccessGetOrderByIdState());
      }).catchError((error) {
        emit(ErrorGetOrderByIdState(error.toString()));
      });
    } else {
      emit(NoInternetHomeState());
    }
  }

  void cancelOrder({required int id,required String reason}) async {
    print(id);
    if (await Helper.hasConnection()) {
      emit(LoadingCancelOrderDriverState());
      DioHelper.patchData(
        data: {
          "cancelReason":reason
        },
        url:  ApiConstant.cancelOrderDriver(id),
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        emit(SuccessCancelOrderDriverState());
        getOrderById(id: id);
      }).catchError((error) {
        if(error is DioError){
          print(error.response!.data);
          emit(ErrorCancelOrderDriverState(error.response!
              .data['message'][0]));
        }else{
          emit(ErrorCancelOrderDriverState(error.toString()));
        }

      });
    } else {
      emit(NoInternetHomeState());
    }
  }

}
enum ProductStatus{ordered,processing,shipped,delivered}