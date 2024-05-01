class ProductRatingModel {
  int? totalPages;
  int? limit;
  List<Rating>? products;


  ProductRatingModel.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    limit = json['limit'];
    if (json['products'] != null) {
      products = <Rating>[];
      json['products'].forEach((v) {
        products!.add( Rating.fromJson(v));
      });
    }
  }


}

class Rating {
  int? id;
  int? userId;
  int? productId;
  int? ratingNum;
  String? review;
  String? createdAt;
  String? updatedAt;
  Product? product;
  User? user;


  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    ratingNum = json['ratingNum'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class Product {
  int? productsId;
  int? traderId;
  String? description;
  String? manufacturerPartNumber;
  String? brandName;
  String? address;
  Null? productsImg;
  String? madeIn;
  double? price;
  bool? isOffer;
  Null? offerPrice;
  Null? offerStartDate;
  Null? offerEndDate;
  int? rating;
  int? reviewCount;
  String? type;
  bool? isBestSeller;
  bool? isMobilawy;
  bool? assemblyKit;
  String? productLine;
  Null? frontOrRear;
  Null? tyreSpeedRate;
  Null? maximumTyreLoad;
  Null? tyreEngraving;
  Null? rimDiameter;
  Null? tyreHeight;
  Null? tyreWidth;
  int? kilometer;
  String? oilType;
  bool? batteryReplacementAvailable;
  Null? volt;
  Null? ampere;
  int? liter;
  Null? color;
  Null? numberSparkPulgs;
  String? createdAt;
  int? businessCategoriesId;
  bool? enabled;
  String? productsName;
  Null? warranty;
  Null? disabledAt;
  String? updatedAt;



  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    traderId = json['trader_id'];
    description = json['description'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    brandName = json['brand_name'];
    address = json['address'];
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
  }

}

class User {
  int? id;
  String? userName;
  String? mobile;
  String? password;
  int? countryId;
  String? role;
  String? fcmToken;



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    role = json['role'];
    fcmToken = json['fcmToken'];
  }


}