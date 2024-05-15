class DriverProfileModel {
  Driver? driver;


  DriverProfileModel.fromJson(Map<String, dynamic> json) {
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
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
  User? user;


  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    drivingLicence = json['drivingLicence'];
    email = json['email'];
    status = json['status'];
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
    // if (json['traders'] != null) {
    //   traders = <Null>[];
    //   json['traders'].forEach((v) {
    //     traders!.add(new Null.fromJson(v));
    //   });
    // }
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