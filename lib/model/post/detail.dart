class PostDetailModel {
  PostDetailModel({
    required this.id,
    required this.coverUrl,
    required this.username,
    required this.userProfileUrl,
    required this.heading,
    required this.description,
    required this.medias,
    required this.lat,
    required this.lng,
    required this.address,
    required this.createAt,
    required this.rating,
    required this.commentCount,
    required this.likeCount,
    required this.isLiked,
  });

  final int? id;
  final String? coverUrl;
  final String? username;
  final String? userProfileUrl;
  final String? heading;
  final String? description;
  final List<String> medias;
  final String? lat;
  final String? lng;
  final String? address;
  final int? createAt;
  final int? rating;
  final int? commentCount;
  final int? likeCount;
  final bool? isLiked;

  PostDetailModel copyWith({
    int? id,
    String? coverUrl,
    String? username,
    String? userProfileUrl,
    String? heading,
    String? description,
    List<String>? medias,
    String? lat,
    String? lng,
    String? address,
    int? createAt,
    int? rating,
    int? commentCount,
    int? likeCount,
    bool? isLiked,
  }) {
    return PostDetailModel(
      id: id ?? this.id,
      coverUrl: coverUrl ?? this.coverUrl,
      username: username ?? this.username,
      userProfileUrl: userProfileUrl ?? this.userProfileUrl,
      heading: heading ?? this.heading,
      description: description ?? this.description,
      medias: medias ?? this.medias,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      createAt: createAt ?? this.createAt,
      rating: rating ?? this.rating,
      commentCount: commentCount ?? this.commentCount,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory PostDetailModel.fromJson(Map<String, dynamic> json) {
    return PostDetailModel(
      id: json["id"],
      coverUrl: json["cover_url"],
      username: json["username"],
      userProfileUrl: json["user_profile_url"],
      heading: json["heading"],
      description: json["description"],
      medias: json["medias"] == null
          ? []
          : List<String>.from(json["medias"]!.map((x) => x)),
      lat: json["lat"],
      lng: json["lng"],
      address: json["address"],
      createAt: json["create_at"],
      rating: json["rating"],
      commentCount: json["comment_count"],
      likeCount: json["like_count"],
      isLiked: json["is_liked"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover_url": coverUrl,
        "username": username,
        "user_profile_url": userProfileUrl,
        "heading": heading,
        "description": description,
        "medias": medias.map((x) => x).toList(),
        "lat": lat,
        "lng": lng,
        "address": address,
        "create_at": createAt,
        "rating": rating,
        "comment_count": commentCount,
        "like_count": likeCount,
        "is_liked": isLiked,
      };
}
