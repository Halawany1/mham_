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
import 'package:mham/models/rerurn_order_model.dart';
import 'package:mham/models/time_line_order_model.dart';
import 'package:http_parser/http_parser.dart';

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
      {required int index, required int id,
        required int orderId,
        required bool value}) {

    if (index == 0) {
      updateOrderItemStatus(id: id, status: "Ordered",orderId: orderId);
    } else if (index == 1) {
      updateOrderItemStatus(id: id, status: "Processing",orderId: orderId);
    } else if (index == 2) {
      updateOrderItemStatus(id: id, status: "Shipped",orderId: orderId);
    } else if(index==3) {
      updateOrderItemStatus(id: id, status: "Delivered",orderId: orderId);
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
        print(checkStatus);
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
        getAssignedOrder(driverId: CacheHelper.getData(key: AppConstant.driverId));
      }).catchError((error) {
        print(error.toString());
        if(error is DioError){
          print(error.response!.data);
        }
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
      getAssignedOrder(driverId: driverId);
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
          if (image != '') "cancelImage": await MultipartFile.fromFile(image,
              filename: image.split('/').last,
          contentType: MediaType("image","jpeg")),
        });

        await dio.patch(ApiConstant.baseUrl + ApiConstant.cancelOrder(id),
            data: formData);
        emit(SuccessCancelOrderDriverState());
      } catch (error) {
        if (error is DioError) {
          print(error.response!.data);
          print(error.response!.data['message'][0]);
          emit(ErrorCancelOrderDriverState(error.response!.data['message'][0]));
        } else {
          emit(ErrorCancelOrderDriverState(error.toString()));
        }
      }
    } else {
      emit(NoInternetHomeState());
    }
  }
  void cancelItemOrder(
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
          if (image.isNotEmpty) "cancelImage": await MultipartFile.fromFile(image,
              filename: image.split('/').last,
              contentType: MediaType("image","jpeg")),
        });

        await dio.patch(ApiConstant.baseUrl + ApiConstant.cancelProduct(id),
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
  ReturnOrderModel? returnOrderModel;
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
        print(driverId);
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
        emptyTimeLineAndAssign=false;
      }).catchError((error) {
        print(error.toString());
        if (error is DioError) {
          print(error.response!.data);
          emptyTimeLineAndAssign=true;
          emit(ErrorGetAssignedOrderState(error.response!.data['message'][0]));
        }else{
          emit(ErrorGetAssignedOrderState(error.toString()));
        }
      });
    } else {
      emit(NoInternetHomeState());
    }
  }

  void getReturnOrderAssigned({required int driverId}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingGetAssignedOrderState());
      assignOrder.clear();
      DioHelper.getData(
        url: ApiConstant.returnAssignedOrder(driverId),
        token: CacheHelper.getData(key: AppConstant.token),
      ).then((value) {
        if(value.statusCode==200){
          print(value.data);
          assignOrder.clear();
          checkStatus.clear();
          returnOrderModel = ReturnOrderModel.fromJson(value.data);
          returnOrderModel!.activeOrder!.orderItems!.forEach((element) {
            if (element.status != "Shipped") {
              allIsShipped = false;
            }
          });
          returnOrderModel!.activeOrder!.orderItems!.forEach((element) {
            checkStatus.add([
              element.status == "Ordered" ? true : false,
              element.status == "Processing" ? true : false,
              element.status == "Shipped" ? true : false,
              element.status == "Delivered" ? true : false
            ]);
          });
          assignOrder.add(assignOrderModel!.activeOrder!);
        }


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
        emptyTimeLineAndAssign=false;
      }).catchError((error) {
        print(error.toString());
        if (error is DioError) {
          print(error.response!.data);
          emptyTimeLineAndAssign=true;
          emit(ErrorGetAssignedOrderState(error.response!.data['message'][0]));
        }else{
          emit(ErrorGetAssignedOrderState(error.toString()));
        }
      });
    } else {
      emit(NoInternetHomeState());
    }
  }
  bool emptyTimeLineAndAssign=false;
  void updateOrderItemStatus({required int id,
    required int orderId,
    required String status}) {
    emit(LoadingUpdateOrderItemState());
    DioHelper.patchData(
            url: ApiConstant.updateOrderItemStatus + '/$id',
            data: {"status": status},
            token: CacheHelper.getData(key: AppConstant.token))
        .then((value) {
      emit(SuccessUpdateOrderItemState());
      CacheHelper.removeData(key: AppConstant.timeLineProcess);
      assignOrderModel=null;
      driverOrderModel=null;
      getOrderById(id: orderId);


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
