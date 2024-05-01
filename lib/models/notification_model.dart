class NotificationModel {
  List<Notifications>? notifications;

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  Null? traderId;
  Null? driverId;
  User? user;


  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    traderId = json['traderId'];
    driverId = json['driverId'];
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