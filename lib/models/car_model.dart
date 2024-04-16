class CarCategoryModel {
  List<ModelsCategory>? models;

  CarCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['models'] != null) {
      models = <ModelsCategory>[];
      json['models'].forEach((v) {
        models!.add( ModelsCategory.fromJson(v));
      });
    }
  }


}

class ModelsCategory {
  int? id;
  int? availableYear;
  int? carModelId;
  CarCategory? carModel;

  ModelsCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    availableYear = json['available_year'];
    carModelId = json['carModelId'];
    carModel = json['carModel'] != null
        ?  CarCategory.fromJson(json['carModel'])
        : null;
  }


}

class CarCategory{
  int? id;
  String? modelName;
  int? carId;
  CarName? car;

  CarCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelName = json['model_name'];
    carId = json['carId'];
    car = json['car'] != null ?  CarName.fromJson(json['car']) : null;
  }


}

class CarName {
  int? id;
  String? carName;

  CarName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carName = json['car_name'];
  }

}