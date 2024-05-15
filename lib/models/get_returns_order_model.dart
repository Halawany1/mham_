class GetReturnsProduct {
  int? totalPages;
  int? page;
  int? pageSize;
  int? pageCount;
  List<ReturnProducts>? returnProducts;


  GetReturnsProduct.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    if (json['returnProducts'] != null) {
      returnProducts = <ReturnProducts>[];
      json['returnProducts'].forEach((v) {
        returnProducts!.add(new ReturnProducts.fromJson(v));
      });
    }
  }

}

class ReturnProducts {
  int? id;
  int? customerId;
  int? orderItemId;
  int? quantity;
  String? reason;
  String? response;
  String? createdAt;
  String? updatedAt;
  String? approvedAt;
  String? arrivedAt;
  String? rejectedAt;
  String? status;
  Customer? customer;
  OrderItem? orderItem;


  ReturnProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    orderItemId = json['orderItemId'];
    quantity = json['quantity'];
    reason = json['reason'];
    response = json['response'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    approvedAt = json['approvedAt'];
    arrivedAt = json['arrivedAt'];
    rejectedAt = json['rejectedAt'];
    status = json['status'];
    customer = json['customer'] != null
        ?  Customer.fromJson(json['customer'])
        : null;
    orderItem = json['orderItem'] != null
        ?  OrderItem.fromJson(json['orderItem'])
        : null;
  }


}

class Customer {
  int? id;
  String? userName;
  String? mobile;
  String? password;
  int? countryId;
  String? role;



  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    role = json['role'];
  }

}

class OrderItem {
  int? id;
  int? subOrderId;
  int? userOrderId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  double? unitPrice;
  String? status;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? cancelledAt;
  String? cancelReason;
  String? cancelImage;
  Product? product;
  UserOrder? userOrder;



  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subOrderId = json['subOrderId'];
    userOrderId = json['userOrderId'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    status = json['status'];
    processingAt = json['processingAt'];
    shippedAt = json['shippedAt'];
    deliveredAt = json['deliveredAt'];
    cancelledAt = json['cancelledAt'];
    cancelReason = json['cancelReason'];
    cancelImage = json['cancelImage'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    userOrder = json['userOrder'] != null
        ?  UserOrder.fromJson(json['userOrder'])
        : null;
  }

}

class Product {
  int? productsId;
  int? traderId;
  String? description;
  String? manufacturerPartNumber;
  String? brandName;
  String? address;
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
  String? status;
  int? qtyInStock;


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
    status = json['status'];
    qtyInStock = json['qtyInStock'];
  }

}

class UserOrder {
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


  UserOrder.fromJson(Map<String, dynamic> json) {
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
  }


}