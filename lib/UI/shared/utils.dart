import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';

NavigationService get navigationService => locator<NavigationService>();

String getEnvironment() {
  int env = locator<SharedPreferencesRepository>().getAppEnvironMent();
  if (env == 0) {
    return 'Test';
  } else if (env == 1) {
    return 'Acceptance';
  } else {
    return '';
  }
}

bool get isNotificationsRole =>
    !storage.getLoginInfo().claims!.contains('Technician') &&
    !storage.getLoginInfo().claims!.contains('InstallingTechnician');
