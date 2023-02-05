import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:flutter/cupertino.dart';

class IosKeyboardDoneButtonService {
  static OverlayEntry? _overlayEntry;
  static showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;
    OverlayState? overlayState = Overlay.of(
      context,
    );
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: KeyboardDoneView());
    });

    overlayState!.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

class KeyboardDoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.grey100Color,
      child: Align(
        alignment: Alignment.topRight,
        child: CupertinoButton(
          padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Text("Done",
              style: TextStyle(
                  color: AppColors.blueAccentColor,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
