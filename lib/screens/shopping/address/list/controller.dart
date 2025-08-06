import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/address.dart';
import 'package:get/get.dart';

class AddressListController extends GetxController {
  final _provider = Get.find<AddressProvider>();

  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }

  final isListLoading = true.obs;
  final addressList = <AddressModel>[].obs;
  final Rxn<int> defaultAddressId = Rxn();
  Future<void> fetchAll() async {
    isListLoading.value = true;
    await _provider.listAll().then((value) {
      addressList.value = value.data!;
      defaultAddressId.value =
          addressList.firstWhereOrNull((e) => e.isDefault == true)?.id;
    }).whenComplete(() {
      isListLoading.value = false;
    });
  }

  final isUpdateDefaultLoading = false.obs;
  Future<void> updateDefault(int addressId, bool isDefault) async {
    isUpdateDefaultLoading.value = true;
    await _provider
        .update(addressId: addressId, isDefault: isDefault)
        .then((value) {
      if (value.isFail) {
        return;
      }
      if (!isDefault && defaultAddressId.value == addressId) {
        defaultAddressId.value = null;
      } else {
        defaultAddressId.value = addressId;
      }
    }).whenComplete(() {
      isUpdateDefaultLoading.value = false;
    });
  }

  final isAddLoading = true.obs;
  Future<void> add() async {
    isAddLoading.value = true;
    await _provider.listAll().then((value) {
      if (value.isFail) {
        return;
      }
      addressList.value = value.data!;
    }).whenComplete(() {
      isAddLoading.value = false;
    });
  }

  Future<void> remove(int id) async {
    await _provider.remove(addressId: id).then((value) {
      if (value.isFail) {
        return;
      }
      addressList.removeWhere((e) => e.id == id);
    });
  }
}
