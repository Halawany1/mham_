class CountriesModel {
  List<Countries>? countries;
  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add( Countries.fromJson(v));
      });
    }
  }
}

class Countries {
  int? countryId;
  String? countryNameEn;
  String? countryNameAr;


  Countries.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'];
    countryNameEn = json['country_name_en'];
    countryNameAr = json['country_name_ar'];
  }

}