import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text_field.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/shared/profile_view/profile_view_model.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) {
        model.loadProfile();
      },
      builder: (context, model, child) => Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.mainDarkRedColor,
          startWidget: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.whiteColor,
                  size: getIsPhone() ? 25 : 30,
                ),
                SizedBox(
                  width: getIsPhone() ? size.width / 15 : size.height / 15,
                ),
              ],
            ),
          ),
          onStartTap: () {
            navigationService.back();
          },
          onEndTap: () {},
          title: tr('profile_info'),
        ),
        body: model.isBusy
            ? Container()
            : SingleChildScrollView(
                child: getIsPhone()
                    ? getPortiate(size, model)
                    : getLandscape(size, model)),
      ),
    );
  }

  Widget getPortiate(Size size, ProfileViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.height / 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: AppColors.mainLightRedColor,
                    size: 35,
                  ),
                  SizedBox(
                    width: size.height / 50,
                  ),
                  CustomText(
                    content: "${model.profileInfo.displayName}",
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: AppColors.mainLightRedColor,
                    size: 35,
                  ),
                  SizedBox(
                    width: size.height / 50,
                  ),
                  CustomText(
                    content: "${model.profileInfo.username}",
                  )
                ],
              ),
              const SizedBox(height: 10),
              if (model.profileInfo.phoneNumber != null &&
                  model.profileInfo.phoneNumber!.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.mainLightRedColor,
                      size: 35,
                    ),
                    SizedBox(
                      width: size.height / 50,
                    ),
                    CustomText(
                      content: "${model.profileInfo.phoneNumber}",
                    )
                  ],
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.local_activity,
                    color: AppColors.mainLightRedColor,
                    size: 35,
                  ),
                  SizedBox(
                    width: size.height / 50,
                  ),
                  CustomText(
                    content: "${model.profileInfo.role}",
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.width / 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.height / 18),
          width: size.width,
          color: AppColors.mainDarkRedColor,
          height: 1,
        ),
        SizedBox(
          height: size.width / 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      content: tr('change_passwor'),
                      fontSize: size.width / 18,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  borderColor: AppColors.mainDarkRedColor,
                  placeHolderCustomStyle:
                      TextStyle(color: Colors.grey, fontSize: size.width / 25),
                  showPassword: showCurrentPassword,
                  suffixWidget: IconButton(
                      onPressed: () {
                        setState(() {
                          showCurrentPassword = !showCurrentPassword;
                        });
                      },
                      icon: Icon(
                        showCurrentPassword == true
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      )),
                  placeHolder: tr('current_passwor'),
                  textEditingController: model.currentController,
                  validator: (String? val) {
                    if (val != null && val.isNotEmpty) return null;
                    return tr('field_validator');
                  },
                ),
                CustomTextFormField(
                  textEditingController: model.newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  borderColor: AppColors.mainDarkRedColor,
                  placeHolderCustomStyle:
                      TextStyle(color: Colors.grey, fontSize: size.width / 25),
                  showPassword: showNewPassword,
                  suffixWidget: IconButton(
                      onPressed: () {
                        setState(() {
                          showNewPassword = !showNewPassword;
                        });
                      },
                      icon: Icon(
                        showNewPassword == true
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      )),
                  placeHolder: tr('new_passwor'),
                  validator: (String? val) {
                    if (val != null && val.isNotEmpty) return null;
                    return tr('field_validator');
                  },
                ),
                CustomTextFormField(
                  textEditingController: model.confirmController,
                  keyboardType: TextInputType.visiblePassword,
                  borderColor: AppColors.mainDarkRedColor,
                  placeHolderCustomStyle:
                      TextStyle(color: Colors.grey, fontSize: size.width / 25),
                  showPassword: showConfirmPassword,
                  suffixWidget: IconButton(
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      icon: Icon(
                        showConfirmPassword == true
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      )),
                  placeHolder: tr('confirm_passwor'),
                  validator: (String? val) {
                    if (val != null && val.isNotEmpty) return null;
                    return tr('field_validator');
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 0, right: 0, top: size.width / 20, bottom: 20),
                  child: ElevatedButton(
                    child: Container(
                        width: double.infinity,
                        height: size.width / 10,
                        child: Center(
                            child: Text(
                          tr("general_save"),
                          style: TextStyle(fontSize: size.width / 25),
                        ))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // _formKey.currentState!.save();
                        model.changePassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.mainDarkRedColor,
                      onPrimary: Colors.white,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getLandscape(Size size, ProfileViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.height / 20,
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: AppColors.mainLightRedColor,
                    size: 35,
                  ),
                  SizedBox(
                    width: size.height / 50,
                  ),
                  CustomText(
                    content: "${model.profileInfo.displayName}",
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: AppColors.mainLightRedColor,
                    size: 35,
                  ),
                  SizedBox(
                    width: size.height / 50,
                  ),
                  CustomText(
                    content: "${model.profileInfo.username}",
                  )
                ],
              ),
              const SizedBox(height: 10),
              if (model.profileInfo.phoneNumber != null &&
                  model.profileInfo.phoneNumber!.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.mainLightRedColor,
                      size: 35,
                    ),
                    SizedBox(
                      width: size.height / 50,
                    ),
                    CustomText(
                      content: "${model.profileInfo.phoneNumber}",
                    )
                  ],
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.local_activity,
                    color: AppColors.mainLightRedColor,
                    size: 35,
                  ),
                  SizedBox(
                    width: size.height / 50,
                  ),
                  CustomText(
                    content: "${model.profileInfo.role}",
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.height / 18),
          width: 1,
          color: AppColors.mainDarkRedColor,
          height: size.height / 1.3,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: size.height / 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        content: tr('change_passwor'),
                        fontSize: size.height / 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    borderColor: AppColors.mainDarkRedColor,
                    placeHolderCustomStyle: TextStyle(
                        color: Colors.grey, fontSize: size.height / 35),
                    showPassword: showCurrentPassword,
                    suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            showCurrentPassword = !showCurrentPassword;
                          });
                        },
                        icon: Icon(
                          showCurrentPassword == true
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        )),
                    placeHolder: tr('current_passwor'),
                    textEditingController: model.currentController,
                    validator: (String? val) {
                      if (val != null && val.isNotEmpty) return null;
                      return tr('field_validator');
                    },
                  ),
                  CustomTextFormField(
                    textEditingController: model.newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    borderColor: AppColors.mainDarkRedColor,
                    placeHolderCustomStyle: TextStyle(
                        color: Colors.grey, fontSize: size.height / 35),
                    showPassword: showNewPassword,
                    suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            showNewPassword = !showNewPassword;
                          });
                        },
                        icon: Icon(
                          showNewPassword == true
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        )),
                    placeHolder: tr('new_passwor'),
                    validator: (String? val) {
                      if (val != null && val.isNotEmpty) return null;
                      return tr('field_validator');
                    },
                  ),
                  CustomTextFormField(
                    textEditingController: model.confirmController,
                    keyboardType: TextInputType.visiblePassword,
                    borderColor: AppColors.mainDarkRedColor,
                    placeHolderCustomStyle: TextStyle(
                        color: Colors.grey, fontSize: size.height / 35),
                    showPassword: showConfirmPassword,
                    suffixWidget: IconButton(
                        onPressed: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                        icon: Icon(
                          showConfirmPassword == true
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        )),
                    placeHolder: tr('confirm_passwor'),
                    validator: (String? val) {
                      if (val != null && val.isNotEmpty) return null;
                      return tr('field_validator');
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 0, right: 0, top: size.height / 10, bottom: 20),
                    child: ElevatedButton(
                      child: Container(
                          width: double.infinity,
                          height: size.height / 10,
                          child: Center(
                              child: Text(
                            tr("general_save"),
                            style: TextStyle(fontSize: size.height / 30),
                          ))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // _formKey.currentState!.save();
                          model.changePassword();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.mainDarkRedColor,
                        onPrimary: Colors.white,
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
