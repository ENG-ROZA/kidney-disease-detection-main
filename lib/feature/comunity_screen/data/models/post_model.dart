import 'package:graduation_project/feature/comunity_screen/data/models/comment_model.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/like_model.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/media_model.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/user_model.dart';

class PostModel {
  final String id;
  final User user;
  final String content;
  final List<MediaModel> media;
  final String tag;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int commentCount;
  final List<LikeModel> likes;
  final int likesCount;
  final List<CommentModel> comments;
  final bool isLiked;

  final bool myOwnPost;

  PostModel(
      {required this.id,
      required this.user,
      required this.content,
      required this.media,
      required this.tag,
      required this.createdAt,
      required this.updatedAt,
      required this.commentCount,
      required this.likes,
      required this.likesCount,
      required this.comments,
      required this.isLiked,
      required this.myOwnPost});
  factory PostModel.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) {
      throw ArgumentError("jsonData is null");
    }

    return PostModel(
      myOwnPost: jsonData['myOwnPost'] ?? false,
      id: jsonData["_id"] ?? '',
      user: User.fromJson(jsonData['userId']),
      content: jsonData['content'] ?? '',
      media: (jsonData['media'] as List? ?? [])
          .map((e) => MediaModel.fromJson(e))
          .toList(),
      tag: jsonData['tag'] ?? '',
      createdAt: jsonData['createdAt'] != null
          ? DateTime.parse(jsonData['createdAt'])
          : DateTime.now(), // default if null
      updatedAt: jsonData['updatedAt'] != null
          ? DateTime.parse(jsonData['updatedAt'])
          : DateTime.now(), // default if null
      commentCount: jsonData['commentCount'] ?? 0,
      likes: (jsonData['likes'] as List? ?? [])
          .map((e) => LikeModel.fromJson(e))
          .toList(),
      likesCount: jsonData['likesCount'] ?? 0,
      comments: (jsonData['comments'] as List? ?? [])
          .map((e) => CommentModel.fromJson(e))
          .toList(),
      isLiked: jsonData['isLiked'] ?? false,
    );
  }
}
