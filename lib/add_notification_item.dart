import 'package:flutter/material.dart';

import 'widgets/add_notification_item.dart';

class AddNotificationItem extends StatelessWidget {
  const AddNotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerLinearAdmin(
      width: MediaQuery.sizeOf(context).width,
      height: 180,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 18 , vertical: 15),
        child: Column(
          children: [
             Spacer() ,
            NotificationInfo(title: 'title', body: 'body ',) ,
            Spacer() ,
            NotificationInfo(title: 'title', body: 'body ',)

          ],
        ),
      ),
    );
  }
}
class NotificationInfo extends StatelessWidget {
  const NotificationInfo({super.key, required this.title, required this.body});
final String title ;
final String body ;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(title) ,
        Flexible(child: Text(body))
      ],
    );
  }
}
