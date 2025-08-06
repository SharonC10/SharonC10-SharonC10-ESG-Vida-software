import 'dart:async';

import 'package:ESGVida/model/common.dart';

import '../model/news_model.dart';
import 'base.dart';

class NewsProvider extends BusinessBaseProvider {
  Future<UnionResp<PageModel<NewsModel>>> feedList({
    int page = 1,
  }) async {
    return handlerResult(
      get(
        "/api/user/news/",
        query: {
          "page": "$page",
          "feed": "true",
        },
      ),
      transform: (body) {
        return PageModel.fromJson(
          getData(body),
          (e) => NewsModel.fromJson(e),
        );
      },
    );
  }

  Future<UnionResp<List<NewsModel>>> listLatestNews() async {
    return handlerResult(
      get("/api/user/news/latest/"),
      transform: (body) {
        return getData<List<dynamic>>(body)
            .map<NewsModel>((e) => NewsModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<UnionResp<NewsModel>> getNews({required int newsId}) async {
    return handlerResult(
      get("/api/user/news/$newsId"),
      transform: (body) {
        return NewsModel.fromJson(getData(body));
      },
    );
  }

  Future<UnionResp<bool>> doLike(int newsId) async {
    return await handlerResult(post("/api/user/news/$newsId/like/", null),
        transform: (body) => getData(body));
  }

  Future<UnionResp<PageModel<NewsCommentModel>>> listComment(
    int newsId, {
    required int page,
  }) async {
    return await handlerResult(get("/api/user/news/comment/?news_id=$newsId"),
        transform: (body) {
      return PageModel.fromJson(body["data"], NewsCommentModel.fromJson);
    });
  }

  Future<UnionResp<void>> addComment(int newsId, String content) async {
    return await handlerResult(
      post("/api/user/news/comment/", {"news_id": newsId, "content": content}),
    );
  }

  Future<UnionResp<NewsCommentModel>> updateComment(
      int commentId, String content) async {
    return await handlerResult(
        put("/api/user/news/comment/$commentId/", {"content": content}),
        transform: (body) {
      return NewsCommentModel.fromJson(body["data"]);
    });
  }

  Future<UnionResp<void>> deleteComment(int commentId) async {
    return await handlerResult(
      delete("/api/user/news/comment/$commentId/"),
    );
  }
}
