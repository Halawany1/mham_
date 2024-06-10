class ReturnOrderModel {
  String? type;
  ActiveOrder? activeOrder;

  ReturnOrderModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    activeOrder = json['activeOrder'] != null
        ?  ActiveOrder.fromJson(json['activeOrder'])
        : null;
  }


}

class ActiveOrder {
  int? id;
  int? userOrderId;
  int? customerId;
  int? driverId;
  bool? driverAssigned;
  String? createdAt;
  String? updatedAt;
 dynamic totalPrice;
  bool? isAccepted;
  String? status;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? location;
  String? address;
  String? cancelledAt;
  Customer? customer;
  UserOrder? userOrder;
  List<OrderItems>? orderItems;



  ActiveOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userOrderId = json['userOrderId'];
    address = json['address'];
    customerId = json['customerId'];
    driverId = json['driverId'];
    location = json['location'];
    driverAssigned = json['driverAssigned'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    totalPrice = json['totalPrice'];
    isAccepted = json['isAccepted'];
    status = json['status'];
    processingAt = json['processingAt'];
    shippedAt = json['shippedAt'];
    deliveredAt = json['deliveredAt'];
    cancelledAt = json['cancelledAt'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    userOrder = json['userOrder'] != null
        ?  UserOrder.fromJson(json['userOrder'])
        : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add( OrderItems.fromJson(v));
      });
    }
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
  String? deletedAt;
  // String? verifyMobileOtp;
  // String? verifyMobileOtpExp;
  // String? resetPasswordOtp;
  // String? resetPasswordOtpExp;

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    // password = json['password'];
    // countryId = json['country_id'];
    // role = json['role'];
    // avatar = json['avatar'];
    // email = json['email'];
    // address = json['address'];
    // createdAt = json['createdAt'];
    // deletedAt = json['deletedAt'];
    // verifyMobileOtp = json['verifyMobileOtp'];
    // verifyMobileOtpExp = json['verifyMobileOtpExp'];
    // resetPasswordOtp = json['resetPasswordOtp'];
    // resetPasswordOtpExp = json['resetPasswordOtpExp'];
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
  String? cancelledBy;
  String? cancelStatus;


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
    cancelledBy = json['cancelledBy'];
    cancelStatus = json['cancelStatus'];
  }


}

class OrderItems {
  int? id;
  int? customerId;
  int? orderItemId;
  int? returnOrderId;
  int? quantity;
  String? reason;
  String? response;
  String? createdAt;
  String? updatedAt;
  bool? isAccepted;
  String? status;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? cancelledAt;
  OriginalOrderItem? originalOrderItem;
  Product? product;


  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    orderItemId = json['orderItemId'];
    returnOrderId = json['returnOrderId'];
    quantity = json['quantity'];
    reason = json['reason'];
    response = json['response'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isAccepted = json['isAccepted'];
    status = json['status'];
    processingAt = json['processingAt'];
    shippedAt = json['shippedAt'];
    deliveredAt = json['deliveredAt'];
    cancelledAt = json['cancelledAt'];
    originalOrderItem = json['originalOrderItem'] != null
        ?  OriginalOrderItem.fromJson(json['originalOrderItem'])
        : null;
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class OriginalOrderItem {
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
  Product? product;


  OriginalOrderItem.fromJson(Map<String, dynamic> json) {
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
  List<Address>? address;
  String? productsImg;
  String? madeIn;
  dynamic price;
  bool? isOffer;
  int? offerPrice;
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
  String? numberSparkPulgs;
  String? createdAt;
  int? businessCategoriesId;
  bool? enabled;
  String? productsName;
  String? warranty;
  String? disabledAt;
  String? updatedAt;
  String? deletedAt;
  String? status;
  int? qtyInStock;
  Trader? trader;


  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['products_id'];
    traderId = json['trader_id'];
    description = json['description'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    brandName = json['brand_name'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add( Address.fromJson(v));
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
    deletedAt = json['deletedAt'];
    status = json['status'];
    qtyInStock = json['qtyInStock'];
    trader =
    json['trader'] != null ?  Trader.fromJson(json['trader']) : null;
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
  String? deletedAt;
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
    deletedAt = json['deletedAt'];
    status = json['status'];
    fcmToken = json['fcmToken'];
    user = json['user'] != null ? new Customer.fromJson(json['user']) : null;
  }


}
class Address {
  String? address;
  String? location;

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address']??'No Address';
    location = json['location']??'No Location';
  }


}