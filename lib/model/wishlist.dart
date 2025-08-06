class WishListModel {
  WishListModel({
    required this.id,
    required this.productCover,
    required this.productName,
    required this.productPrice,
    required this.productCurrencyCode,
    required this.shopName,
    required this.userId,
    required this.productId,
    required this.createAt,
  });

  final int? id;
  final String? productCover;
  final String? productName;
  final String? productPrice;
  final String? productCurrencyCode;
  final String? shopName;
  final int? userId;
  final int? productId;
  final num? createAt;

  WishListModel copyWith({
    int? id,
    String? productCover,
    String? productName,
    String? productPrice,
    String? productCurrencyCode,
    String? shopName,
    int? userId,
    int? productId,
    num? createAt,
  }) {
    return WishListModel(
      id: id ?? this.id,
      productCover: productCover ?? this.productCover,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      productCurrencyCode: productCurrencyCode ?? this.productCurrencyCode,
      shopName: shopName ?? this.shopName,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      createAt: createAt ?? this.createAt,
    );
  }

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
      id: json["id"],
      productCover: json["product_cover"],
      productName: json["product_name"],
      productPrice: json["product_price"],
      productCurrencyCode: json["product_currency_code"],
      shopName: json["shop_name"],
      userId: json["user_id"],
      productId: json["product_id"],
      createAt: json["create_at"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_cover": productCover,
        "product_name": productName,
        "product_price": productPrice,
        "product_currency_code": productCurrencyCode,
        "shop_name": shopName,
        "user_id": userId,
        "product_id": productId,
        "create_at": createAt,
      };
}
