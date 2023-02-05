import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'splash_screen_view_model.dart';

class SplashScreenView extends StatefulWidget {
  SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<SplashScreenViewModel>.reactive(
        onModelReady: (model) async {
          await model.loadDependencies();
          //_animateLogic();
        },
        viewModelBuilder: () => SplashScreenViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: getIsPhone() ? portraitBody(size) : landscapeBody(size));
        });
  }

  Widget landscapeBody(Size size) {
    return Container(
      height: size.height,
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
      child: Container(
        // margin: EdgeInsets.only(top: 100, bottom: 100),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 8,
            ),
            Hero(
              tag: 'Hero',
              child: Image.asset(
                'assets/pngs/new_logo.jpeg',
                width: size.width / 4,
                height: size.width / 2.5,
              ),
            ),
            Container(
              height: 75,
              width: 75,
              alignment: Alignment.center,
              child: SpinKitThreeBounce(
                color: AppColors.mainLightRedColor,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget portraitBody(Size size) {
    return Container(
      height: size.height,
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
      child: Column(
        children: [
          SizedBox(
            height: size.height / 3,
          ),
          Hero(
            tag: 'Hero',
            child: Image.asset(
              'assets/pngs/trans_logo.png',
              width: size.width / 2,
              height: size.width / 2,
            ),
          ),
          Container(
            height: 75,
            width: 75,
            alignment: Alignment.center,
            child: SpinKitThreeBounce(
              color: AppColors.mainLightRedColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
