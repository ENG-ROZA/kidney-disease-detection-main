class ArticlesResponse {
  ArticlesResponse({
    this.success,
    this.results,
  });

  ArticlesResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Result.fromJson(v));
      });
    }
  }

  bool? success;
  List<Result>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Result {
  Result({
    this.image,
    this.id,
    this.title,
    this.content,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Result.fromJson(dynamic json) {
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
    id = json['_id'];
    title = json['title'];
    content = json['content'];
    author = json['author'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    v = json['__v'];
  }

  ImageModel? image;
  String? id;
  String? title;
  String? content;
  String? author;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['_id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['author'] = author;
    map['createdAt'] = createdAt?.toIso8601String();
    map['updatedAt'] = updatedAt?.toIso8601String();
    map['__v'] = v;
    return map;
  }
}

class ImageModel {
  ImageModel({
    this.url,
    this.id,
  });

  ImageModel.fromJson(dynamic json) {
    url = json['url'];
    id = json['id'];
  }

  String? url;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['id'] = id;
    return map;
  }
}