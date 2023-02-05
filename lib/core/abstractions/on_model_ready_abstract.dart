import '../utils/general_utils.dart';
import 'package:stacked/stacked.dart';

mixin BaseViewModelExt on BaseViewModel {
  ///Concatenate api calls
  Future concatenatedApiCalls() async {}

  ///onModelReady
  void onModelReady() {
    runBusyFutureWithLoader(runBusyFuture(concatenatedApiCalls()));
  }

  ///Must be called on model closed
  void onClose() {}
}

mixin ReactiveViewModelExt on ReactiveViewModel {
  ///Concatenate api calls
  Future concatenatedApiCalls() async {}

  ///onModelReady
  void onModelReady() {
    runBusyFutureWithLoader(runBusyFuture(concatenatedApiCalls()));
  }

  ///Must be called on model closed
  void onClose() {}
}
