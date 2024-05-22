import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/client_profile_model.dart';
import 'package:mham/models/driver_profile_model.dart';
import 'package:mham/models/user_model.dart';
import 'package:http_parser/http_parser.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileModel? profileModel;
  DriverProfileModel? driverProfileModel;

  void getProfile({required bool driver}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingProfileState());
      DioHelper.getData(
              url: driver ? ApiConstant.profileDriver : ApiConstant.profile,
              token: CacheHelper.getData(key: AppConstant.token))
          .then((value) {
            print(value.data);
        if (driver) {
          driverProfileModel = DriverProfileModel.fromJson(value.data);
        } else {
          profileModel = ProfileModel.fromJson(value.data);
        }
        emit(SuccessProfileState());
      }).catchError((error) {
        emit(ErrorProfileState(error.toString()));
      });
    } else {
      emit(NoInternetProfileState());
    }
  }

  void updateProfile(
      {required String userName,
      required int countryId,
      required String phone,
      required bool driver}) async {
    if (await Helper.hasConnection()) {
      emit(LoadingUpdateProfileState());
      DioHelper.putData(
          url: ApiConstant.updateProfile,
          token: CacheHelper.getData(key: AppConstant.token),
          data: {
            'user_name': userName,
            'mobile': phone,
            'country_id': countryId
          }).then((value) {
        emit(SuccessUpdateProfileState());
        getProfile(driver: driver);
      }).catchError((error) {
        if (error is DioError) {
          emit(ErrorUpdateProfileState(error.response!.data['message'][0]));
        } else {
          emit(ErrorUpdateProfileState(error.toString()));
        }
      });
    } else {
      emit(NoInternetProfileState());
    }
  }

  void updateProfileForDriver({
    required String userName,
    required String mobile,
    required String drivingLicence,
    required int country,
    required String lang,
    required String address,
    required String avatar,
  }) async {
    if (await Helper.hasConnection()) {
      emit(LoadingUpdateProfileDriverState());
      try {
        Dio dio = Dio();
        dio.options.headers = {
          'Content-Type': 'multipart/form-data',
          'lang': lang,
          'authorization': CacheHelper.getData(key: AppConstant.token),
        };
        FormData formData = FormData.fromMap({
          "name": userName,
          if (avatar.isNotEmpty)"driverAvatar": await MultipartFile.
          fromFile(avatar,
              filename: drivingLicence.split('/').last,
              contentType: MediaType("image","jpeg")),
          if (drivingLicence.isNotEmpty)
            "driverLicense": await MultipartFile.
            fromFile(drivingLicence,
                filename: drivingLicence.split('/').last,
                contentType: MediaType("image","jpeg")),
          "mobile": mobile,
          "countryId": country,
          if (address != '') "address": address,
        });

        await dio.patch(
            ApiConstant.baseUrl +
                '/drivers/${CacheHelper.getData(key: AppConstant.driverId)}',
            data: formData);
        emit(SuccessUpdateProfileDriverState());
        getProfile(driver: true);
      } catch (error) {
        print(error.toString());
        if (error is DioError) {
          print(error.response!.data);
          emit(ErrorUpdateProfileDriverState(error.response!.data['message'][0]));
        } else {
          emit(ErrorUpdateProfileDriverState(error.toString()));
        }
      }
    } else {
      emit(NoInternetProfileState());
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? image;
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(SuccessPickImageState());
    }
  }
}
