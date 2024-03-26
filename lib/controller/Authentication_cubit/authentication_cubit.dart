import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  bool visibleOne = false;
  bool visibleTwo = false;
  void changeVisible(bool signIn){
    if(signIn){
      visibleOne = !visibleOne;
    }else{
      visibleTwo = !visibleTwo;
    }
    emit(ChangeVisibalityPasswordState());
  }

  void resetVisible(){
    visibleOne = false;
    visibleTwo = false;
    emit(ResetVisibalityPasswordState());
  }

  bool rememberCheck = false;
  void changeRememberCheck(bool value){
    rememberCheck =value;
    emit(ChangeRememberCheckState());
  }
}
