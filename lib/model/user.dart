class LoginUserModel {
  LoginUserModel({
    UserProfileModel? profile,
    String? deviceType,
    String? deviceToken,
  }) {
    _profile = profile;
    _deviceType = deviceType;
    _deviceToken = deviceToken;
  }

  LoginUserModel copyWith({
    UserProfileModel? profile,
    String? deviceType,
    String? deviceToken,
  }) =>
      LoginUserModel(
        profile: profile ?? _profile,
        deviceType: deviceType ?? _deviceType,
        deviceToken: deviceToken ?? _deviceToken,
      );

  LoginUserModel.fromJson(Map<String, dynamic> json) {
    _profile = UserProfileModel.fromJson(json["profile"]);
    _deviceType = json['device_type'];
    _deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profile'] = _profile?.toJson();
    map['device_type'] = _deviceType;
    map['device_token'] = _deviceToken;
    return map;
  }

  UserProfileModel? get profile => _profile;
  String? get deviceType => _deviceType;
  String? get deviceToken => _deviceToken;

  UserProfileModel? _profile;
  String? _deviceType;
  String? _deviceToken;
}

enum Gender {
  male(value: "M", label: "Male"),
  female(value: "F", label: "Female"),
  other(value: "O", label: "Other");

  final String value;
  final String label;
  const Gender({required this.value, required this.label});
  static Gender find({
    String? label,
    String? value,
  }) {
    if (label != null) {
      return Gender.values.firstWhere((element) => element.label == label);
    }
    if (value != null) {
      return Gender.values.firstWhere((element) => element.value == value);
    }
    throw Exception("label and value both are empty");
  }
}

class UserProfileModel {
  UserProfileModel({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? sexType,
    int? createdAt,
    int? updatedAt,
  }) {
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _profileImage = profileImage;
    _sexType = sexType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserProfileModel.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _profileImage = json['profile_image'];
    _sexType = json['sex_type'];
    _createdAt = json['create_at'];
    _updatedAt = json['update_at'];
  }

  int? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _profileImage;
  String? _sexType;
  int? _createdAt;
  int? _updatedAt;

  UserProfileModel copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? sexType,
    int? createdAt,
    int? updatedAt,
  }) =>
      UserProfileModel(
        id: id ?? _id,
        email: email ?? _email,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        profileImage: profileImage ?? _profileImage,
        sexType: sexType ?? _sexType,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  int? get id => _id;
  String? get email => _email;

  String? get firstName => _firstName;

  String? get lastName => _lastName;

  String get fullName => "${_firstName ?? ""} ${_lastName ?? ""}";

  String? get profileImage => _profileImage;

  String? get sexType => _sexType;

  int? get createdAt => _createdAt;

  int? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['profile_image'] = _profileImage;
    map['sex_type'] = _sexType;
    map['create_at'] = _createdAt;
    map['update_at'] = _updatedAt;
    return map;
  }
}
