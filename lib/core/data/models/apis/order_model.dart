class OrderModel {
  Client? client;
  String? id;
  String? city;
  String? neighborhood;
  String? visitDate;
  String? visitTime;
  bool? canUpdateMeasurment;
  String? orderCode;
  String? localizedVisitPeriod;
  Actions? actions;

  OrderModel(
      {this.client,
      this.city,
      this.neighborhood,
      this.localizedVisitPeriod,
      this.id,
      this.visitDate,
      this.orderCode,
      this.canUpdateMeasurment,
      this.visitTime,
      this.actions});

  OrderModel.fromJson(Map<String, dynamic> json) {
    client =
        json['client'] != null ? new Client.fromJson(json['client']) : null;
    city = json['city'] == null ? null : json['city'];
    neighborhood = json['neighborhood'] == null ? null : json['neighborhood'];
    visitDate = json['visitDate'];
    visitTime = json['visitTime'];
    orderCode = json['orderCode'];
    id = json['id'];
    canUpdateMeasurment = json['canUpdateMeasurment'];
    localizedVisitPeriod = json['localizedVisitPeriod'];
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
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['city'] = this.city;
    data['neighborhood'] = this.neighborhood;
    data['orderCode'] = this.orderCode;
    data['visitDate'] = this.visitDate;
    data['visitTime'] = this.visitTime;
    data['canUpdateMeasurment'] = this.canUpdateMeasurment;
    data['localizedVisitPeriod'] = this.localizedVisitPeriod;
    if (this.actions != null) {
      data['actions'] = this.actions!.toJson();
    }
    return data;
  }
}

class Client {
  String? id;
  String? firstName;
  String? sureName;
  String? phoneNumber;

  Client({this.id, this.firstName, this.sureName, this.phoneNumber});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    sureName = json['sureName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['sureName'] = this.sureName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class Actions {
  Map<String, bool>? actionMap;

  Actions({this.actionMap});

  Actions.fromJson(List<dynamic> json) {
    actionMap = {};
    json.forEach((v) {
      actionMap!.putIfAbsent(v['actionId'], () => v['isActive']);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionList'] = this.actionMap;

    return data;
  }

  bool get getAssignToMeasuringTech {
    return actionMap!["AssignToMeasuringTech"] ?? false;
  }

  bool get getUpdateOrderVisitDate {
    return actionMap!["UpdateOrderVisitDate"] ?? false;
  }

  bool get getOrdersOrderContractRegistration {
    return actionMap!["Orders.OrderContractRegistration"] ?? false;
  }

  bool get getOrdersApprove {
    return actionMap!["Orders.Approve"] ?? false;
  }

  bool get getOrdersRejectOrder {
    return actionMap!["Orders.RejectOrder"] ?? false;
  }

  bool get getOrdersRequestOrderUpdate {
    return actionMap!["Orders.RequestOrderUpdate"] ?? false;
  }

  bool get getOrdersApproveOrderForPrepration {
    return actionMap!["Orders.ApproveOrderForPrepration"] ?? false;
  }

  bool get getOrdersProcessOrderManualPayment {
    return actionMap!["Orders.ProcessOrderManualPayment"] ?? false;
  }

  bool get getOrdersAssignDeliverDate {
    return actionMap!["Orders.AssignDeliverDate"] ?? false;
  }

  bool get getOrdersAssignToInstallingTech {
    return actionMap!["Orders.AssignToInstallingTech"] ?? false;
  }

  bool get getOrdersStartInstaillingProcess {
    return actionMap!["Orders.StartInstaillingProcess"] ?? false;
  }

  set setOrdersStartInstaillingProcess(bool val) {
    actionMap!["Orders.StartInstaillingProcess"] = val;
  }

  bool get getOrdersCompleteInstallingProcess {
    return actionMap!["Orders.CompleteInstallingProcess"] ?? false;
  }

  set setOrdersCompleteInstallingProcess(bool val) {
    actionMap!["Orders.CompleteInstallingProcess"] = val;
  }

  bool get getOrdersReportInstallationIssue {
    return actionMap!["Orders.ReportInstallationIssue"] ?? false;
  }

  set setOrdersReportInstallationIssue(bool val) {
    actionMap!["Orders.ReportInstallationIssue"] = val;
  }

  bool get getOrdersUpdateOrderMeasurement {
    return actionMap!["Orders.UpdateOrderMeasurement"] ?? false;
  }

  bool get getRequestInsertBeforeProcessImages {
    return actionMap!["Maintenance.InsertBeforeProcessImages"] ?? false;
  }

  bool get getRequestInsertAfterProcessImages {
    return actionMap!["Maintenance.InsertAfterProcessImages"] ?? false;
  }

  bool get getRequestReportInstallationIssue {
    return actionMap!["Maintenance.ReportInstallationIssue"] ?? false;
  }
}
