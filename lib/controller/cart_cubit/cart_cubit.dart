import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';

import 'package:mham/core/network/remote.dart';
import 'package:mham/models/cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  CartModel ?cartModel;
  double totalPrice=0.0;
  void getCart({required String token}) {
    emit(CartLoadingState());
    DioHelper.getData(
        url: ApiConstant.getCart,
        token:token,
        lang: 'en').
    then((value) {
      totalPrice=0.0;
          cartModel=CartModel.fromJson(value.data);
          cartModel!.cart!.cartProducts!.forEach((element) {
            totalPrice+=element.quantity!*element.product!.price!;
          });
          emit(CartSuccessState());
    }).catchError((error){
      if(error is DioError){
        String data=error.response!.data['message'][0];
        emit(CartErrorState(data));
      }else{
        emit(CartErrorState(error.toString()));
      }
    });
  }

  void deleteCart({required String token,required int id}) {
    emit(LoadingDeleteCart());
    DioHelper.deleteData(
        url: ApiConstant.deleteCart,
        token:token,
        lang: 'en',
      query: {
        'cartProduct_id':id
      }
    ).then((value) {
      emit(SuccessDeleteCart());
      getCart(token: token);
    }).catchError((error){
      if(error is DioError){
        String data=error.response!.data['message'][0];
        emit(ErrorDeleteCart(data));
      }else{
        emit(ErrorDeleteCart(error.toString()));
      }

    });
  }

  void updateCart({required String token,
    required int id,required int quantity}) {
    emit(LoadingUpdateCart());
    DioHelper.postData(
        url: ApiConstant.addToCart,
        token:token,
        lang: 'en',
        data: {
          'product_id':id,
          'quantity':quantity
        }
    ).then((value) {
      emit(SuccessUpdateCart());
      getCart(token: token);
    }).catchError((error){
      if(error is DioError){
        String data=error.response!.data['message'][0];
        print(data);
        emit(ErrorUpdateCart(data));
      }else{
        emit(ErrorUpdateCart(error.toString()));
      }

    });
  }

  void addToCart({required String token
    ,required int id
    ,required int quantity}) {
    emit(LoadingAddToCart());
    DioHelper.postData(
        url: ApiConstant.addToCart,
        token:token,
        lang: 'en',
        data: {
          'product_id':id,
          'quantity':quantity
        }
    ).then((value) {
      emit(SuccessAddToCart());
      getCart(token: token);
    }).catchError((error){
      if(error is DioError){
        String data=error.response!.data['message'][0];
        print(data);
        emit(ErrorAddToCart(data));
      }else{
        emit(ErrorAddToCart(error.toString()));
      }

    });
  }


}
