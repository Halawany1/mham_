import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/local.dart';
import 'package:mham/core/network/remote.dart';
import 'package:mham/models/countries_model.dart';
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

  void userLogin({
    required String phone,
    required String password,
    required String lang
  }) {
    emit(LoadingLoginUserState());
    DioHelper.postData(url: ApiConstant.login,
        lang: lang,
        data: {
          "phonenumber": phone,
          "password": password
        }
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessLoginUserState());
    }).catchError((error) {
      if (error is DioError) {
        errorUserModel = ErrorUserModel.fromJson(error.response!.data);
        emit(ErrorLoginUserState(errorUserModel!.message!.first));
      } else {
        emit(ErrorLoginUserState(error.toString()));
      }
    });
  }

  ErrorUserModel ?errorUserModel;



  CountriesModel ?countriesModel;
  List <String> countriesList = [];

  Map<String,int>countriesId ={};

  void getCountries() {
    emit(LoadingGetCountriesState());
    DioHelper.getData(url:
    'https://maham-production.up.railway.app/api/countries',
        lang: 'en').then((value) {
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
    required String lang
  }) {
    emit(LoadingRegisterUserState());
    DioHelper.postData(url: ApiConstant.register,
        lang: lang,
        data: {
          "username": userName,
          "password":password,
          "phonenumber" : phone,
          "country" :countryId,
          "confirmPassword" : confirmPassword
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
  }

}
