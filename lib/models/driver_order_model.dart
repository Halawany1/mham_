class DriverOrderModel {
  int? totalPages;
  int? page;
  int? pageSize;
  int? pageCount;
  List<Orders>? orders;

  DriverOrderModel.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add( Orders.fromJson(v));
      });
    }
  }


}

class Orders {
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
  String? driver;


  Orders.fromJson(Map<String, dynamic> json) {
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

// class Customer {
//   int? id;
//   String? userName;
//   String? mobile;
//   String? password;
//   int? countryId;
//   String? role;
//
//
//
//   Customer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userName = json['user_name'];
//     mobile = json['mobile'];
//     password = json['password'];
//     countryId = json['country_id'];
//     role = json['role'];
//   }
//
//
// }

// class OrderItems {
//   int? id;
//   int? subOrderId;
//   int? userOrderId;
//   int? productId;
//   String? createdAt;
//   String? updatedAt;
//   int? quantity;
//   dynamic unitPrice;
//   String? status;
//   String? processingAt;
//   String? shippedAt;
//   String? deliveredAt;
//   String? cancelledAt;
//
//
//
//
//   OrderItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     subOrderId = json['subOrderId'];
//     userOrderId = json['userOrderId'];
//     productId = json['productId'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     quantity = json['quantity'];
//     unitPrice = json['unitPrice'];
//     status = json['status'];
//     processingAt = json['processingAt'];
//     shippedAt = json['shippedAt'];
//     deliveredAt = json['deliveredAt'];
//     cancelledAt = json['cancelledAt'];
//
//   }
//
//
// }
