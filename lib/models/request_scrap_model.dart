class RequestScrapModel {
  Scrap? scrap;

  RequestScrapModel.fromJson(Map<String, dynamic> json) {
    scrap = json['scrap'] != null ? new Scrap.fromJson(json['scrap']) : null;
  }


}

class Scrap {
  int? id;
  int? userId;
  String? description;
  String? status;
  String? response;
  String? createdAt;
  String? responseAt;



  Scrap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    status = json['status'];
    response = json['response'];
    createdAt = json['created_at'];
    responseAt = json['response_at'];
  }


}