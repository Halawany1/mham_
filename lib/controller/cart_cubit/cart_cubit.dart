import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/helper/helper.dart';

import 'package:mham/core/network/remote.dart';
import 'package:mham/models/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  CartModel? cartModel;
  double totalPrice = 0.0;

  void getCart({required String token}) async {
    if (await Helper.hasConnection()) {
      emit(CartLoadingState());
      DioHelper.getData(
        url: ApiConstant.getCart,
        token: token,
      ).then((value) {
        totalPrice = 0.0;
        cartModel = CartModel.fromJson(value.data);
        cartModel!.cart!.cartProducts!.forEach((element) {
          totalPrice += element.quantity! * element.product!.price!;
        });
        emit(CartSuccessState());
      }).catchError((error) {
        if (error is DioError) {
          String data = error.response!.data['message'][0];
          print(data);
          emit(CartErrorState(data));
        } else {
          print(error.toString());
          emit(CartErrorState(error.toString()));
        }
      });
    } else {
      emit(NoInternetCartState());
    }
  }

  void deleteCart({required String token, required int id}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingDeleteCart());
      DioHelper.deleteData(
          url: ApiConstant.deleteCart+id.toString(),
          token: token,).then((value) {
        emit(SuccessDeleteCart());
        getCart(token: token);
      }).catchError((error) {
        if (error is DioError) {
          String data = error.response!.data['message'][0];
          emit(ErrorDeleteCart(data));
        } else {
          emit(ErrorDeleteCart(error.toString()));
        }
      });
    } else {
      emit(NoInternetCartState());
    }
  }

  void updateCart(
      {required String token, required int id, required int quantity}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingUpdateCart());
      DioHelper.patchData(
          url: ApiConstant.addToCart+id.toString(),
          token: token,
          data: {'quantity': quantity}).then((value) {
        emit(SuccessUpdateCart());
        getCart(token: token);
      }).catchError((error) {
        if (error is DioError) {
          String data = error.response!.data['message'][0];
          emit(ErrorUpdateCart(data));
        } else {
          emit(ErrorUpdateCart(error.toString()));
        }
      });
    } else {
      emit(NoInternetCartState());
    }
  }

  void addToCart(
      {required String token, required int id, required int quantity}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingAddToCart());
      DioHelper.postData(
          url: ApiConstant.addToCart ,
          token: token,
          data: {'productId': id}).then((value) {
        emit(SuccessAddToCart());
        getCart(token: token);
      }).catchError((error) {
        if (error is DioError) {
          String data = error.response!.data['message'][0];
          emit(ErrorAddToCart(data));
        } else {
          emit(ErrorAddToCart(error.toString()));
        }
      });
    } else {
      emit(NoInternetCartState());
    }
  }
}
