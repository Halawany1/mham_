class OneProductModel {
  Product? product;

  OneProductModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  int? productsId;
  int? traderId;
  String? description;
  String? manufacturerPartNumber;
  String? brandName;
  List<Map<String, String>>? address;
  String? productsImg;
  String? madeIn;
  dynamic price;
  bool? isOffer;
  dynamic offerPrice;
  String? offerStartDate;
  String? offerEndDate;
  dynamic rating;
  int? reviewCount;
  String? type;
  bool? isBestSeller;
  bool? isMobilawy;
  bool? assemblyKit;
  String? productLine;
  String? frontOrRear;
  int? tyreSpeedRate;
  int? maximumTyreLoad;
  int? tyreEngraving;
  int? rimDiameter;
  int? tyreHeight;
  int? tyreWidth;
  int? kilometer;
  String? oilType;
  bool? batteryReplacementAvailable;
  int? volt;
  int? ampere;
  int? liter;
  String? color;
  int? numberSparkPulgs;
  String? createdAt;
  int? businessCategoriesId;
  bool? enabled;
  String? productsName;
  String? warranty;
  String? disabledAt;
  String? updatedAt;
  BusinessCategory? businessCategory;
  Trader? trader;
  List<AvailableYears>? availableYears;
  List<ProductRating>? productRating;
  int? averageRate;
  int? rateCount;
  RatePercentage? ratePercentage;
  bool? inCart;
  bool? inFavourite;


  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    traderId = json['trader_id'];
    description = json['description'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    brandName = json['brand_name'];
    if (json['address'] != null) {
      address = List<Map<String, String>>.from(json['address'].map((x) => Map<String, String>.from(x)));
    }
    productsImg = json['products_img'];
    madeIn = json['madeIn'];
    price = json['price'];
    isOffer = json['is_offer'];
    offerPrice = json['offer_price'];
    offerStartDate = json['offer_start_date'];
    offerEndDate = json['offer_end_date'];
    rating = json['rating'];
    reviewCount = json['review_count'];
    type = json['type'];
    isBestSeller = json['is_best_seller'];
    isMobilawy = json['is_mobilawy'];
    assemblyKit = json['assembly_kit'];
    productLine = json['product_line'];
    frontOrRear = json['frontOrRear'];
    tyreSpeedRate = json['tyre_speed_rate'];
    maximumTyreLoad = json['maximum_tyre_load'];
    tyreEngraving = json['tyre_engraving'];
    rimDiameter = json['rim_diameter'];
    tyreHeight = json['tyre_height'];
    tyreWidth = json['tyre_width'];
    kilometer = json['kilometer'];
    oilType = json['oil_type'];
    batteryReplacementAvailable = json['battery_replacement_available'];
    volt = json['volt'];
    ampere = json['ampere'];
    liter = json['liter'];
    color = json['color'];
    numberSparkPulgs = json['Number_spark_pulgs'];
    createdAt = json['created_at'];
    businessCategoriesId = json['businessCategories_id'];
    enabled = json['enabled'];
    productsName = json['products_name'];
    warranty = json['warranty'];
    disabledAt = json['disabled_at'];
    updatedAt = json['updated_at'];
    businessCategory = json['businessCategory'] != null
        ?  BusinessCategory.fromJson(json['businessCategory'])
        : null;
    trader =
    json['trader'] != null ?  Trader.fromJson(json['trader']) : null;
    if (json['availableYears'] != null) {
      availableYears = <AvailableYears>[];
      json['availableYears'].forEach((v) {
        availableYears!.add( AvailableYears.fromJson(v));
      });
    }
    if (json['productRating'] != null) {
      productRating = <ProductRating>[];
      json['productRating'].forEach((v) {
        productRating!.add( ProductRating.fromJson(v));
      });
    }
    averageRate = json['averageRate'];
    rateCount = json['rateCount'];
    ratePercentage = json['ratePercentage'] != null
        ?  RatePercentage.fromJson(json['ratePercentage'])
        : null;
    inCart = json['inCart'];
    inFavourite = json['inFavourite'];
  }


}

class BusinessCategory {
  String? bcNameEn;
  String? bcNameAr;
  Business? business;


  BusinessCategory.fromJson(Map<String, dynamic> json) {
    bcNameEn = json['bc_name_en'];
    bcNameAr = json['bc_name_ar'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
  }

}

class Business {
  String? businessNameEn;
  String? businessNameAr;


  Business.fromJson(Map<String, dynamic> json) {
    businessNameEn = json['business_name_en'];
    businessNameAr = json['business_name_ar'];
  }


}

class Trader {
  String? type;

  Trader.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }


}

class AvailableYears {
  int? id;
  int? availableYear;
  int? carModelId;
  CarModel? carModel;


  AvailableYears.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    availableYear = json['available_year'];
    carModelId = json['carModelId'];
    carModel = json['carModel'] != null
        ? new CarModel.fromJson(json['carModel'])
        : null;
  }

}

class CarModel {
  int? id;
  String? modelName;
  int? carId;
  Car? car;


  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelName = json['model_name'];
    carId = json['carId'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
  }

}

class Car {
  int? id;
  String? carName;


  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carName = json['car_name'];
  }


}

class ProductRating {
  int? ratingNum;
  String? review;
  User? user;


  ProductRating.fromJson(Map<String, dynamic> json) {
    ratingNum = json['ratingNum'];
    review = json['review'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  String? userName;


  User.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
  }


}

class RatePercentage {
  int? oneStar;
  int? twoStar;
  int? threeStar;
  int? fourStar;
  int? fiveStar;


  RatePercentage.fromJson(Map<String, dynamic> json) {
    oneStar = json['oneStar'];
    twoStar = json['twoStar'];
    threeStar = json['threeStar'];
    fourStar = json['fourStar'];
    fiveStar = json['fiveStar'];
  }


}