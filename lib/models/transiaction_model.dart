class TransiactionModel {
  int? totalItems;
  int? totalPages;
  int? page;
  int? pageSize;
  int? pageCount;
  List<Transactions>? transactions;

  TransiactionModel.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

}

class Transactions {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? userOrderId;
  int? amount;
  String? currency;
  User? user;
  UserOrder? userOrder;



  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    userOrderId = json['userOrderId'];
    amount = json['amount'];
    currency = json['currency'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    userOrder = json['userOrder'] != null
        ? new UserOrder.fromJson(json['userOrder'])
        : null;
  }


}

class User {
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
  String? verifyMobileOtp;
  String? verifyMobileOtpExp;
  String? resetPasswordOtp;
  String? resetPasswordOtpExp;



  User.fromJson(Map<String, dynamic> json) {
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
    deletedAt = json['deletedAt'];
    verifyMobileOtp = json['verifyMobileOtp'];
    verifyMobileOtpExp = json['verifyMobileOtpExp'];
    resetPasswordOtp = json['resetPasswordOtp'];
    resetPasswordOtpExp = json['resetPasswordOtpExp'];
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
  int? totalPrice;
  String? status;
  String? processingAt;
  String? shippedAt;
  String? deliveredAt;
  String? cancelledAt;
  String? cancelReason;
  bool? isPaid;
  String? cancelledBy;
  String? cancelStatus;
  String? chargeId;



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
    chargeId = json['chargeId'];
  }


}