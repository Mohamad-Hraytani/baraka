import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text_field.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/shared/log_in/componants/login_button.dart';
import 'package:albarakakitchen/UI/views/shared/log_in/log_in_view_model.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:albarakakitchen/core/services/localization_service/chagne_local.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:stacked/stacked.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  SharedPreferencesRepository _sharedPreferencesRepository =
      locator<SharedPreferencesRepository>();
  @override
  Widget build(BuildContext context) {
    bool _arLocal = EasyLocalization.of(context)?.locale.languageCode == "ar";
    bool _enLocal = EasyLocalization.of(context)?.locale.languageCode == "en";
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<LogInViewModel>.reactive(
        viewModelBuilder: () => LogInViewModel(),
        builder: (context, model, _) => Scaffold(
              backgroundColor: AppColors.mainLightGreyColor,
              body: Container(
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.mainLightGreyColor,
                      AppColors.mainLightGreyColor,
                      AppColors.mainLightGreyColor,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    //\stops: [1, 1, 0.6, 1],
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              ChangeLocalService.showAndChangeLocals(
                                context,
                                enTap: () async {
                                  if (!_enLocal) {
                                    // final respose = await model.changeLanguage(
                                    //     isEnglish: true);
                                    // if (respose) {

                                    // } else {

                                    // }

                                    _sharedPreferencesRepository
                                        .saveAppLanguage(langCode: 'en');
                                    EasyLocalization.of(context)
                                        ?.setLocale(Locale('en', 'US'));
                                  }
                                },
                                arTap: () async {
                                  if (!_arLocal) {
                                    // final respose = await model.changeLanguage(
                                    //     isEnglish: false);
                                    // if (respose) {

                                    // } else {
                                    //
                                    // }

                                    _sharedPreferencesRepository
                                        .saveAppLanguage(langCode: 'ar');
                                    EasyLocalization.of(context)
                                        ?.setLocale(Locale('ar', 'SA'));

                                    // navigationService.clearStackAndShow(Routes.splashScreenView);
                                  }
                                },
                              );
                            },
                            child: Icon(
                              Icons.language,
                              size: getIsPhone() ? 25 : 35,
                            ),
                          ),
                          Text(getEnvironment() +
                              "   V" +
                              locator<PackageInfo>().version),
                        ],
                      ),
                      SizedBox(
                        height:
                            getIsPhone() ? size.height / 6 : size.height / 15,
                      ),
                      Column(
                        children: [
                          Container(
                            width: getIsPhone()
                                ? size.width / 2.5
                                : size.height * 0.3,
                            height: getIsPhone()
                                ? size.width / 2.5
                                : size.height * 0.3,
                            // padding: const EdgeInsets.all(15.0),
                            child: Hero(
                              tag: 'Hero',
                              child: Image.asset(
                                'assets/pngs/new_logo.jpeg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height / 20,
                          ),
                          Form(
                            key: model.formKey,
                            child: Container(
                              width: size.longestSide * 0.35,
                              height: size.height / 2.5,
                              // padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                      placeHolder: tr('login_username'),
                                      validator: model.userNameValidator,
                                      onSave: model.userNameOnSave,
                                      borderColor: AppColors.mainLightRedColor,
                                      maxLines: 1,
                                    ),
                                    CustomTextFormField(
                                      maxLines: 1,
                                      showPassword: model.showPassword,
                                      validator: model.passwordValidator,
                                      onSave: model.passwordOnSave,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      placeHolder: tr('login_password'),
                                      borderColor: AppColors.mainLightRedColor,
                                      suffixWidget: InkWell(
                                        onTap: model.toggleShowPassword,
                                        child: Icon(
                                          model.showPassword != true
                                              ? Icons.visibility
                                              : Icons.visibility_off_outlined,
                                          color: AppColors.mainGreyColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: LoginButton(
                                        onPressed: model.login,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
