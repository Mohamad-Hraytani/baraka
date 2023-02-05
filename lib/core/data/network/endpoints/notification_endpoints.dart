import 'package:albarakakitchen/core/data/network/network_constants.dart';

class NotificationEndpoint {
  static String getUserNotifications =
      NetworkConstants.getFullURL('Notification/GetUserNotifications');
  static String updateDeviceToken =
      NetworkConstants.getFullURL('Notification/UpdateDeviceToken');
  static String deleteNotification =
      NetworkConstants.getFullURL('Notification/Delete');
}
