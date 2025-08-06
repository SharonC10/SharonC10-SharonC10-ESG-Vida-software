/// status : "1"
/// message : "User Threads"
/// All : [{"name":"Deepak Goswami","id":"2","email":"deep@gmail.com","image":"https://esgvida-bkt.s3.amazonaws.com/profile_image/1000091450.jpg","seen":false}]

class UserThreadModel {
  UserThreadModel({
    String? status,
    String? message,
    List<ChatThread>? all,
  }) {
    _status = status;
    _message = message;
    _all = all;
  }

  UserThreadModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['All'] != null) {
      _all = [];
      json['All'].forEach((v) {
        _all?.add(ChatThread.fromJson(v));
      });
    }
  }

  String? _status;
  String? _message;
  List<ChatThread>? _all;

  UserThreadModel copyWith({
    String? status,
    String? message,
    List<ChatThread>? all,
  }) =>
      UserThreadModel(
        status: status ?? _status,
        message: message ?? _message,
        all: all ?? _all,
      );

  String? get status => _status;

  String? get message => _message;

  List<ChatThread>? get all => _all;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_all != null) {
      map['All'] = _all?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : "Deepak Goswami"
/// id : "2"
/// email : "deep@gmail.com"
/// image : "https://esgvida-bkt.s3.amazonaws.com/profile_image/1000091450.jpg"
/// seen : false

class ChatThread {
  ChatThread({
    String? name,
    String? id,
    String? email,
    String? image,
    bool? seen,
    int? latestMessageTimestamp,
  }) {
    _name = name;
    _id = id;
    _email = email;
    _image = image;
    _seen = seen;
    _latestMessageTimestamp = latestMessageTimestamp;
  }

  ChatThread.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _email = json['email'];
    _image = json['image'];
    _seen = json['seen'];
    _latestMessageTimestamp = json['latestMessageTimestamp'];
  }

  String? _name;
  String? _id;
  String? _email;
  String? _image;
  bool? _seen;
  int? _latestMessageTimestamp;

  ChatThread copyWith({
    String? name,
    String? id,
    String? email,
    String? image,
    bool? seen,
    int? latestMessageTimestamp,
  }) =>
      ChatThread(
        name: name ?? _name,
        id: id ?? _id,
        email: email ?? _email,
        image: image ?? _image,
        seen: seen ?? _seen,
        latestMessageTimestamp: latestMessageTimestamp ?? _latestMessageTimestamp,
      );

  String? get name => _name;

  String? get id => _id;

  String? get email => _email;

  String? get image => _image;

  bool? get seen => _seen;
  int? get latestMessageTimestamp => _latestMessageTimestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    map['email'] = _email;
    map['image'] = _image;
    map['seen'] = _seen;
    map['latestMessageTimestamp'] = _latestMessageTimestamp;
    return map;
  }
}
