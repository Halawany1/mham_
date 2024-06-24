import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/refunds_model.dart';
import 'package:mham/models/transiaction_model.dart';
import 'package:mham/models/wallet_model.dart';

part 'transiaction_state.dart';

class TransiactionCubit extends Cubit<TransiactionState> {
  TransiactionCubit() : super(TransiactionInitial());
  static TransiactionCubit get(context) => BlocProvider.of(context);


  TransiactionModel ?transiactionModel;
  void getTransiaction() {
    emit(LoadingGetTransiactionState());
    DioHelper.getData(
      url: ApiConstant.transactions,
      token: CacheHelper.getData(key: AppConstant.token,token: true),
    ).then((value) {
      transiactionModel=TransiactionModel.fromJson(value.data);
      emit(SuccessGetTransiactionState());
    }).catchError((error){
      if(error is DioError){
        print(error.response!.data);
      }else{
        print(error.toString());
      }
      emit(ErrorGetTransiactionState(error.toString()));
    });
  }

  WalletModel? walletModel;
  void getMyWallet() {
    emit(LoadingGetWalletState());
    DioHelper.getData(
      url: ApiConstant.wallet,
      token: CacheHelper.getData(key: AppConstant.token,token: true),
    ).then((value) {
      walletModel=WalletModel.fromJson(value.data);
      emit(SuccessGetWalletState());
    }).catchError((error){
      emit(ErrorGetWalletState(error.toString()));
    });
  }

  bool refund=false;
  void changeRefund(bool value){
    refund=value;
    emit(ChangeRefundState());
  }
  RefundsModel? refundsModel;
  void getRefunds() {
    emit(LoadingGetWalletState());
    DioHelper.getData(
      url: ApiConstant.refunds,
      token: CacheHelper.getData(key: AppConstant.token),
    ).then((value) {
      refundsModel=RefundsModel.fromJson(value.data);
      emit(SuccessGetWalletState());
    }).catchError((error){
      emit(ErrorGetWalletState(error.toString()));
    });
  }

}
