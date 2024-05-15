class MyScrapModel {
  int? totalPages;
  int? page;
  int? pageSize;
  int? pageCount;
  List<Scraps>? scraps;


  MyScrapModel.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    if (json['scraps'] != null) {
      scraps = <Scraps>[];
      json['scraps'].forEach((v) {
        scraps!.add(new Scraps.fromJson(v));
      });
    }
  }

}

class Scraps {
  int? id;
  int? userId;
  String? description;
  String? status;
  String? response;
  String? createdAt;
  String? responseAt;
  User? user;



  Scraps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    status = json['status'];
    response = json['response'];
    createdAt = json['created_at'];
    responseAt = json['response_at'];
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
  Country? country;



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    role = json['role'];
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