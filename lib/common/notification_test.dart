import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationTest extends StatefulWidget {
  NotificationTest({Key key}) : super(key: key);

  @override
  _NotificationTestState createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  bool _isCreatingLink = false;
  String _linkMessage;
  String _testString = "asdsadsadas";
  @override
  void initState() {
    super.initState();

  }

  void initDynamicLinks() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body'
        ),
      actionButtons: [
        NotificationActionButton(
          key: "10",
          label: "Something",
          enabled: true,
          buttonType: ActionButtonType.InputField
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links Example'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: !_isCreatingLink
                          ? () => initDynamicLinks()
                          : null,
                      child: const Text('Get Long Link'),
                    ),
                  ],
                ),
                InkWell(
                  child: Text(
                    _linkMessage ?? '',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () async {
                    if (_linkMessage != null) {
                      await launch(_linkMessage);
                    }
                  },
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: _linkMessage));
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied Link!')),
                    );
                  },
                ),
                Text(_linkMessage == null ? '' : _testString)
              ],
            ),
          );
        }),
      ),
    );
  }
}