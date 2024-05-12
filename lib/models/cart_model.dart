class CartModel {
  Cart? cart;

  CartModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ?
    Cart.fromJson(json['cart']) : null;
  }

}

class Cart {
  int? cartId;
  int? userId;
  dynamic totalPrice;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? orderId;
  List<CartProducts>? cartProducts;



  Cart.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    userId = json['userId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['cartItems'] != null) {
      cartProducts = <CartProducts>[];
      json['cartItems'].forEach((v) {
        cartProducts!.add( CartProducts.fromJson(v));
      });
    }
  }


}

class CartProducts {
  int? id;
  int? cartId;
  int? productId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;


  CartProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cartId'];
    productId = json['productId'];
    quantity = json['quantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
//  List<Address>? address;
  String? productsImg;
  String? madeIn;
  dynamic price;
  bool? isOffer;
  dynamic offerPrice;
  String? offerStartDate;
  String? offerEndDate;
  dynamic averageRate;
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
  int? rateCount;

  List<AvailableYears>? availableYears;
  BusinessCategory? businessCategory;
  RatePercentage? ratePercentage;
  String? status;
  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    traderId = json['trader_id'];
    status = json['status'];
    rateCount = json['rateCount'];
    description = json['description'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    brandName = json['brand_name'];
    // if (json['address'] != null) {
    //   address = <Address>[];
    //   json['address'].forEach((v) {
    //     address!.add(new Address.fromJson(v));
    //   });
    // }
    productsImg = json['products_img'];
    madeIn = json['madeIn'];
    price = json['price'];
    isOffer = json['is_offer'];
    offerPrice = json['offer_price'];
    offerStartDate = json['offer_start_date'];
    offerEndDate = json['offer_end_date'];
    averageRate = json['rating'];
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
    if (json['availableYears'] != null) {
      availableYears = <AvailableYears>[];
      json['availableYears'].forEach((v) {
        availableYears!.add(new AvailableYears.fromJson(v));
      });
    }
    businessCategory = json['businessCategory'] != null
        ? new BusinessCategory.fromJson(json['businessCategory'])
        : null;
  }

}

class Address {
  String? address;
  String? location;


  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    location = json['location'];
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

class BusinessCategory {
  String? bcNameAr;
  String? bcNameEn;


  BusinessCategory.fromJson(Map<String, dynamic> json) {
    bcNameAr = json['bc_name_ar'];
    bcNameEn = json['bc_name_en'];
  }


}

class RatePercentage {
  dynamic oneStar;
  dynamic twoStar;
  dynamic threeStar;
  dynamic fourStar;
  dynamic fiveStar;


  RatePercentage.fromJson(Map<String, dynamic> json) {
    oneStar = json['oneStar'];
    twoStar = json['twoStar'];
    threeStar = json['threeStar'];
    fourStar = json['fourStar'];
    fiveStar = json['fiveStar'];
  }
}