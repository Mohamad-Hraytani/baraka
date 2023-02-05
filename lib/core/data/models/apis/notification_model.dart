import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';

class NotificationModel {
  String? title;
  String? message;
  String? code;
  bool? isRead;
  String? date;
  String? time;
  OrderModel? order;
  MaintenanceRequest? request;
  String? id;

  NotificationModel(
      {this.title,
      this.message,
      this.code,
      this.isRead,
      this.date,
      this.time,
      this.order,
      this.request,
      this.id});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    code = json['code'];
    isRead = json['isRead'];
    date = json['date'];
    time = json['time'];
    order =
        json['order'] != null ? new OrderModel.fromJson(json['order']) : null;
    request = json['request'] != null
        ? new MaintenanceRequest.fromJson(json['request'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['code'] = this.code;
    data['isRead'] = this.isRead;
    data['date'] = this.date;
    data['time'] = this.time;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}
