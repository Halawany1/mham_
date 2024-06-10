import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/transiaction_model.dart';

part 'transiaction_state.dart';

class TransiactionCubit extends Cubit<TransiactionState> {
  TransiactionCubit() : super(TransiactionInitial());
  static TransiactionCubit get(context) => BlocProvider.of(context);


  TransiactionModel ?transiactionModel;
  void getTransiaction() {
    emit(LoadingGetTransiactionState());
    DioHelper.getData(
      url: ApiConstant.transactions,
      token: CacheHelper.getData(key: AppConstant.token),
    ).then((value) {
      transiactionModel=TransiactionModel.fromJson(value.data);
      emit(SuccessGetTransiactionState());
    }).catchError((error){
      emit(ErrorGetTransiactionState(error.toString()));
    });
  }

}
