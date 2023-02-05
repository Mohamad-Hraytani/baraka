import 'dart:developer';
import 'dart:io';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddMeasurementInfoViewModel extends BaseViewModel {
  List<String> measurmentImages = ['add'];
  List<String> kitchenBeforeImages = ['add'];
  List<String> kitchenVideo = ['vid'];
  String actualKitchenHeight = '';
  String wallA = '';
  String wallB = '';
  String wallC = '';
  String wallD = '';
  String washtubCenter = '';
  String visitNotes = '';
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  void addMedia(int type, List<String> imageList) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    if (statuses.containsValue(PermissionStatus.denied) ||
        statuses.containsValue(PermissionStatus.permanentlyDenied)) {
      log('no permission');
    } else {
      if (type == 0) {
        print('object');
        final t = await ImagePicker().pickVideo(
            source: ImageSource.camera, maxDuration: Duration(seconds: 30));
        if (t != null) {
          log(t.path);
          imageList.add(t.path);
          notifyListeners();

          print(t.path);
        } else
          print('object4');
      } else {
        final result = await ImagePicker().pickImage(
          imageQuality: 70,
          maxWidth: 1440,
          source: type == 1 ? ImageSource.camera : ImageSource.gallery,
        );
        if (result != null) {
          log(result.path);
          imageList.add(result.path);
          notifyListeners();

          print(result.path);
        } else {
          // User canceled the picker
        }
      }
    }
  }

  // String? visitNotesValidator(String? val) {
  //   if (val != null && val.isNotEmpty) return null;
  //   return 'please enter notes';
  // }

  String? actualKitchenHeightValidator(String? val) {
    if (val != null && val.isNotEmpty) {
      if (double.tryParse(val) == null) {
        return tr('order_enter_valid_number');
      } else {
        return null;
      }
    }
    return tr('order_enter_kitchen_height');
  }

  visitNotesValidatorOnSave(String? val) {
    if (val != null && val.isNotEmpty) visitNotes = val;
  }

  actualKitchenHeightOnSave(String? val) {
    if (val != null && val.isNotEmpty) actualKitchenHeight = val;
  }

  wallAOnSave(String? val) {
    if (val != null && val.isNotEmpty) wallA = val;
  }

  wallBOnSave(String? val) {
    if (val != null && val.isNotEmpty) wallB = val;
  }

  wallCOnSave(String? val) {
    if (val != null && val.isNotEmpty) wallC = val;
  }

  wallDOnSave(String? val) {
    if (val != null && val.isNotEmpty) wallD = val;
  }

  washtubCenterOnSave(String? val) {
    if (val != null && val.isNotEmpty) washtubCenter = val;
  }

  void measurmentImagesOnCancelClicked(List<String> newImages) {
    measurmentImages = newImages;
    notifyListeners();
  }

  void kitchenBeforeImagesOnCancelClicked(List<String> newImages) {
    kitchenBeforeImages = newImages;
    notifyListeners();
  }

  void kitchenVideoOnCancelClicked(List<String> newImages) {
    kitchenVideo = newImages;
    notifyListeners();
  }

  submit(String orderId) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //  log('$kitchenVideo');
      if (measurmentImages.length <= 1) {
        CustomToasts.showMessage(
            message: tr('order_enter_size_image'),
            messageType: MessageType.errorMessage);
        return;
      }
      if (kitchenBeforeImages.length <= 1) {
        CustomToasts.showMessage(
            message: tr('order_enter_old_image'),
            messageType: MessageType.errorMessage);
        return;
      }
      if (kitchenVideo.length <= 1) {
        CustomToasts.showMessage(
            message: tr('order_enter_old_image'),
            messageType: MessageType.errorMessage);
        return;
      }

      try {
        print('object5');
        customLoader();
        final response = await locator<OrdersRepository>().measuringVisit(
            orderId: orderId,
            measurmentImages: measurmentImages,
            kitchenBeforeImages: kitchenBeforeImages,
            kitchenVideo: kitchenVideo,
            actualKitchenHeight: actualKitchenHeight,
            visitNotes: visitNotes,
            wallASize: wallA,
            wallBSize: wallB,
            wallCSize: wallC,
            wallDSize: wallD,
            washtubCenter: washtubCenter);

        BotToast.closeAllLoading();
        locator<NavigationService>().back(result: true);
        NotificationService.streamController.add('measurement_finished');

        log(response.toString());
      } catch (e) {
        BotToast.closeAllLoading();
        CustomToasts.showMessage(
            message: e.toString(), messageType: MessageType.errorMessage);

        log(e.toString());
      }
    }
  }
}
