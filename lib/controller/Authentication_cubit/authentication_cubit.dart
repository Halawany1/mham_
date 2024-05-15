import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/countries_model.dart';
import 'package:mham/models/driverDataModel.dart';
import 'package:mham/models/user_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  static AuthenticationCubit get(context) => BlocProvider.of(context);

  bool visibleOne = false;
  bool visibleTwo = false;

  void changeVisible(bool signIn) {
    if (signIn) {
      visibleOne = !visibleOne;
    } else {
      visibleTwo = !visibleTwo;
    }
    emit(ChangeVisibalityPasswordState());
  }

  void resetVisible() {
    visibleOne = false;
    visibleTwo = false;
    emit(ResetVisibalityPasswordState());
  }

  bool rememberCheck = false;

  void changeRememberCheck(bool value) {
    rememberCheck = value;
    emit(ChangeRememberCheckState());
  }

  UserModel ?userModel;
  DriverModel? driverModel;
  void userLogin({
    required String phone,
    required String password,
    required String lang,
    bool driver=false
  }) async{
    if(await Helper.hasConnection()) {
      emit(LoadingLoginUserState());
      DioHelper.postData(url:driver?
      ApiConstant.loginDriver
          : ApiConstant.login,
          data: {
            if(driver)"mobile": phone,
            if(!driver)"phonenumber": phone,
            "password": password,
            "fcmToken": CacheHelper.getData(key: AppConstant.fcmToken),
          }
      ).then((value) {
        if(driver){
          driverModel = DriverModel.fromJson(value.data);
        }else{
          userModel = UserModel.fromJson(value.data);
        }
        emit(SuccessLoginUserState());
      }).catchError((error) {
        if (error is DioError) {
          print(error.response!.data);
          emit(ErrorLoginUserState(error.response!.data['message'][0]));
        } else {
          emit(ErrorLoginUserState(error.toString()));
        }
      });
    }else{
      emit(NoInternetAuthState());
    }

  }

  ErrorUserModel ?errorUserModel;



  CountriesModel ?countriesModel;
  List <String> countriesList = [];

  Map<String,int>countriesId ={};

  void getCountries() async{
    if(await Helper.hasConnection()){
      emit(LoadingGetCountriesState());
      DioHelper.getData(url:
      '/countries',).then((value) {
        countriesId.clear();
        countriesList.clear();
        countriesModel = CountriesModel.fromJson(value.data);
        countriesModel!.countries!.forEach((element) {
          if(CacheHelper.getData(key: AppConstant.lang)=='en'||
              CacheHelper.getData(key: AppConstant.lang)==null
          ){
            countriesId[element.countryNameEn!] = element.countryId!;
            countriesList.add(element.countryNameEn!);
          }else{
            countriesId[element.countryNameAr!] = element.countryId!;
            countriesList.add(element.countryNameAr!);
          }


        });
        emit(SuccessGetCountriesState());
      }).catchError((error) {
        emit(ErrorGetCountriesState(error.toString()));
      });
    }else{
      emit(NoInternetAuthState());
    }

  }
