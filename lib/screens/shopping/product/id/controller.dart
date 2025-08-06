import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:ESGVida/provider/shopping/shoppingcart.dart';
import 'package:ESGVida/provider/shopping/wishlist.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:get/get.dart';

import 'pages/page_enum.dart';

class ProductController extends GetxController {
  final int detailId;
  ProductController({required this.detailId});
  final _provider = Get.find<ProductProvider>();
  final _shoppingCartProvider = Get.find<ShoppingCartProvider>();
  final _wishListProvider = Get.find<WishListProvider>();

  final currentPage = (ProductPageEnum.MAIN).obs;

  final selectMediaIndex = 0.obs;

  final Rxn<ProductModel> detail = Rxn();
  final isDetailLoading = false.obs;
  Future<void> fetchDetail() async {
    isDetailLoading.value = true;
    return _provider.getById(detailId).then((value) {
      if (value.isFail) {
        return;
      }
      detail.value = value.data!;
    }).whenComplete(() {
      isDetailLoading.value = false;
    });
  }

  ProductInteractionModel? interaction;
  final isInteractionLoading = false.obs;
  Future<void> fetchInteraction() async {
    isInteractionLoading.value = true;
    return _provider.getInteraction(detailId).then((value) {
      if (value.isFail) {
        return;
      }
      interaction = value.data!;
    }).whenComplete(() {
      isInteractionLoading.value = false;
    });
  }

  static const MAX_LATEST_COMMENT_SIZE = 3;
  var latestCommentList = <ProductCommentModel>[];
  final isLatestCommentListLoading = false.obs;
  Future<void> fetchLatestComments() async {
    isLatestCommentListLoading.value = true;
    return _provider
        .latestComment(productId: detailId, size: MAX_LATEST_COMMENT_SIZE)
        .then((value) {
      if (value.isFail) {
        return;
      }
      latestCommentList = value.data!;
    }).whenComplete(() {
      isLatestCommentListLoading.value = false;
    });
  }

  Future<void> deleteComment(int commentId) async {
    return _provider.deleteComment(commentId: commentId).then((value) {
      if (value.isFail) {
        return null;
      }
      detail.value =
          detail.value!.copyWith(commentCount: detail.value!.commentCount! - 1);
    });
  }

  final isFavorOptLoading = false.obs;
  Future<void> handlerFavor() async {
    isFavorOptLoading.value = true;
    if (interaction?.isInWishlist == null || !interaction!.isInWishlist!) {
      return _wishListProvider.add(detailId).then((value) {
        if (value.isFail) {
          return;
        }
        if (interaction == null) {
          fetchInteraction();
        } else {
          interaction = interaction!.copyWith(isInWishlist: true);
        }
      }).whenComplete(() {
        // isFavorOptLoading.value = false;
      });
    } else {
      return _wishListProvider.removeByProductId(detailId).then((value) {
        if (value.isFail) {
          return;
        }
        interaction = interaction!.copyWith(isInWishlist: false);
      }).whenComplete(() {
        isFavorOptLoading.value = false;
      });
    }
  }

  final isShareProductLoading = false.obs;
  Future<void> recordShare() async {
    if (interaction?.hasShare == true) {
      return;
    }
    return _provider.recordShare(detailId).then((value) {
      if (value.isFail) {
        return;
      }
      interaction = interaction!.copyWith(hasShare: true);
    });
  }

  final isAddToShoppingCartLoading = false.obs;
  Future<void> addToShoppingCart(int amount) async {
    isAddToShoppingCartLoading.value = true;
    return _shoppingCartProvider
        .add(
      detailId,
      amount: amount,
    )
        .then((value) {
      if (value.isFail) {
        return;
      }
      showToast(LanguageGlobalVar.ADD_TO_SHOPPING_CART_SUCCESS.tr);
    }).whenComplete(() {
      isAddToShoppingCartLoading.value = false;
    });
  }
}
