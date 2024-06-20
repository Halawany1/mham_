class UserModel {
  User? user;
  String? accessToken;
  String? refreshToken;


  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

}

class User {
  int? id;
  String? userName;
  String? mobile;
  String? role;
  Country? country;


  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    role = json['role'];
    country =
    json['country'] != null ?  Country.fromJson(json['country']) : null;
  }

}

class Country {
  int? countryId;
  String? countryNameEn;
  String? countryNameAr;


  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryNameEn = json['country_name_en'];
    countryNameAr = json['country_name_ar'];
  }

}


class CountryId {
  final String name;
  final String dialCode;

  CountryId(this.name, this.dialCode);
}

//error user model

class ErrorUserModel {
  List<String>? message;

  ErrorUserModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = List<String>.from(json['message']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}