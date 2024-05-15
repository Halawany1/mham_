class DriverModel {
  User? user;
  String? token;

  DriverModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

}

class User {
  int? id;
  String? userName;
  String? mobile;
  int? countryId;
  String? role;
  Driver? driver;
  Country? country;


  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    countryId = json['country_id'];
    role = json['role'];
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }


}

class Driver {
  int? id;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? drivingLicence;
  String? email;
  String? status;



  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    drivingLicence = json['drivingLicence'];
    email = json['email'];
    status = json['status'];
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