class ArticleDetailsResponse {
  final bool success;
  final Article article;

  ArticleDetailsResponse({
    required this.success,
    required this.article,
  });

  factory ArticleDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ArticleDetailsResponse(
      success: json['success'],
      article: Article.fromJson(json['article']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'article': article.toJson(),
    };
  }
}

class Article {
  final Image image;
  final String id;
  final String title;
  final String content;
  final String author;
  final String createdAt;
  final String updatedAt;
  final int version;

  Article({
    required this.image,
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      image: Image.fromJson(json['image']),
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image.toJson(),
      '_id': id,
      'title': title,
      'content': content,
      'author': author,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}

class Image {
  final String url;
  final String id;

  Image({
    required this.url,
    required this.id,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'id': id,
    };
  }
}