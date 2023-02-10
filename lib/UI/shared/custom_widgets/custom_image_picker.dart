import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/svg_icon_button.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:ndialog/ndialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CustomImagePicker extends StatelessWidget {
  final List<String> images;
  final EdgeInsetsGeometry? padding;
  // late VideoPlayerController _videoPlayerController;
  final double? height;
  CustomImagePicker({
    required this.images,
    Key? key,
    this.height,
    this.padding,
    this.onCancelClicked,
    this.addNewImage,
  }) : super(key: key);
  final Function(List<String> list)? onCancelClicked;
  final Function(int type, List<String> imageList)? addNewImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        width: size.width,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 15, top: 0),
                padding:
                    EdgeInsets.only(left: 15, right: 10, bottom: 8, top: 8),
                //  height: height ?? 190,
                child: Align(
                    alignment: locator<SharedPreferencesRepository>()
                                .getAppLanguage() ==
                            'ar'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Wrap(
                      children: images
                          .map((element) => Padding(
                                padding: EdgeInsetsDirectional.only(end: 8),
                                child: Container(
                                  width: size.height / 3,
                                  height: size.height / 3,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(
                                          size.width / 50),
                                      border: Border.all(
                                          color: Colors.blueGrey[100]!,
                                          width: 1)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          size.width / 50),
                                      child: InkWell(
                                        onTap: () {
                                          // if (index != images.length) {}
                                        },
                                        child: Stack(
                                          // alignment: Al,
                                          fit: StackFit.expand,
                                          children: [
                                            element == 'vid'
                                                ? SvgIconButton(
                                                    svgPath:
                                                        'assets/svgs/add.svg',
                                                    color: AppColors.blackColor,
                                                    width:
                                                        size.longestSide / 28,
                                                    onPressed: () async {
                                                      if (images.length == 1) {
                                                        if (addNewImage !=
                                                            null) {
                                                          addNewImage!(
                                                              0, images);
                                                        }
                                                      } else {
                                                        CustomToasts.showMessage(
                                                            message: tr(
                                                                'can not add more one video'),
                                                            messageType:
                                                                MessageType
                                                                    .errorMessage);
                                                      }
                                                    })
                                                : element == 'add'
                                                    ? SvgIconButton(
                                                        svgPath:
                                                            'assets/svgs/add.svg',
                                                        color: AppColors
                                                            .blackColor,
                                                        width:
                                                            size.longestSide /
                                                                28,
                                                        onPressed: () async {
                                                          if (images.length ==
                                                              1) {
                                                            await NDialog(
                                                              dialogStyle:
                                                                  DialogStyle(
                                                                      titleDivider:
                                                                          true),
                                                              title: Text(
                                                                tr('general_select_image_source'),
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .mainDarkRedColor),
                                                              ),
                                                              // content:
                                                              //     Text('camera or galary'),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                    child: Text(
                                                                      tr('general_camera'),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'cairo'),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      locator<NavigationService>()
                                                                          .back();
                                                                      if (addNewImage !=
                                                                          null)
                                                                        addNewImage!(
                                                                            1,
                                                                            images);
                                                                    }),
                                                                FlatButton(
                                                                    child: Text(
                                                                      tr('general_gellary'),
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'cairo'),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      locator<NavigationService>()
                                                                          .back();
                                                                      if (addNewImage !=
                                                                          null)
                                                                        addNewImage!(
                                                                            2,
                                                                            images);
                                                                    }),
                                                                FlatButton(
                                                                    child: Text(
                                                                      tr('general_cancel'),
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .mainRedColor,
                                                                          fontFamily:
                                                                              'cairo'),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      locator<NavigationService>()
                                                                          .back();
                                                                    }),
                                                              ],
                                                            ).show(context);
                                                          } else {
                                                            CustomToasts.showMessage(
                                                                message: tr(
                                                                    'can not add more one image'),
                                                                messageType:
                                                                    MessageType
                                                                        .errorMessage);
                                                          }
                                                        },
                                                      )
                                                    : element.substring(
                                                                element.length -
                                                                    3,
                                                                element
                                                                    .length) ==
                                                            'mp4'
                                                        ? Container(
                                                            height: 200,
                                                            width: 400,
                                                            child: Chewie(
                                                              controller:
                                                                  ChewieController(
                                                                videoPlayerController:
                                                                    VideoPlayerController
                                                                        .file(File(
                                                                            element)),
                                                                autoPlay: true,
                                                                /* aspectRatio:
                                                                    3 / 2, */
                                                                looping: true,
                                                              ),
                                                            ),
                                                          )
                                                        : Image.file(
                                                            File(element),
                                                            fit: BoxFit.cover,
                                                          ),
                                            element == 'add' || element == 'vid'
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          images
                                                              .remove(element);
                                                          if (onCancelClicked !=
                                                              null) {
                                                            onCancelClicked!(
                                                                images);
                                                          }
                                                        },
                                                        child: Icon(
                                                            Icons
                                                                .cancel_outlined,
                                                            size: 30,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      )),
                                ),
                              ))
                          .toList(),
                    )

                    // GridView.count(
                    //   scrollDirection: Axis.horizontal,
                    //   shrinkWrap: true,
                    //   padding: EdgeInsets.zero,
                    //   crossAxisCount: images.length < 8 ? 2 : 3,
                    //   mainAxisSpacing: 5,
                    //   children: List.generate(
                    //     images.length + 1,
                    //     (index) {
                    //       return ;
                    //     },
                    //   ),
                    // ),
                    )),
          ],
        ));
  }
}
