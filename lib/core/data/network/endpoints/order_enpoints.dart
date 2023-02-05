import 'package:albarakakitchen/core/data/network/network_constants.dart';

class OrdersEndpoints {
  static String getAllTechOrders =
      NetworkConstants.getFullURL('Order/GetAllTechOrders');
  static String masuringVisit =
      NetworkConstants.getFullURL('Order/MeasuringVisit');
  static String installingVisit =
      NetworkConstants.getFullURL('Order/InstallingVisit');
  static String installingSuccessfully =
      NetworkConstants.getFullURL('Order/InstallingSuccessfully');
  static String installingWithIssue =
      NetworkConstants.getFullURL('Order/InstallingWithIssue');
  static String requestInstallingWithIssue =
      NetworkConstants.getFullURL('MaintenanceRequesApp/InstallingWithIssue');
  static String getAllMaintenanceRequest =
      NetworkConstants.getFullURL('MaintenanceRequesApp/GetAllTechRequests');
  static String insertBeforeProcessImages =
      NetworkConstants.getFullURL('MaintenanceRequesApp/InsertBeforeProcessImages');
  static String completeRequestProcess =
      NetworkConstants.getFullURL('MaintenanceRequesApp/CompleteRequestProcess');
}