String ?countryId;
  CountryId ?selectedCountry;
  List<CountryId> countries = [
    CountryId('Algeria', '+213'),
    CountryId('Bahrain', '+973'),
    CountryId('Comoros', '+269'),
    CountryId('Djibouti', '+253'),
    CountryId('Egypt', '+20'),
    CountryId('Iraq', '+964'),
    CountryId('Jordan', '+962'),
    CountryId('Kuwait', '+965'),
    CountryId('Lebanon', '+961'),
    CountryId('Libya', '+218'),
    CountryId('Mauritania', '+222'),
    CountryId('Morocco', '+212'),
    CountryId('Oman', '+968'),
    CountryId('Palestine', '+970'),
    CountryId('Qatar', '+974'),
    CountryId('Saudi Arabia', '+966'),
    CountryId('Somalia', '+252'),
    CountryId('Sudan', '+249'),
    CountryId('Syria', '+963'),
    CountryId('Tunisia', '+216'),
    CountryId('Emirates', '+971'),
    CountryId('Yemen', '+967'),
  ];
  List<CountryId> countriesAr = [
    CountryId('الجزائر', '+213'),
    CountryId('البحرين', '+973'),
    CountryId('جزر القمر', '+269'),
    CountryId('جيبوتي', '+253'),
    CountryId('مصر', '+20'),
    CountryId('العراق', '+964'),
    CountryId('الأردن', '+962'),
    CountryId('الكويت', '+965'),
    CountryId('لبنان', '+961'),
    CountryId('ليبيا', '+218'),
    CountryId('موريتانيا', '+222'),
    CountryId('المغرب', '+212'),
    CountryId('عُمان', '+968'),
    CountryId('فلسطين', '+970'),
    CountryId('قطر', '+974'),
    CountryId('السعودية', '+966'),
    CountryId('الصومال', '+252'),
    CountryId('السودان', '+249'),
    CountryId('سوريا', '+963'),
    CountryId('تونس', '+216'),
    CountryId('الإمارات', '+971'),
    CountryId('اليمن', '+967'),
  ];
  void selectCountryCode(CountryId country) {
    selectedCountry = country;
    emit(SelectCountryCodeState());
  }

  void selectCountryId(String country) {
    countryId = country;
    emit(SelectCountryIdState());
  }


  void userSignUp({
    required String phone,
    required String userName,
    required String password,
    required int countryId,
    required String confirmPassword,
    required String lang,
  }) async{

    if(await Helper.hasConnection()){
      emit(LoadingRegisterUserState());
      DioHelper.postData(url: ApiConstant.register,
          data: {
            "username": userName,
            "password":password,
            "phonenumber" : phone,
            "country" :countryId,
            "confirmPassword" : confirmPassword,
            "fcmToken": CacheHelper.getData(key: AppConstant.fcmToken),
          }
      ).then((value) {
        userModel = UserModel.fromJson(value.data);
        emit(SuccessRegisterUserState());
      }).catchError((error) {
        if (error is DioError) {
          print(error.response!.data);
          errorUserModel = ErrorUserModel.fromJson(error.response!.data);
          emit(ErrorRegisterUserState(errorUserModel!.message!.first));
        } else {
          emit(ErrorRegisterUserState(error.toString()));
        }
      });
    }else{
      emit(NoInternetAuthState());
    }

  }

  int currentIndexOtpVerification = 0;
  void changeIndexOtpVerification(int index){
    currentIndexOtpVerification = index;
    emit(ChangeIndexOtpVerificationState());
  }


  void userSignUpForDriver({
    required String userName,
    required String password,
    required String phone,
    required String confirmPassword,
    required String drivingLicence,
    required int country,
    required String lang,
    required String address,
  }) async {
    if(await Helper.hasConnection()){
      emit(LoadingRegisterUserState());
      try {
        Dio dio = Dio();
        dio.options.headers = {
          'Content-Type': 'multipart/form-data',
          'lang': lang,
        };
        FormData formData = FormData.fromMap({
          "username": userName,
          if(drivingLicence!='') "drivingLicence": await MultipartFile.fromFile(drivingLicence),
          "password": password,
          "mobile": phone,
          "countryId": country,
          "confirmPassword": confirmPassword,
         if(address!='') "address":address,
        });

        await dio.post(
            ApiConstant.baseUrl + ApiConstant.registerDriver,
            data: formData);
        emit(SuccessRegisterUserState());
      } catch (error) {
        if (error is DioError) {
          print(error.response!.data);
          emit(ErrorRegisterUserState(error.response!.data.toString()));
        } else {
          emit(ErrorRegisterUserState(error.toString()));
        }
      }
    }else{
      emit(NoInternetAuthState());
    }
  }


}
