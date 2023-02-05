import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:albarakakitchen/UI/views/shared/notifications/componants/notification_list_item.dart';
import 'package:albarakakitchen/core/data/models/apis/notification_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key? key,
    required this.title,
    this.list,
    required this.onRefresh,
    required this.refreshController,
  }) : super(key: key);
  final String title;
  final Function() onRefresh;
  final RefreshController refreshController;

  final List<NotificationModel>? list;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AutoSizeText(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            )),
        Expanded(
          flex: 14,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ], color: Colors.white70, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropHeader(),
              controller: refreshController,
              onRefresh: onRefresh,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => NotificationListItem(
                  notification: list![index],
                ),
                itemCount: list?.length ?? 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
