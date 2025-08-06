import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/view/Chat/models/user_thread_model.dart';
import 'package:ESGVida/model/user.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as chat_types;
import 'package:get/get.dart';

import 'base.dart';

class ChatProvider extends BusinessBaseProvider {
  Future<UnionResp<List<UserProfileModel>>> getHasChatUserList() async {
    return handlerResult(get("/api/v1/get_user_list"), transform: (body) {
      return getData<List<dynamic>>(body)
          .map<UserProfileModel>((e) => UserProfileModel.fromJson(e))
          .toList();
    });
  }

  Future<UnionResp<void>> sendMessage({required FormData formData}) async {
    return handlerResult(
      post("/api/v1/send_messages", formData),
    );
  }

  Future<UnionResp<List<chat_types.Message>>> getMessages(
      {required String receiverId}) async {
    return handlerResult(get("/api/v1/fetch_messages?receiver_id=$receiverId"),
        transform: (body) {
      return getData<List<dynamic>>(body).map((message) {
        // message["createdAt"] = message["createdAt"] * 1000;
        return chat_types.Message.fromJson(message as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<UnionResp<List<ChatThread>>> listThread() async {
    return handlerResult(get("/api/v1/fetch_user_thread"), transform: (body) {
      return getData<List<dynamic>>(body)
          .map<ChatThread>((e) => ChatThread.fromJson(e))
          .toList();
    });
  }
}
