import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/post/comment/feed.dart';
import 'package:ESGVida/model/post/detail.dart';
import 'package:ESGVida/model/post/feed.dart';
import 'package:get/get.dart';
import 'base.dart';

class PostProvider extends BusinessBaseProvider {
  Future<UnionResp<void>> updateComment({
    required int commentId,
    required String content,
  }) async {
    return handlerResult(
      put(
        "/api/user/post/comment/$commentId/",
        {
          "text": content,
        },
      ),
      toastMessageOnSuccess: true,
    );
  }

  Future<UnionResp<void>> deleteComment({
    required int commentId,
  }) async {
    return handlerResult(
      delete("/api/user/post/comment/$commentId/"),
      toastMessageOnSuccess: true,
    );
  }

  Future<UnionResp<PageModel<PostCommentFeedModel>>> listCommentFeed({
    required int postId,
    int page = 1,
  }) async {
    return handlerResult(
      get(
        "/api/user/post/comment/",
        query: {
          "post_id": "$postId",
          "page": "$page",
        },
      ),
      transform: (body) {
        return PageModel.fromJson(
          getData(body),
          (e) => PostCommentFeedModel.fromJson(e),
        );
      },
    );
  }

  Future<UnionResp<void>> addComment({
    required int postId,
    required String commentText,
  }) async {
    return handlerResult(
      post(
        "/api/user/post/comment/",
        {
          "post_id": postId,
          "text": commentText,
        },
      ),
      toastMessageOnSuccess: true,
    );
  }

  Future<UnionResp<bool>> like2({required int postId}) async {
    return handlerResult(
      post("/api/user/post/$postId/like/", null),
      toastMessageOnSuccess: false,
      transform: (body) {
        return getData(body);
      },
    );
  }

  Future<UnionResp<bool>> like({required String postId}) async {
    return handlerResult(
      post(
        "/api/user/postlike/",
        {
          "post_id": postId,
        },
      ),
      toastMessageOnSuccess: true,
      transform: (body) {
        return getData(body);
      },
    );
  }

  Future<UnionResp<void>> add({required FormData formData}) async {
    return handlerResult(
      post("/api/user/post/", formData, contentType: "multipart/form-data"),
      toastMessageOnSuccess: true,
    );
  }

  Future<UnionResp<void>> addPost({required FormData formData}) async {
    return handlerResult(
        post(
          "/api/user/userpost/",
          formData,
        ),
        toastMessageOnSuccess: true);
  }

  Future<UnionResp<PostDetailModel>> getById(int postId) async {
    return handlerResult(
      get(
        "/api/user/post/$postId/",
      ),
      transform: (body) {
        return PostDetailModel.fromJson(getData(body));
      },
    );
  }

  Future<UnionResp<PageModel<PostFeedModel>>> feedList({int page = 1}) async {
    return handlerResult(
      get(
        "/api/user/post/",
        query: {"page": "$page", "feed": "true"},
      ),
      transform: (body) {
        return PageModel.fromJson(
          getData<Map<String, dynamic>>(body),
          (json) => PostFeedModel.fromJson(json),
        );
      },
    );
  }
}
