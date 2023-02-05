import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestListItem extends StatelessWidget {
  const RequestListItem({Key? key, required this.request}) : super(key: key);
  final MaintenanceRequest request;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String code = request.contractNumber ?? '';
    return InkWell(
      onTap: () {
        navigationService.navigateTo(Routes.requestDetailsView,
            arguments: RequestDetailsViewArguments(request: request));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height / 35),
        padding: EdgeInsets.all(size.height / 35),
        // height: 100,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(
            color: AppColors.mainLightRedColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          '${request.client?.firstName} ${request.client?.sureName}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.height / 4.2,
                        height: size.height / 15,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                //  spreadRadius: 3,
                                blurRadius: 6,
                                //offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: AppColors.whiteColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          '$code',
                          style: TextStyle(
                              fontSize: size.height / 30,
                              color: AppColors.mainRedColor),
                        )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${request.createdOn}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainGreyColor),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: request.client?.phoneNumber != null,
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppColors.mainLightRedColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () async {
                            await launch("tel://" +
                                (request.client?.phoneNumber).toString());
                          },
                          child: Container(
                            // width: 400,
                            child: Text(
                              '${request.client?.phoneNumber}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppColors.mainGreyColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.cabin,
                        color: AppColors.mainLightRedColor,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${request.address}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainGreyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
