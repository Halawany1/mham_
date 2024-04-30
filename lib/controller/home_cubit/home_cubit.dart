import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/car_model.dart';
import 'package:mham/models/one_product_model.dart';
import 'package:mham/models/order_model.dart';
import 'package:mham/models/product_model.dart';
import 'package:mham/models/request_scrap_model.dart';
import 'package:mham/models/return_order_model.dart';

import 'package:multi_dropdown/multiselect_dropdown.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProductModel? productModel;
  List<Products> homeProducts = [];
  List<Products> allProducts = [];
  List<Products>favoriteProducts = [];
  void getAllProduct({
    int page = 1,
    int pageSize = 5,
    String? type,
    double? price,
    int? carId,
    int? carModelId,
    int? availableYearId,
    int? busniessId,
    String? search,
  }) {
    if (page == 1) {
      homeProducts.clear();
      allProducts.clear();
    }
    if (search != null || search == '') {
      allProducts.clear();
    }
    if (page == 1) {
      emit(LoadingGetAllProduct());
    }
    DioHelper.getData(
      url: ApiConstant.product,
      query: {
        'page': page,
        if (busniessId != null) 'busCat_id': busniessId,
        if (carId != null) 'car_id': carId,
        if (carModelId != null) 'carModel_id': carModelId,
        if (availableYearId != null) 'availableYears_id': availableYearId,
        if (price != null && price != 0.0) 'price': price,
        if (type != null) 'type': type,
        if (search != null) 'search': search,
        'pageSize': pageSize,
      },
     token: CacheHelper.getData(key: AppConstant.token),
    ).then((value) {
      favoriteProducts.clear();
      if (search != null || search == '') {
        allProducts.clear();
      }
      if (page == 1) {
        homeProducts.clear();
        allProducts.clear();
      }
      productModel = ProductModel.fromJson(value.data);
      if (homeProducts.isEmpty) {
        productModel!.products!.forEach((element) {
          homeProducts.add(element);
        });
      }
      productModel!.products!.forEach((element) {
        allProducts.add(element);
        if(element.inFavourite!){
          favoriteProducts.add(element);
        }
      });

      emit(SuccessGetAllProduct());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetAllProduct(error.toString()));
    });
  }

  List<ValueItem> carType = [];
  List<ValueItem> selectedCarType = [];
  List<ValueItem> carModels = [];
  List<ValueItem> carYears = [];
  List<ValueItem> selectedCarYears = [];
  List<ValueItem> selectedCarModels = [];
  CarCategoryModel? carModel;

  void getCarModels() {
    carType.clear();
    selectedCarType.clear();
    carModels.clear();
    selectedCarModels.clear();
    selectedCarYears.clear();
    carYears.clear();
    DioHelper.getData(url: ApiConstant.carModelsAvailable, )
        .then((value) {
      carType.clear();
      selectedCarType.clear();
      carModels.clear();
      selectedCarModels.clear();
      carModel = CarCategoryModel.fromJson(value.data);
      carModel!.models!.forEach((element) {
        if (!carType.any((item) => item.value == element.carModel!.carId)) {
          carType.add(ValueItem(
            label: element.carModel!.car!.carName!,
            value: element.carModel!.carId,
          ));
        }
      });
      carController.setOptions(carType);
      emit(SuccessGetCarModelsState());
    }).catchError((error) {
      emit(ErrorGetCarModelsState(error));
    });
  }

  var carController = MultiSelectController();
  var modelController = MultiSelectController();
  var yearController = MultiSelectController();

  void selectCarModels({required List<ValueItem> value}) {
    carModels.clear();
    emit(LoadingSelectCarTypeState());
    selectedCarType = value;
    selectedCarType.forEach((e) {
      carModel!.models!.forEach((element) {
        if (!carModels.any((item) => item.value == element.carModelId)) {
          if (e.value == element.carModel!.carId) {
            carModels.add(ValueItem(
                label: element.carModel!.modelName!,
                value: element.carModelId));
          }
        }
      });
    });
    modelController.setOptions(carModels);
    emit(SucccessSelectCarTypeState());
  }

  void selectCarYear({required List<ValueItem> value}) {
    carYears.clear();
    emit(LoadingSelectCarTypeState());
    selectedCarModels = value;
    selectedCarModels.forEach((e) {
      carModel!.models!.forEach((element) {
        if (!carYears.any((item) =>
            item.label.toString() == element.availableYear.toString())) {
          if (e.value == element.carModelId) {
            carYears.add(ValueItem(
                label: element.availableYear.toString(), value: element.id));
          }
        }
      });
    });
    yearController.setOptions(carYears);

    emit(SucccessSelectCarTypeState());
  }

  void removeSelectionCarModels() {
    List<ValueItem> selectedModels = [];
    selectedCarModels.forEach((element) {
      if (carModels.contains(element)) {
        selectedModels.add(element);
      }
    });
    selectedCarModels = selectedModels;
    modelController.setSelectedOptions(selectedCarModels);
    emit(RemoveSelectionCarModels());
  }

  void removeSelectionYearModels() {
    List<ValueItem> selectedYears = [];
    selectedCarYears.forEach((element) {
      if (carYears.contains(element)) {
        selectedYears.add(element);
      }
    });
    selectedCarYears = selectedYears;
    yearController.setSelectedOptions(selectedCarYears);
    emit(RemoveSelectionCarModels());
  }

  bool productDetailsContainer = false;

  void openAndCloseDetailsContainer() {
    productDetailsContainer = !productDetailsContainer;
    emit(ChangeProductDetailsContainerState());
  }

  int quantity = 1;

  void changeQuantity({required bool increase}) {
    if (increase) {
      quantity++;
    } else {
      if (quantity > 1) {
        quantity--;
      }
    }
    emit(ChangeQuantityState());
  }

  void resetQuantity() {
    quantity = 1;
    emit(ChangeQuantityState());
  }

  void increaseReview(int id) {
    DioHelper.getData(
            url: ApiConstant.increaseReview + id.toString(), )
        .then((value) {
      emit(IncreaseReviewState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
      }
      emit(ErrorIncreaseReviewState(error));
    });
  }

  int index = 0;

  void changeTypeCarIndex({required int value}) {
    index = value;
    emit(ChangeTypeCarIndexState());
  }

  RequestScrapModel? requestScrapModel;

  void addScrap({required String description}) {
    emit(LoadingAddScrapState());
    DioHelper.postData(
            url: ApiConstant.addScrap,
            data: {'description': description},
            token: CacheHelper.getData(key: AppConstant.token),
            )
        .then((value) {
      requestScrapModel = RequestScrapModel.fromJson(value.data);
      emit(SuccessAddScrapState(requestScrapModel!));
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
        String data = error.response!.data['message'][0];
        emit(ErrorAddScrapState(data));
      } else {
        emit(ErrorAddScrapState(error));
      }
    });
  }

  void addAndRemoveFavorite({
    required int id,
    int? busniessId,
  }) {
    emit(LoadingAddAndRemoveFavoriteState());
    DioHelper.postData(
            url: ApiConstant.addAndRemoveFavorite + id.toString(),
            token: CacheHelper.getData(key: AppConstant.token),
            )
        .then((value) {
      emit(SuccessAddAndRemoveFavoriteState());
      getAllProduct(

        busniessId: busniessId,
      );
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
      } else {
        emit(ErrorAddAndRemoveFavoriteState(error));
      }
    });
  }

  OrderModel? orderModel;
  List<Orders> allOrders = [];
  List<Orders> recentPurchases = [];
  List<Orders> returnsOrder = [];
  void getAllOrders() async {
    allOrders.clear();
    emit(LoadingGetAllOrdersState());
    DioHelper.getData(
      url: ApiConstant.orders,
      token: CacheHelper.getData(key: AppConstant.token),
    ).then((value) {
      allOrders.clear();
      recentPurchases.clear();
      returnsOrder.clear();
      orderModel = OrderModel.fromJson(value.data);
      orderModel!.orders!.forEach((element) {
        allOrders.add(element);
      });
      orderModel!.orders!.forEach((element) {
        if (element.status == 'Delivered') {
          recentPurchases.add(element);
        }
      });
      recentPurchases.forEach((element) {
        bool flag=false;
        element.carts!.forEach((element) {
          element.cartProducts!.forEach((element) {
            if(!element.returnProduct!.isEmpty){
              flag=true;
            }
          });
        });
        if(!flag){
          returnsOrder.add(element);
        }
      });
      emit(SuccessGetAllOrdersState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetAllOrdersState(error.toString()));
    });
  }

  List<bool> cardProductDetails = [];

  void openAndCloseCardProductDetails(int index) {
    cardProductDetails[index] = !cardProductDetails[index];
    emit(ChangeOrderDetailsContainerState());
  }

  bool trackingContainer = false;

  void openAndCloseTrackingContainer() {
    trackingContainer = !trackingContainer;
    emit(ChangeOrderDetailsContainerState());
  }

  void cancelProduct({
    required int orderId,
    required int productId,
  }) {
    emit(LoadingCancelProductState());
    DioHelper.putData(
            url: ApiConstant.cancelProduct,
            data: {'order_id': orderId, 'cartProduct_id': productId},
            token: CacheHelper.getData(key: AppConstant.token),
            )
        .then((value) {
      emit(SuccessCancelProductState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
        emit(ErrorCancelProductState(error.response!.data['message'][0]));
      } else {
        emit(ErrorCancelProductState(error));
      }
    });
  }

  void cancelOrder({required int id}) {
    emit(LoadingCancelOrderState());
    DioHelper.putData(
            url: ApiConstant.cancelOrder,
            data: {'order_id': id},
            token: CacheHelper.getData(key: AppConstant.token),
            )
        .then((value) {
      emit(SuccessCancelOrderState());
      getAllOrders();
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
        emit(ErrorCancelOrderState(error.response!.data['message'][0]));
      } else {
        emit(ErrorCancelOrderState(error));
      }
    });
  }

  int rate = 0;

  void changeRate({required int value}) {
    rate = value;
    emit(ChangeRateState());
  }

  void addRate({required int id, String? comment, required int rate}) {
    emit(LoadingAddRateState());
    DioHelper.postData(
            url: ApiConstant.addRate + id.toString(),
            data: {
              "rateData": {
                "rate": rate,
                if (comment != null) "comment": comment //optinal
              }
            },
            token: CacheHelper.getData(key: AppConstant.token),
            )
        .then((value) {
      emit(SuccessAddRateState());
      getProductDetails(id: id);
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
        emit(ErrorAddRateState(error.response!.data['message'][0]));
      } else {
        emit(ErrorAddRateState(error));
      }
    });
  }

  List<String> modelsCar = [];
  OneProductModel? oneProductModel;

  void getProductDetails({required int id}) {
    emit(LoadingGetProductDetailsState());
    DioHelper.getData(
            url: ApiConstant.productDetails + id.toString(),
            token: CacheHelper.getData(key: AppConstant.token),
            )
        .then((value) {
      modelsCar.clear();
      oneProductModel = OneProductModel.fromJson(value.data);
      oneProductModel!.product!.availableYears!.forEach((element) {
        modelsCar.add(element.carModel!.car!.carName! +
            ' ' +
            element.carModel!.modelName! +
            ' ' +
            element.availableYear.toString());
      });
      emit(SuccessGetProductDetailsState());
    }).catchError((error) {
      if (error is DioError) {
        print(error.response!.data);
        emit(ErrorGetProductDetailsState(error.response!.data['message']));
      } else {
        print(error.toString());
        emit(ErrorGetProductDetailsState(error.toString()));
      }
    });
  }

  void returnOrder({required List<Map<String,dynamic>> returns}) {
    emit(LoadingReturnOrderState());
    DioHelper.postData(
        url: ApiConstant.returnOrder,
        data: {
          "returnData": returns
        },
        token: CacheHelper.getData(key: AppConstant.token),
        )
        .then((value) {
      emit(SuccessReturnOrderState());
    }).catchError((error) {
      if (error is DioError) {
        emit(ErrorReturnOrderState(error.response!.data['message'][0]));
      } else {
        print(error.toString());
        emit(ErrorReturnOrderState(error));
      }
    });
  }

  String ?quantityValue;

void changeQuantityValue({required String value}) {
  quantityValue = value;
  emit(ChangeQuantityState());
}

void getNotification() {
  emit(LoadingGetNotificationState());
 DioHelper.getData(
   token: CacheHelper.getData(key: AppConstant.token),
     url: ApiConstant.notifications)
     .then((value) {
       emit(SuccessGetNotificationState());
 }).catchError((error){
   if(error is DioError){
     print(error.response!.data);
   }
   print(error.toString());
   emit(ErrorGetNotificationState());
 });
}
}
