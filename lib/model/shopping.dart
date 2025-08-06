import 'package:ESGVida/model/user.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:get/get.dart';

class ShopModel {
  ShopModel({
    this.id,
    this.user,
    this.status,
    this.name,
    this.description,
    this.yearsOfExperience,
    this.cover,
    this.location,
    this.rating,
    this.createAt,
    this.updateAt,
  });

  final int? id;
  final UserProfileModel? user;
  final String? status;
  final String? name;
  final String? description;
  final int? yearsOfExperience;
  final String? cover;
  final String? location;
  final String? rating;
  final int? createAt;
  final int? updateAt;
  ShopModel copyWith({
    int? id,
    UserProfileModel? user,
    String? status,
    String? name,
    String? description,
    int? yearsOfExperience,
    String? cover,
    String? location,
    String? rating,
    int? createAt,
    int? updateAt,
  }) {
    return ShopModel(
      id: id ?? this.id,
      user: user ?? this.user,
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      cover: cover ?? this.cover,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json["id"],
      user:
          json["user"] == null ? null : UserProfileModel.fromJson(json["user"]),
      status: json["status"],
      name: json["name"],
      description: json["description"],
      yearsOfExperience: json["years_of_experience"],
      cover: json["cover"],
      location: json["location"],
      rating: json["rating"],
      createAt: json["create_at"],
      updateAt: json["update_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "status": status,
        "name": name,
        "description": description,
        "years_of_experience": yearsOfExperience,
        "cover": cover,
        "location": location,
        "rating": rating,
        "create_at": createAt,
        "update_at": updateAt,
      };
}

class ProductModel {
  ProductModel({
    this.id,
    this.cover,
    this.shop,
    this.currencyCode,
    this.status,
    this.name,
    this.description,
    this.imageUrls,
    this.videoUrls,
    this.price,
    this.lat,
    this.lng,
    this.address,
    this.rating,
    this.commentCount,
    this.salesVolume,
    this.createAt,
    this.updateAt,
  });

  final int? id;
  final String? cover;
  final ShopModel? shop;
  final String? currencyCode;
  final String? status;
  final String? name;
  final String? description;
  final String? price;
  final List<String>? imageUrls;
  final List<String>? videoUrls;
  final double? lat;
  final double? lng;
  final String? address;
  final String? rating;
  final int? commentCount;
  final int? salesVolume;
  final int? createAt;
  final int? updateAt;

  List<String>? _imageAndVideoList;
  List<String> getMediaList() {
    if (_imageAndVideoList == null) {
      _imageAndVideoList = [];
      _imageAndVideoList = (imageUrls ?? []) + (videoUrls ?? []);
    }
    return _imageAndVideoList!;
  }

  ProductModel copyWith({
    int? id,
    String? cover,
    ShopModel? shop,
    String? currencyCode,
    String? status,
    String? name,
    String? description,
    String? price,
    List<String>? imageUrls,
    List<String>? videoUrls,
    double? lat,
    double? lng,
    String? address,
    String? rating,
    int? commentCount,
    int? salesVolume,
    int? createAt,
    int? updateAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      cover: cover ?? this.cover,
      shop: shop ?? this.shop,
      currencyCode: currencyCode ?? this.currencyCode,
      status: status ?? this.status,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrls: videoUrls ?? this.videoUrls,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      commentCount: commentCount ?? this.commentCount,
      salesVolume: salesVolume ?? this.salesVolume,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      cover: json["cover"],
      shop: json["shop"] == null ? null : ShopModel.fromJson(json["shop"]),
      currencyCode: json["currency_code"],
      status: json["status"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageUrls: List<String>.from(json["image_urls"]),
      videoUrls: List<String>.from(json["video_urls"]),
      lat: json["lat"],
      lng: json["lng"],
      address: json["address"],
      rating: json["rating"],
      commentCount: json["comment_count"],
      salesVolume: json["sales_volume"],
      createAt: json["create_at"],
      updateAt: json["update_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cover": cover,
        "shop": shop?.toJson(),
        "currency_code": currencyCode,
        "status": status,
        "name": name,
        "description": description,
        "price": price,
        "image_urls": imageUrls,
        "video_urls": videoUrls,
        "lat": lat,
        "lng": lng,
        "address": address,
        "rating": rating,
        "comment_count": commentCount,
        "sales_volume": salesVolume,
        "create_at": createAt,
        "update_at": updateAt,
      };
}

class ProductCommentModel {
  ProductCommentModel({
    this.id,
    this.user,
    this.status,
    this.productId,
    this.pid,
    this.content,
    this.rating,
    this.createAt,
    this.updateAt,
  });

  final int? id;
  final UserProfileModel? user;
  final String? status;
  final int? productId;
  final int? pid;
  final String? content;
  final String? rating;
  final int? createAt;
  final int? updateAt;

  ProductCommentModel copyWith({
    int? id,
    UserProfileModel? user,
    String? status,
    int? productId,
    int? pid,
    String? content,
    String? rating,
    int? createAt,
    int? updateAt,
  }) {
    return ProductCommentModel(
      id: id ?? this.id,
      user: user ?? this.user,
      status: status ?? this.status,
      productId: productId ?? this.productId,
      pid: pid ?? this.pid,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  factory ProductCommentModel.fromJson(Map<String, dynamic> json) {
    return ProductCommentModel(
      id: json["id"],
      user:
          json["user"] == null ? null : UserProfileModel.fromJson(json["user"]),
      status: json["status"],
      productId: json["product_id"],
      pid: json["pid"],
      content: json["content"],
      rating: json["rating"],
      createAt: json["create_at"],
      updateAt: json["update_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "status": status,
        "product_id": productId,
        "pid": pid,
        "content": content,
        "rating": rating,
        "create_at": createAt,
        "update_at": updateAt,
      };
}

class ProductInteractionModel {
  ProductInteractionModel({
    this.id,
    this.productId,
    this.userId,
    this.hasBuy,
    this.hasShare,
    this.isInWishlist,
  });

  final int? id;
  final int? productId;
  final int? userId;
  final bool? hasBuy;
  final bool? hasShare;
  final bool? isInWishlist;

  ProductInteractionModel copyWith({
    int? id,
    int? productId,
    int? userId,
    bool? hasBuy,
    bool? hasShare,
    bool? isInWishlist,
  }) {
    return ProductInteractionModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      hasBuy: hasBuy ?? this.hasBuy,
      hasShare: hasShare ?? this.hasShare,
      isInWishlist: isInWishlist ?? this.isInWishlist,
    );
  }

  factory ProductInteractionModel.fromJson(Map<String, dynamic> json) {
    return ProductInteractionModel(
      id: json["id"],
      productId: json["product_id"],
      userId: json["user_id"],
      hasBuy: json["has_buy"],
      hasShare: json["has_share"],
      isInWishlist: json["is_in_wishlist"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "has_buy": hasBuy,
        "has_share": hasShare,
        "is_in_wishlist": isInWishlist,
      };
}

class ShoppingCartItemModel {
  ShoppingCartItemModel({
    this.id,
    this.product,
    this.shop,
    this.userId,
    this.amount,
    this.createAt,
  });

  final int? id;
  final ProductModel? product;
  final ShopModel? shop;
  final int? userId;
  final int? amount;
  final int? createAt;

  ShoppingCartItemModel copyWith({
    int? id,
    ProductModel? product,
    ShopModel? shop,
    int? userId,
    int? amount,
    int? createAt,
  }) {
    return ShoppingCartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      shop: shop ?? this.shop,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      createAt: createAt ?? this.createAt,
    );
  }

  factory ShoppingCartItemModel.fromJson(Map<String, dynamic> json) {
    return ShoppingCartItemModel(
      id: json["id"],
      product: json["product"] == null
          ? null
          : ProductModel.fromJson(json["product"]),
      shop: json["shop"] == null ? null : ShopModel.fromJson(json["shop"]),
      userId: json["user_id"],
      amount: json["amount"],
      createAt: json["create_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "shop": shop?.toJson(),
        "user_id": userId,
        "amount": amount,
        "create_at": createAt,
      };
}

enum ProductOrderStatus {
  COMPLETED,
  CANCELLED,
  TO_PAY,
  TO_SHIP,
  TO_RECEIVE,
  TO_COMMENT,
  REFUNDS_SALES,
  REQUESTING,
  REFUND_OF_GOODS,
  REFUND_SUCCESSULLY,
  REQUEST_CANCELLED,
  ALL;

  String string() {
    return stringOf(name);
  }

  static stringOf(String status) {
    if (CANCELLED.name == status) {
      return LanguageGlobalVar.CANCELLED.tr;
    } else if (COMPLETED.name == status) {
      return LanguageGlobalVar.COMPLETED.tr;
    } else if (TO_PAY.name == status) {
      return LanguageGlobalVar.TO_PAY.tr;
    } else if (TO_SHIP.name == status) {
      return LanguageGlobalVar.TO_SHIP.tr;
    } else if (TO_RECEIVE.name == status) {
      return LanguageGlobalVar.TO_RECEIVE.tr;
    } else if (TO_COMMENT.name == status) {
      return LanguageGlobalVar.TO_COMMENT.tr;
    } else if (REFUNDS_SALES.name == status) {
      return LanguageGlobalVar.REFUNDS_SALES.tr;
    } else if (REQUESTING.name == status) {
      return LanguageGlobalVar.REQUESTING.tr;
    } else if (REFUND_SUCCESSULLY.name == status) {
      return LanguageGlobalVar.REFUND_SUCCESSULLY.tr;
    } else if (REFUND_OF_GOODS.name == status) {
      return LanguageGlobalVar.REFUND_OF_GOODS.tr;
    } else if (REQUEST_CANCELLED.name == status) {
      return LanguageGlobalVar.REQUEST_CANCELLED.tr;
    } else {
      return LanguageGlobalVar.ALL.tr;
    }
  }
}

class ProductOrderModel {
  ProductOrderModel({
    this.id,
    this.product,
    this.shop,
    this.address,
    this.orderId,
    this.userId,
    this.amount,
    this.price,
    this.currencyCode,
    this.actualPayment,
    this.status,
    this.createAt,
    this.updateAt,
  });

  final int? id;
  final ProductModel? product;
  final ShopModel? shop;
  final AddressModel? address;
  final String? orderId;
  final int? userId;
  final int? amount;
  final String? price;
  final String? currencyCode;
  final String? actualPayment;
  final String? status;
  final int? createAt;
  final int? updateAt;

  ProductOrderModel copyWith({
    int? id,
    ProductModel? product,
    ShopModel? shop,
    AddressModel? address,
    String? orderId,
    int? userId,
    int? amount,
    String? price,
    String? currencyCode,
    String? actualPayment,
    String? status,
    int? createAt,
    int? updateAt,
  }) {
    return ProductOrderModel(
      id: id ?? this.id,
      product: product ?? this.product,
      shop: shop ?? this.shop,
      address: address ?? this.address,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      currencyCode: currencyCode ?? this.currencyCode,
      actualPayment: actualPayment ?? this.actualPayment,
      status: status ?? this.status,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  factory ProductOrderModel.fromJson(Map<String, dynamic> json) {
    return ProductOrderModel(
      id: json["id"],
      product: json["product"] == null
          ? null
          : ProductModel.fromJson(json["product"]),
      shop: json["shop"] == null ? null : ShopModel.fromJson(json["shop"]),
      address: json["address"] == null ||
              "String" == json["address"].runtimeType.toString()
          ? null
          : AddressModel.fromJson(json["address"]),
      orderId: json["order_id"],
      userId: json["user_id"],
      amount: json["amount"],
      price: json["price"],
      currencyCode: json["currency_code"],
      actualPayment: json["actual_payment"],
      status: json["status"],
      createAt: json["create_at"],
      updateAt: json["update_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "shop": shop?.toJson(),
        "address": address?.toJson(),
        "order_id": orderId,
        "user_id": userId,
        "amount": amount,
        "price": price,
        "currency_code": currencyCode,
        "actual_payment": actualPayment,
        "status": status,
        "create_at": createAt,
        "update_at": updateAt,
      };
}

class AddressModel {
  AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.area,
    required this.areaDetail,
    required this.isDefault,
  });

  final int? id;
  final int? userId;
  final String? name;
  final String? phone;
  final String? area;
  final String? areaDetail;
  final bool? isDefault;

  AddressModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? phone,
    String? area,
    String? areaDetail,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      area: area ?? this.area,
      areaDetail: areaDetail ?? this.areaDetail,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      userId: json["user_id"],
      name: json["name"],
      phone: json["phone"],
      area: json["area"],
      areaDetail: json["area_detail"],
      isDefault: json["is_default"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
        "area": area,
        "area_detail": areaDetail,
        "is_default": isDefault,
      };
}
