import 'package:ESGVida/provider/chat.dart';
import 'package:ESGVida/view/Chat/models/user_thread_model.dart';
import 'package:ESGVida/model/user.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreenController extends GetxController {
  final chatProvider = Get.find<ChatProvider>();
  final controllername = 'chatcontroller'.obs;
  var currentTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateTime();
  }

  void updateTime() {
    currentTime.value = DateFormat('HH:mm').format(DateTime.now());
    Future.delayed(
        const Duration(minutes: 1), updateTime); // Update time every minute
  }

  final isLoadUserThread = false.obs;

  final allUserThreadData = <ChatThread>[].obs;

  void fetchChatThread() {
    isLoadUserThread.value = true;
    chatProvider.listThread().then((value) {
      if (value.isFail) {
        return;
      }
      allUserThreadData.value = value.data!;
    }).whenComplete(() {
      isLoadUserThread.value = false;
      update();
    });
  }

  final isLoadUserList = false.obs;

  final allUserData = <UserProfileModel>[].obs;

  getAllUser() {
    isLoadUserList.value = true;
    chatProvider.getHasChatUserList().then((value) {
      if (value.isFail) {
        return;
      }
      allUserData.value = value.data!;
    }).whenComplete(() {
      isLoadUserList.value = false;
      update();
    });
  }
}
