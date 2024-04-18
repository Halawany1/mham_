class RequestScrapModel {
  String? message;
  CreateScrap? createScrap;

  RequestScrapModel({this.message, this.createScrap});

  RequestScrapModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createScrap = json['createScrap'] != null
        ? new CreateScrap.fromJson(json['createScrap'])
        : null;
  }


}

class CreateScrap {
  int? id;
  int? userId;
  String? description;
  String? response;
  String? createdAt;
  String? responseAt;


  CreateScrap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    response = json['response'];
    createdAt = json['created_at'];
    responseAt = json['response_at'];
  }

}