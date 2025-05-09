class ReviewModel {
  final bool success;
  final List<Review> results;

  ReviewModel({
    required this.success,
    required this.results,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      success: json['success'],
      results: (json['results'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'results': results.map((review) => review.toJson()).toList(),
    };
  }
}

class Review {
  final String id;
  final User user;
  final String doctor;
  final int rating;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final int version;

  Review({
    required this.id,
    required this.user,
    required this.doctor,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      user: User.fromJson(json['user']),
      doctor: json['doctor'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'doctor': doctor,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}

class User {
  final ReviewImage profileImage;
  final String id;
  final String userName;

  User({
    required this.profileImage,
    required this.id,
    required this.userName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profileImage: ReviewImage.fromJson(json['profileImage']),
      id: json['_id'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage.toJson(),
      '_id': id,
      'userName': userName,
    };
  }
}

class ReviewImage {
  final String url;
  final String id;

  ReviewImage({
    required this.url,
    required this.id,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) {
    return ReviewImage(
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
