class OrderModel {
  List<Orders>? orders;
  int? totalPages;
  int? currentPage;
  int? totalOrders;


  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    totalOrders = json['totalOrders'];
  }


}

class Orders {
  int? orderId;
  int? driverId;
  int? userId;
  String? status;
  String? anotherMobile;
  List<Address>? address;
  String? createdAt;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? cancelledAt;
  List<Carts>? carts;



  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    driverId = json['driver_id'];
    userId = json['user_id'];
    status = json['status'];
    anotherMobile = json['another_mobile'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    processingAt = json['processing_at'];
    shippedAt = json['shipped_at'];
    deliveredAt = json['delivered_at'];
    cancelledAt = json['cancelled_at'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
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

class Carts {
  int? cartId;
  int? userId;
  dynamic totalPrice;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? orderId;
  List<CartProducts>? cartProducts;


  Carts.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    orderId = json['order_id'];
    if (json['cartProducts'] != null) {
      cartProducts = <CartProducts>[];
      json['cartProducts'].forEach((v) {
        cartProducts!.add(new CartProducts.fromJson(v));
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
  List<ReturnProduct>? returnProduct;
  String ?status;


  CartProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['returnProduct'] != null) {
      returnProduct = <ReturnProduct>[];
      json['returnProduct'].forEach((v) {
        returnProduct!.add(new ReturnProduct.fromJson(v));
      });
    }
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
  int? numberSparkPulgs;
  String? createdAt;
  int? businessCategoriesId;
  bool? enabled;
  String? productsName;
  String? warranty;
  String? disabledAt;
  String? updatedAt;
  BusinessCategory? businessCategory;
  List<AvailableYears>? availableYears;
  dynamic averageRate;

  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    averageRate = json['averageRate'];
    traderId = json['trader_id'];
    description = json['description'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    brandName = json['brand_name'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
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
    if (json['availableYears'] != null) {
      availableYears = <AvailableYears>[];
      json['availableYears'].forEach((v) {
        availableYears!.add(new AvailableYears.fromJson(v));
      });
    }
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
        ?  CarModel.fromJson(json['carModel'])
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

class ReturnProduct {
  int? id;
  int? quantity;
  String? reason;
  String? response;
  String? createdAt;
  String? status;
  String? approvedAt;
  String? rejectedAt;
  String? arrivedAt;


  ReturnProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    reason = json['reason'];
    response = json['response'];
    createdAt = json['created_at'];
    status = json['status'];
    approvedAt = json['approvedAt'];
    rejectedAt = json['rejectedAt'];
    arrivedAt = json['arrivedAt'];
  }


}