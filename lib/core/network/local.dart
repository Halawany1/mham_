import 'package:mham/core/constent/api_constant.dart';
import 'package:mham/core/constent/app_constant.dart';
import 'package:mham/core/network/remote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:jwt_decoder/jwt_decoder.dart";
class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key, bool token=false}) {
    print( token);
    var storedToken = sharedPreferences!.getString(AppConstant.token);
    if(storedToken!=null&&
        storedToken==key) {
      bool expired = JwtDecoder.isExpired(key);
      print(expired);
      if(expired) {
        DioHelper.postData(url: ApiConstant.refresh,
            data: {
              'refreshToken': CacheHelper.getData(key: AppConstant.refreshToken)
            }
        ).then((value) {
          print(value.data);
          saveData(key: AppConstant.token, value: value.data['accessToken']);
          saveData(key: AppConstant.refreshToken, value: value.data['refreshToken']);
        });
        return sharedPreferences!.get(CacheHelper.getData(key: AppConstant.refreshToken));
      }else{
        return sharedPreferences!.get(key);
      }
    }else{
      return sharedPreferences!.get(key);
    }


  }

  static Future<bool?> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    return null;
  }

  static Future<bool?> deleteAllData() async {
    return await sharedPreferences!.clear();
  }

  static Future<bool?> removeData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }
}


