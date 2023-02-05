import 'package:albarakakitchen/core/data/models/apis/order_model.dart';

class MaintenanceRequest {
  String? id;
  Client? client;
  String? address;
  String? contractNumber;
  String? contractDate;
  String? requestStatus;
  String? requestStatusLocalized;
  String? requestIssueDetails;
  String? createdOn;
  Actions? actions;

  MaintenanceRequest(
      {this.id,
      this.client,
      this.address,
      this.contractNumber,
      this.contractDate,
      this.requestStatus,
      this.requestStatusLocalized,
      this.requestIssueDetails,
      this.createdOn,
      this.actions});

  MaintenanceRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    address = json['address'];
    contractNumber = json['contractNumber'];
    contractDate = json['contractDate'];
    requestStatus = json['requestStatus'];
    requestStatusLocalized = json['requestStatusLocalized'];
    requestIssueDetails = json['requestIssueDetails'] ?? '';
    createdOn = json['createdOn'];
    if (json['actions'] != null) {
      // actions = Actions>[];
      actions = Actions.fromJson(json['actions']);
      // json['actions'].forEach((v) {
      //   actions!.add(new Actions.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['address'] = this.address;
    data['contractNumber'] = this.contractNumber;
    data['contractDate'] = this.contractDate;
    data['requestStatus'] = this.requestStatus;
    data['requestStatusLocalized'] = this.requestStatusLocalized;
    data['requestIssueDetails'] = this.requestIssueDetails;
    data['createdOn'] = this.createdOn;

    return data;
  }
}

class Client {
  String? id;
  String? firstName;
  String? sureName;
  String? phoneNumber;
  String? loginId;

  Client(
      {this.id, this.firstName, this.sureName, this.phoneNumber, this.loginId});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    sureName = json['sureName'];
    phoneNumber = json['phoneNumber'];
    loginId = json['loginId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['sureName'] = this.sureName;
    data['phoneNumber'] = this.phoneNumber;
    data['loginId'] = this.loginId;
    return data;
  }
}
