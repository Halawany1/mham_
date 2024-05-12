class DriverModel {
  Driver? driver;

  DriverModel.fromJson(Map<String, dynamic> json) {
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }


}

class Driver {
  User? user;

  Driver.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }


}

class User {
  int? id;
  String? userName;
  String? mobile;
  String? password;
  int? countryId;
  String? role;
  List<Traders>? traders;
  //List<Null>? favourites;
  Country? country;



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    role = json['role'];
    if (json['traders'] != null) {
      traders = <Traders>[];
      json['traders'].forEach((v) {
        traders!.add(new Traders.fromJson(v));
      });
    }
    // if (json['Favourites'] != null) {
    //   favourites = <Null>[];
    //   json['Favourites'].forEach((v) {
    //     favourites!.add(new Null.fromJson(v));
    //   });
    // }
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }


}

class Traders {
  int? traderId;
  int? userId;
  int? businessId;
  String? brandName;
  String? brandImg;
  String? commercialCertificate;
  String? type;
  String? status;
  String? fcmToken;
  Business? business;



  Traders.fromJson(Map<String, dynamic> json) {
    traderId = json['trader_id'];
    userId = json['user_id'];
    businessId = json['business_id'];
    brandName = json['brand_name'];
    brandImg = json['brand_img'];
    commercialCertificate = json['commercial_certificate'];
    type = json['type'];
    status = json['status'];
    fcmToken = json['fcmToken'];
    business = json['business'] != null
        ?  Business.fromJson(json['business'])
        : null;
  }

}

class Business {
  int? businessId;
  String? businessNameEn;
  String? businessNameAr;
  String? businessImg;
  String? businessDescEn;
  String? businessDescAr;



  Business.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    businessNameEn = json['business_name_en'];
    businessNameAr = json['business_name_ar'];
    businessImg = json['business_img'];
    businessDescEn = json['business_desc_en'];
    businessDescAr = json['business_desc_ar'];
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