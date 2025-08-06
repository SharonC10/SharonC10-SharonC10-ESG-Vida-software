class PostCommentFeedModel {
  PostCommentFeedModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.userProfileUrl,
    required this.postId,
    required this.text,
    required this.createAt,
  });

  final int? id;
  final int? userId;
  final String? username;
  final String? userProfileUrl;
  final int? postId;
  final String? text;
  final int? createAt;

  PostCommentFeedModel copyWith({
    int? id,
    int? userId,
    String? username,
    String? userProfileUrl,
    int? postId,
    String? text,
    int? createAt,
  }) {
    return PostCommentFeedModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userProfileUrl: userProfileUrl ?? this.userProfileUrl,
      postId: postId ?? this.postId,
      text: text ?? this.text,
      createAt: createAt ?? this.createAt,
    );
  }

  factory PostCommentFeedModel.fromJson(Map<String, dynamic> json) {
    return PostCommentFeedModel(
      id: json["id"],
      userId: json["user_id"],
      username: json["username"],
      userProfileUrl: json["user_profile_url"],
      postId: json["post_id"],
      text: json["text"],
      createAt: json["create_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "username": username,
        "user_profile_url": userProfileUrl,
        "post_id": postId,
        "text": text,
        "create_at": createAt,
      };
}
