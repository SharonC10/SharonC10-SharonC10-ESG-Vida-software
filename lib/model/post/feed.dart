class PostFeedModel {
  PostFeedModel({
    required this.id,
    required this.coverUrl,
    required this.username,
    required this.userProfileUrl,
    required this.heading,
    required this.description,
    required this.lat,
    required this.lng,
    required this.address,
    required this.createAt,
    required this.rating,
    required this.commentCount,
  });

  final int? id;
  final String? coverUrl;
  final String? username;
  final String? userProfileUrl;
  final String? heading;
  final String? description;
  final String? lat;
  final String? lng;
  final String? address;
  final int? createAt;
  final int? rating;
  final int? commentCount;

  PostFeedModel copyWith({
    int? id,
    String? coverUrl,
    String? username,
    String? userProfileUrl,
    String? heading,
    String? description,
    String? lat,
    String? lng,
    String? address,
    int? createAt,
    int? rating,
    int? commentCount,
  }) {
    return PostFeedModel(
      id: id ?? this.id,
      coverUrl: coverUrl ?? this.coverUrl,
      username: username ?? this.username,
      userProfileUrl: userProfileUrl ?? this.userProfileUrl,
      heading: heading ?? this.heading,
      description: description ?? this.description,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      createAt: createAt ?? this.createAt,
      rating: rating ?? this.rating,
      commentCount: commentCount ?? this.commentCount,
    );
  }

  factory PostFeedModel.fromJson(Map<String, dynamic> json) {
    return PostFeedModel(
      id: json["id"],
      coverUrl: json["cover_url"],
      username: json["username"],
      userProfileUrl: json["user_profile_url"],
      heading: json["heading"],
      description: json["description"],
      lat: json["lat"],
      lng: json["lng"],
      address: json["address"],
      createAt: json["create_at"],
      rating: json["rating"],
      commentCount: json["comment_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover_url": coverUrl,
        "username": username,
        "user_profile_url": userProfileUrl,
        "heading": heading,
        "description": description,
        "lat": lat,
        "lng": lng,
        "address": address,
        "create_at": createAt,
        "rating": rating,
        "comment_count": commentCount,
      };
}
