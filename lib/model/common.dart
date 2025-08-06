class UnionResp<T> {
  final String? code;
  final String? message;
  final T? data;
  bool get isFail => code != "0";
  UnionResp({this.code, this.message, this.data});
}

class PageModel<T> {
  PageModel({
    this.next,
    this.previous,
    this.count,
    required this.results,
  });
  bool get hasNext => next != null;
  bool get hasPrevious => previous != null;
  final String? next;
  final String? previous;
  final num? count;
  final List<T> results;

  factory PageModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) convertor) {
    return PageModel(
      next: json["next"],
      previous: json["previous"],
      count: json["count"],
      results: ((json["results"] ?? []) as List<dynamic>)
          .map((json2) => convertor(json2))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
        "count": count,
        "results": results.map((x) => x).toList(),
      };
}
