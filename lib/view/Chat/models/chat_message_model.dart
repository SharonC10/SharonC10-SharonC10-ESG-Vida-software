/// receiver_id : 4
/// receiver_name : "kishore Patidar"
/// receiver_image : "/media/profile_image/1000316936.jpg"
/// data : [{"id":2,"sender":3,"receiver":4,"description":"hello, dharmendra","file":"","time_stamp":"15-05-2024 05:47 AM"},{"id":3,"sender":3,"receiver":4,"description":"hello, dharmendra","file":"","time_stamp":"15-05-2024 05:58 AM"},{"id":4,"sender":3,"receiver":4,"description":"hello, dharmendra","file":"","time_stamp":"15-05-2024 05:59 AM"}]

class ChatMessageModel {
  ChatMessageModel({
    num? receiverId,
    String? receiverName,
    String? receiverImage,
    List<ChatMessageData>? data,
  }) {
    _receiverId = receiverId;
    _receiverName = receiverName;
    _receiverImage = receiverImage;
    _data = data;
  }

  ChatMessageModel.fromJson(dynamic json) {
    _receiverId = json['receiver_id'];
    _receiverName = json['receiver_name'];
    _receiverImage = json['receiver_image'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ChatMessageData.fromJson(v));
      });
    }
  }

  num? _receiverId;
  String? _receiverName;
  String? _receiverImage;
  List<ChatMessageData>? _data;

  ChatMessageModel copyWith({
    num? receiverId,
    String? receiverName,
    String? receiverImage,
    List<ChatMessageData>? data,
  }) =>
      ChatMessageModel(
        receiverId: receiverId ?? _receiverId,
        receiverName: receiverName ?? _receiverName,
        receiverImage: receiverImage ?? _receiverImage,
        data: data ?? _data,
      );

  num? get receiverId => _receiverId;

  String? get receiverName => _receiverName;

  String? get receiverImage => _receiverImage;

  List<ChatMessageData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['receiver_id'] = _receiverId;
    map['receiver_name'] = _receiverName;
    map['receiver_image'] = _receiverImage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 2
/// sender : 3
/// receiver : 4
/// description : "hello, dharmendra"
/// file : ""
/// time_stamp : "15-05-2024 05:47 AM"

class ChatMessageData {
  ChatMessageData({
    num? id,
    num? sender,
    num? receiver,
    String? description,
    String? file,
    String? timeStamp,
  }) {
    _id = id;
    _sender = sender;
    _receiver = receiver;
    _description = description;
    _file = file;
    _timeStamp = timeStamp;
  }

  ChatMessageData.fromJson(dynamic json) {
    _id = json['id'];
    _sender = json['sender'];
    _receiver = json['receiver'];
    _description = json['description'];
    _file = json['file'];
    _timeStamp = json['time_stamp'];
  }

  num? _id;
  num? _sender;
  num? _receiver;
  String? _description;
  String? _file;
  String? _timeStamp;

  ChatMessageData copyWith({
    num? id,
    num? sender,
    num? receiver,
    String? description,
    String? file,
    String? timeStamp,
  }) =>
      ChatMessageData(
        id: id ?? _id,
        sender: sender ?? _sender,
        receiver: receiver ?? _receiver,
        description: description ?? _description,
        file: file ?? _file,
        timeStamp: timeStamp ?? _timeStamp,
      );

  num? get id => _id;

  num? get sender => _sender;

  num? get receiver => _receiver;

  String? get description => _description;

  String? get file => _file;

  String? get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['sender'] = _sender;
    map['receiver'] = _receiver;
    map['description'] = _description;
    map['file'] = _file;
    map['time_stamp'] = _timeStamp;
    return map;
  }
}
