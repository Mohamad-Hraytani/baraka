import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:stacked/stacked.dart';

enum AppStartStatusEnum { InternetConnectionProblem, UnknownError, Success }

class SplashScreenViewModel extends BaseViewModel {
  Future loadDependencies() async {
    setBusy(true);

    new Future.delayed(const Duration(seconds: 2), () {
      locator<SharedPreferencesRepository>().getLoggedIn()
          ? isNotificationsRole
              ? navigation.replaceWith(Routes.notificationsView)
              : navigation.replaceWith(Routes.ordersView)
          : navigation.replaceWith(Routes.logInView);
      setBusy(false);
    });
  }
}
