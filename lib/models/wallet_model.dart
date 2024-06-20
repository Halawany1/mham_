class WalletModel {
  Wallet? wallet;

  WalletModel.fromJson(Map<String, dynamic> json) {
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
  }

}

class Wallet {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? balance;
  String? currency;
  User? user;



  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    balance = json['balance'];
    currency = json['currency'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }


}

class User {
  int? id;
  String? userName;
  String? mobile;
  Country? country;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
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