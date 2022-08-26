import 'package:core/Utils/utils.dart';

class AnotherSampleModel {
  int? created_at = DateTime.now().millisecondsSinceEpoch, id, admin_id, user_id;
  String? subject, address, descriptions;
  bool? is_active = true;
  List<Attachment>? attachments = [];

  AnotherSampleModel({
    this.id,
    this.admin_id,
    this.user_id,
    this.subject,
    this.address,
    this.descriptions,
    this.created_at,
    this.attachments,
  });

  factory AnotherSampleModel.fromJson(Map<String, dynamic> json) {
    return AnotherSampleModel(
        id: json['id'] != null ? json['id'] : null,
        admin_id: json['admin_id'],
        user_id: json['user_id'],
        subject: json['subject'],
        address: json['address'],
        descriptions: json['descriptions'],
        created_at: json['created_at'],
        attachments: json['attachments'] != null
            ? List<Attachment>.from(
                    json["attachments"].map((x) => Attachment.fromJson(x)))
            : null);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "admin_id": this.admin_id,
      "user_id": this.user_id,
      "subject": this.subject,
      "address": this.address,
      "descriptions": this.descriptions,
      "created_at": this.created_at,
      "attachments": this.attachments,
    };
  }

  String getCreatedAt() {
    return formatDate(dateInMilliSeconds: created_at!);
  }
}

// "id": 5,
// "fir_id": 8,
// "url": "https://apisfirmanagement.bitandpixelhub.com/uploads/firs/1642612627830.jpg",
// "is_active": true,
// "is_deleted": 0
class Attachment {
  int? id;
  int? firId;
  String? url;
  bool? isActive;
  int? isDeleted;

  Attachment({this.id, this.firId, this.url, this.isActive, this.isDeleted});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
