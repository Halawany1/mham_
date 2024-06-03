class DriverOrderByIdModel {
  Order? order;

  DriverOrderByIdModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }
}

class Order {
  int? id;
  int? customerId;
  int? driverId;
  String? createdAt;
  String? updatedAt;
  bool? driverAssigned;
  String? anotherMobile;
  String? address;
  String? location;
  dynamic totalPrice;
  String? status;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? cancelledAt;
  String? cancelReason;
  bool? isPaid;
  String? cancelledBy;
  String? cancelStatus;
  Customer? customer;
  Driver? driver;
  List<OrderItems>? orderItems;
  List<dynamic>? returnProducts;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    driverId = json['driverId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    driverAssigned = json['driverAssigned'];
    anotherMobile = json['anotherMobile'];
    address = json['address'];
    location = json['location'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    processingAt = json['processingAt'];
    shippedAt = json['shippedAt'];
    deliveredAt = json['deliveredAt'];
    cancelledAt = json['cancelledAt'];
    cancelReason = json['cancelReason'];
    isPaid = json['isPaid'];
    cancelledBy = json['cancelledBy'];
    cancelStatus = json['cancelStatus'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    returnProducts = json['returnProducts'];
  }
}

class Customer {
  int? id;
  String? userName;
  String? mobile;
  String? password;
  int? countryId;
  String? role;
  String? avatar;
  String? email;
  String? address;
  String? createdAt;
  Country? country;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    role = json['role'];
    avatar = json['avatar'];
    email = json['email'];
    address = json['address'];
    createdAt = json['createdAt'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
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

class Driver {
  int? id;
  int? userId;
  String? createdAt;
  String? updatedAt;
  String? address;
  String? drivingLicence;
  String? email;
  String? status;
  Customer? user;

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    address = json['address'];
    drivingLicence = json['drivingLicence'];
    email = json['email'];
    status = json['status'];
    user = json['user'] != null ? Customer.fromJson(json['user']) : null;
  }
}

class OrderItems {
  int? id;
  int? subOrderId;
  int? userOrderId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  int? actualQuantity;
  dynamic unitPrice;
  String? status;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? cancelledAt;
  String? cancelStatus;
  String? cancelReason;
  String? cancelImage;
  List<dynamic>? returnProducts;
  Product? product;

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subOrderId = json['subOrderId'];
    userOrderId = json['userOrderId'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    quantity = json['quantity'];
    actualQuantity = json['actualQuantity'];
    unitPrice = json['unitPrice'];
    status = json['status'];
    processingAt = json['processingAt'];
    shippedAt = json['shippedAt'];
    deliveredAt = json['deliveredAt'];
    cancelledAt = json['cancelledAt'];
    cancelStatus = json['cancelStatus'];
    cancelReason = json['cancelReason'];
    cancelImage = json['cancelImage'];
    returnProducts = json['returnProducts'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? productsId;
  int? traderId;
  String? description;
  String? manufacturerPartNumber;
  String? brandName;
  List<Address>? address;
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
  int? numberSparkPlugs;
  String? createdAt;
  int? businessCategoriesId;
  bool? enabled;
  String? productsName;
  String? warranty;
  String? disabledAt;
  String? updatedAt;
  String? status;
  int? qtyInStock;
  Trader? trader;
  List<AvailableYears>? availableYears;
  BusinessCategory? businessCategory;
  List<ProductRating>? productRating;

  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    traderId = json['trader_id'];
    description = json['description'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    brandName = json['brand_name'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
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
    numberSparkPlugs = json['Number_spark_plugs'];
    createdAt = json['created_at'];
    businessCategoriesId = json['businessCategories_id'];
    enabled = json['enabled'];
    productsName = json['products_name'];
    warranty = json['warranty'];
    disabledAt = json['disabled_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    qtyInStock = json['qty_in_stock'];
    trader = json['trader'] != null ? Trader.fromJson(json['trader']) : null;
    if (json['available_years'] != null) {
      availableYears = <AvailableYears>[];
      json['available_years'].forEach((v) {
        availableYears!.add(AvailableYears.fromJson(v));
      });
    }
    businessCategory = json['businessCategory'] != null
        ? BusinessCategory.fromJson(json['businessCategory'])
        : null;
    if (json['product_rating'] != null) {
      productRating = <ProductRating>[];
      json['product_rating'].forEach((v) {
        productRating!.add(ProductRating.fromJson(v));
      });
    }
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

class Trader {
  int? traderId;
  int? userId;
  int? businessId;
  String? brandName;
  String? brandImg;
  String? commercialCertificate;
  String? type;
  String? createdAt;
  String? status;
  String? fcmToken;
  Customer? user;



  Trader.fromJson(Map<String, dynamic> json) {
    traderId = json['trader_id'];
    userId = json['user_id'];
    businessId = json['business_id'];
    brandName = json['brand_name'];
    brandImg = json['brand_img'];
    commercialCertificate = json['commercial_certificate'];
    type = json['type'];
    createdAt = json['createdAt'];
    status = json['status'];
    fcmToken = json['fcmToken'];
    user = json['user'] != null ? new Customer.fromJson(json['user']) : null;
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
  String? bcNameEn;
  String? bcNameAr;


  BusinessCategory.fromJson(Map<String, dynamic> json) {
    bcNameEn = json['bc_name_en'];
    bcNameAr = json['bc_name_ar'];
  }


}

class ProductRating {
  dynamic ratingNum;

  ProductRating.fromJson(Map<String, dynamic> json) {
    ratingNum = json['ratingNum'];
  }


}