import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/user_model.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel ?userModel;
  void getProfile() {
    emit(LoadingProfileState());
    DioHelper.getData(url: ApiConstant.profile,
      token: CacheHelper.getData(key: AppConstant.token)
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessProfileState());
    }).catchError((error){
      emit(ErrorProfileState(error.toString()));
    });
  }

  void updateProfile({
    required String userName,
    required int countryId,
    required String phone
  }) {
    emit(LoadingUpdateProfileState());
    DioHelper.putData(
        url: ApiConstant.updateProfile,
        token: CacheHelper.getData(key: AppConstant.token),
        data: {
          'user_name': userName,
          'mobile': phone,
          'country_id': countryId
        }
    ).then((value) {
      emit(SuccessUpdateProfileState());
      getProfile();
    }).catchError((error){
      if(error is DioError){
        String date=error.response!.data['message'][0];
        emit(ErrorUpdateProfileState(error.toString()));
      }else{
        emit(ErrorUpdateProfileState(error.toString()));
      }
    });
  }
}
