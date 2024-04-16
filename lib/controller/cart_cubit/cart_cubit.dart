import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/cart_model.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());


  CartModel ?cartModel;
  void getCart() {
    emit(CartLoadingState());
    DioHelper.getData(url: ApiConstant.getCart,
        token: CacheHelper.getData(key: AppConstant.token),
        lang: 'en').then((value) {
          cartModel=CartModel.fromJson(value.data);
          emit(CartSuccessState());
    }).catchError((error){
      if(error is DioError){
        print(error.response!.data.toString());
      }
      emit(CartErrorState(error.toString()));
    });
  }
}
