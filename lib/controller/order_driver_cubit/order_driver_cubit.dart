import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/assign_order_model.dart';
import 'package:mham/models/check_box_tile_model.dart';
import 'package:mham/models/driver_order_model.dart';
import 'package:mham/models/order_by_id.dart';
import 'package:mham/models/time_line_order_model.dart';

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

  void changeCheckboxListTile(
      {required int index, required int id, required bool value}) {

    if (index == 0) {
      updateOrderItemStatus(id: id, status: "Ordered");
    } else if (index == 1) {
      updateOrderItemStatus(id: id, status: "Processing");
    } else if (index == 2) {
      updateOrderItemStatus(id: id, status: "Shipped");
    } else if(index==3) {
      updateOrderItemStatus(id: id, status: "Delivered");
    }

    emit(ChangeCheckBoxListTileState());
  }

  bool openAndCloseDetailsContainer = false;

  void openAndCloseDetailsProduct() {
    openAndCloseDetailsContainer = !openAndCloseDetailsContainer;
    emit(ChangeProductDetailsContainerState());
  }

  DriverOrderModel? driverOrderModel;
  List<Orders> driverOrders = [];
  List<Orders> historyOrders = [];

  void getAllOrders({String? status, String? sort, bool? inCountry}) async {
    driverOrders.clear();
    historyOrders.clear();
    if (await Helper.hasConnection()) {
      emit(LoadingGetAllOrdersState());
      print(sort);
      DioHelper.getData(
        url: ApiConstant.orderDriver,
        query: {
          if (status != null) "status": status,
          if (inCountry != null) "inCountry": inCountry,
          if (sort != null) "sort": sort,
        },
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        driverOrders.clear();
        historyOrders.clear();
        driverOrderModel = DriverOrderModel.fromJson(value.data);
        driverOrderModel!.orders!.forEach((element) {
          driverOrders.add(element);
        });
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
        if (error is DioError) {
          print(error.response!.data);
        }
        emit(ErrorGetAllOrdersState(error.toString()));
      });
    } else {
      emit(NoInternetHomeState());
    }
  }

  DriverOrderByIdModel? driverOrderByIdModel;

  void getOrderById({required int id}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingGetOrderByIdState());
      DioHelper.getData(
        url: ApiConstant.orderDriver + '/$id',
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        checkStatus.clear();
        driverOrderByIdModel = DriverOrderByIdModel.fromJson(value.data);
        driverOrderByIdModel!.order!.orderItems!.forEach((element) {
          checkStatus.add([
            element.status == "Ordered" ? true : false,
            element.status == "Processing" ? true : false,
            element.status == "Shipped" ? true : false,
            element.status == "Delivered" ? true : false
          ]);
        });
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
        if (error is DioError) {
          print(error.response!.data);
        }
        print(error.toString());
        emit(ErrorGetOrderByIdState(error.toString()));
      });
    } else {
      emit(NoInternetHomeState());
    }
  }

  void takeTheOrder({required int id, required int driverId}) {
    print(id);
    DioHelper.patchData(
            url: ApiConstant.updateOrder + '/$id',
            data: {"driverId": driverId},
            token: CacheHelper.getData(key: AppConstant.token))
        .then((value) {
      emit(SuccessTakeTheOrderState());
      getAllOrders();
      getDriverOrdersById(driverId: driverId);
    }).catchError((error) {
      print(error.toString());
      if (error is DioError) {
        emit(ErrorTakeTheOrderState(error.response!.data['message'][0]));
      } else {
        emit(ErrorTakeTheOrderState(error.toString()));
      }
    });
  }

  void cancelOrder(
      {required int id,
      required String image,
      required String lang,
      required String reason}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingCancelOrderDriverState());
      try {
        Dio dio = Dio();
        dio.options.headers = {
          'Content-Type': 'multipart/form-data',
          'lang': lang,
          "authorization": CacheHelper.getData(key: AppConstant.token),
        };
        FormData formData = FormData.fromMap({
          "reason": reason,
          if (image != '') "cancelImage": await MultipartFile.fromFile(image),
        });

        await dio.patch(ApiConstant.baseUrl + ApiConstant.cancelOrder(id),
            data: formData);
        emit(SuccessCancelOrderDriverState());
      } catch (error) {
        if (error is DioError) {
          emit(ErrorCancelOrderDriverState(error.response!.data['message'][0]));
        } else {
          emit(ErrorCancelOrderDriverState(error.toString()));
        }
      }
    } else {
      emit(NoInternetHomeState());
    }
  }

  List<Orders> assignOrder = [];

  void getDriverOrdersById({required int driverId}) async {
    if (await Helper.hasConnection()) {
      historyOrders.clear();
      emit(LoadingGetOrderByIdState());
      DioHelper.getData(
        query: {"status": "Delivered"},
        url: ApiConstant.historyOrder(driverId),
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        historyOrders.clear();
        driverOrderModel = DriverOrderModel.fromJson(value.data);
        driverOrderModel!.orders!.forEach((element) {
          historyOrders.add(element);
        });
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
        print(error.toString());
        if (error is DioError) {
          print(error.response!.data);
        }
        emit(ErrorGetOrderByIdState(error.toString()));
      });
    } else {
      emit(NoInternetHomeState());
    }
  }

  AssignedOrderModel? assignOrderModel;
  TimeLineOrderModel? timeLineOrderModel;
  bool allIsShipped = true;

  List<List<bool>> checkStatus = [];

  void getAssignedOrder({required int driverId}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingGetAssignedOrderState());
      assignOrder.clear();
      DioHelper.getData(
        url: ApiConstant.assignedOrder(driverId),
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        assignOrder.clear();
        checkStatus.clear();
        timeLineOrderModel = TimeLineOrderModel.fromJson(value.data);
        assignOrderModel = AssignedOrderModel.fromJson(value.data);
        timeLineOrderModel!.activeOrder!.orderItems!.forEach((element) {
          if (element.status != "Shipped") {
            allIsShipped = false;
          }
        });
        timeLineOrderModel!.activeOrder!.orderItems!.forEach((element) {
          checkStatus.add([
            element.status == "Ordered" ? true : false,
            element.status == "Processing" ? true : false,
            element.status == "Shipped" ? true : false,
            element.status == "Delivered" ? true : false
          ]);
        });
        assignOrder.add(assignOrderModel!.activeOrder!);
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
        emit(SuccessGetAssignedOrderState());
      }).catchError((error) {
        print(error.toString());
        if (error is DioError) {
          print(error.response!.data);
        }
        emit(ErrorGetAssignedOrderState(error.toString()));
      });
    } else {
      emit(NoInternetHomeState());
    }
  }

  void updateOrderItemStatus({required int id, required String status}) {
    emit(LoadingUpdateOrderItemState());
    DioHelper.patchData(
            url: ApiConstant.updateOrderItemStatus + '/$id',
            data: {"status": status},
            token: CacheHelper.getData(key: AppConstant.token))
        .then((value) {
      emit(SuccessUpdateOrderItemState());
      CacheHelper.removeData(key: AppConstant.timeLineProcess);
      getOrderById(id: id);
      getAssignedOrder(driverId: CacheHelper.getData(key: AppConstant.driverId));
    }).catchError((error) {
      print(error.toString());
      if (error is DioError) {
        emit(ErrorUpdateOrderItemState(error.response!.data['message'][0]));
      } else {
        emit(ErrorUpdateOrderItemState(error.toString()));
      }
    });
  }

  List<String> filter = [
    "All Orders",
    "Ordered",
    "Processing",
    "Price(High to Low)",
    "Price(Low to High)",
    "In The Country (Kuwait)",
    "Out Of The Country",
  ];
}

enum ProductStatus { ordered, processing, shipped, delivered }
