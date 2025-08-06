import 'package:ESGVida/model/user.dart';


class NewsModel {
  NewsModel({
    int? id,
    String? images,
    String? title,
    String? description,
    String? date,
    String? hyperlink,
    int? likeCount,
    int? commentCount,
    LatestNewsUserInteractionModel? userInteraction,
  }) {
    _id = id;
    _images = images;
    _title = title;
    _description = description;
    _date = date;
    _hyperlink = hyperlink;
    _likeCount = likeCount;
    _commentCount = commentCount;
    _userInteraction = userInteraction;
  }
  NewsModel copyWith({
    int? id,
    String? images,
    String? title,
    String? description,
    String? date,
    String? hyperlink,
    int? likeCount,
    int? commentCount,
    LatestNewsUserInteractionModel? userInteraction,
  }) =>
      NewsModel(
        id: id ?? _id,
        images: images ?? _images,
        title: title ?? _title,
        description: description ?? _description,
        date: date ?? _date,
        hyperlink: hyperlink ?? _hyperlink,
        likeCount: likeCount ?? _likeCount,
        commentCount: commentCount ?? _commentCount,
        userInteraction: userInteraction ?? _userInteraction,
      );
  NewsModel.fromJson(dynamic json) {
    _id = json['id'];
    _images = json['images'];
    _title = json['title'];
    _description = json['description'];
    _date = json['date'];
    _hyperlink = json['hyperlink'];
    _likeCount = json['like_count'];
    _commentCount = json['comment_count'];
    _userInteraction =
        LatestNewsUserInteractionModel.fromJson(json['user_interaction']);
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['images'] = _images;
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['hyperlink'] = _hyperlink;
    map['like_count'] = _likeCount;
    map['comment_count'] = _commentCount;
    map['user_interaction'] = _userInteraction;
    return map;
  }

  int? get id => _id;
  String? get images => _images;
  String? get title => _title;
  String? get description => _description;
  String? get date => _date;
  String? get hyperlink => _hyperlink;
  int? get likeCount => _likeCount;
  int? get commentCount => _commentCount;
  LatestNewsUserInteractionModel? get userInteraction => _userInteraction;

  int? _id;
  String? _images;
  String? _title;
  String? _description;
  String? _date;
  String? _hyperlink;
  int? _likeCount;
  int? _commentCount;
  LatestNewsUserInteractionModel? _userInteraction;
}

class LatestNewsUserInteractionModel {
  LatestNewsUserInteractionModel({
    bool? liked,
  }) {
    _liked = liked;
  }
  LatestNewsUserInteractionModel copyWith({
    bool? liked,
  }) =>
      LatestNewsUserInteractionModel(
        liked: liked ?? _liked,
      );
  LatestNewsUserInteractionModel.fromJson(dynamic json) {
    _liked = json['liked'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['liked'] = _liked;
    return map;
  }

  bool? get liked => _liked;

  bool? _liked;
}

class NewsCommentModel {
  static const enable = "Enable";
  static const disable = "Disable";
  NewsCommentModel({
    int? id,
    int? newId,
    UserProfileModel? user,
    String? content,
    int? created,
    int? updated,
    String? status,
  }) {
    _id = id;
    _newId = newId;
    _user = user;
    _content = content;
    _created = created;
    _updated = updated;
    _status = status;
  }

  NewsCommentModel copyWith({
    int? id,
    int? newId,
    UserProfileModel? user,
    String? content,
    int? created,
    int? updated,
    String? status,
  }) =>
      NewsCommentModel(
        id: id ?? _id,
        newId: newId ?? _newId,
        user: user ?? _user,
        content: content ?? _content,
        created: created ?? _created,
        updated: updated ?? _updated,
        status: status ?? _status,
      );

  NewsCommentModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _newId = json["newId"];
    _user = UserProfileModel.fromJson(json["user"]);
    _content = json["content"];
    _created = json["created"];
    _updated = json["updated"];
    _status = json["status"];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['newId'] = _newId;
    map['user'] = _user?.toJson();
    map['content'] = _content;
    map['created'] = _created;
    map['updated'] = _updated;
    map['status'] = _status;
    return map;
  }

  int? get id => _id;

  int? get newId => _newId;

  UserProfileModel? get user => _user;

  String? get content => _content;

  int? get created => _created;

  int? get updated => _updated;

  String? get status => _status;

  int? _id;
  int? _newId;
  UserProfileModel? _user;
  String? _content;
  int? _created;
  int? _updated;
  String? _status;
}
