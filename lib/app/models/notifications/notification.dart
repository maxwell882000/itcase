import 'package:flutter/cupertino.dart';
import 'package:itcase/app/global_widgets/format.dart';
import 'package:itcase/app/models/notifications/invite_requests.dart';
import 'package:itcase/app/models/notifications/new_requests.dart';
import 'package:itcase/app/models/notifications/request_action_accepted.dart';
import 'package:itcase/app/models/notifications/request_action_accepted_by_contractor.dart';
import 'package:itcase/app/models/notifications/request_action_rejected.dart';
import 'package:itcase/app/models/notifications/request_action_rejected_by_contractor.dart';
import 'package:itcase/app/models/notifications/tender_contractor_finished.dart';
import 'package:itcase/app/models/notifications/tender_published.dart';

abstract class NotificationBase {
  bool isRead;
  DateTime createdAt;
  String id;

  String title();

  String body();

  fromJson(Map json) {
    id = json['id'];
    isRead = json['isRead'];
    createdAt = DateTime.parse(json['created_at']);
  }

  static NotificationBase switchCorrect(int type, Map json) {
    switch (type) {
      case 0:
        return InviteRequests.fromJson(json);
      case 1:
        return NewRequests.fromJson(json);
      case 2:
        return json['data']['type'] == 'accepted'
            ? RequestActionAccepted.fromJson(json)
            : json['data']['type'] == 'rejected'
                ? RequestActionRejected.fromJson(json)
                : json['data']['type'] == 'accepted_by_contractor'
                    ? RequestActionAcceptedByContractor.fromJson(json)
                    : RequestActionRejectedByContractor.fromJson(json);
      case 3:
        return TenderContractorFinished.fromJson(json);
      case 5:
        return TenderPublished.fromJson(json);
    }
  }
}
