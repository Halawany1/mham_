class NotificationModel {
  int? unreadedCount;
  int? totalPages;
  int? page;
  int? pageSize;
  int? pageCount;
  List<Notifications>? notifications;



  NotificationModel.fromJson(Map<String, dynamic> json) {
    unreadedCount = json['unreadedCount'];
    totalPages = json['totalPages'];
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }


}

class Notifications {
  int? id;
  String? title;
  String? body;
  String? createdAt;
  bool? isReaded;
  String? expiresAt;
  int? userId;
  User? user;



  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];
    isReaded = json['isReaded'];
    expiresAt = json['expires_at'];
    userId = json['userId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }


}

class User {
  int? id;
  String? userName;
  String? mobile;
  String? password;
  int? countryId;
  String? role;



  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    password = json['password'];
    countryId = json['country_id'];
    role = json['role'];
  }


}