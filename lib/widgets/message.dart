import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/app_data.dart';

class Message extends StatelessWidget {
  final ChatMessage message;

  Message(this.message);
  @override
  Widget build(BuildContext context) {
    final sender = AppData.getUserById(message.uuid);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    offset: Offset(0, 2),
                    blurRadius: 5)
              ],
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(sender.profileUrl!),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                child: Row(
                  children: [
                    Text(
                      sender.name!,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(width: 10), // Time
                    Text(
                      getMessageTimeStamp(int.parse(message.timetoken)),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .apply(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  message.message['text'],
                  style: Theme.of(context).textTheme.bodyText2!.apply(
                        color: Colors.black87,
                      ),
                ),
              ),
              message.message['attachments'] != null
                  ? buildAttachment(context, message.message['attachments'][0])
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

// Attachment widget builder
  Widget buildAttachment(BuildContext context, Map attachment) {
    if (attachment['type'] == 'image')
      return Container(
        margin: EdgeInsets.only(left: 5),
        height: 140,
        width: 280,
        child: Image.network(
          attachment['image']['source'],
          cacheHeight: 160,
          cacheWidth: 280,
        ),
      );
    else if (attachment['type'] == 'link') {
      return GestureDetector(
        onTap: () async => await launch(attachment['provider']['url'],
            forceSafariVC: true, forceWebView: true, enableJavaScript: true),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.all(5),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
            maxHeight: 150,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                height: 120,
                width: 70,
                child: Image.network(
                  attachment['image']['source'],
                  cacheHeight: 120,
                  cacheWidth: 70,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network(
                            attachment['icon']['source'],
                            cacheHeight: 20,
                            cacheWidth: 20,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            attachment['provider']['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5),
                    child: Text(
                      attachment['title'],
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 5,
                    ),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.5),
                    child: Text(
                      attachment['description'],
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .apply(color: Colors.grey),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else
      return Container();
  }

  String getMessageTimeStamp(int timetoken) =>
      '${DateFormat.jm().format(DateTime.fromMicrosecondsSinceEpoch(timetoken ~/ 10, isUtc: true).toLocal())}';
}
