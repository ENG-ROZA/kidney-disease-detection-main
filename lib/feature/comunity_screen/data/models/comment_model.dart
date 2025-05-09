
import 'package:graduation_project/feature/comunity_screen/data/models/user_model.dart';

class CommentModel {
  final String id;
  final User user;
  final String postId;
  final String content;
  final DateTime createdAt;
  final int repliesCount;
  final List<dynamic> likes;
  final int likesCount;
  final bool isLiked;
  final List<dynamic> media;  

  CommentModel({
    required this.id,
    required this.user,
    required this.postId,
    required this.content,
    required this.createdAt,
    required this.repliesCount,
    required this.likes,
    required this.likesCount,
    required this.isLiked,
    required this.media,  // إضافة هذا الحقل
  });
factory CommentModel.fromJson(Map<String, dynamic> jsonData) {
  final userJson = jsonData['userId'];

  return CommentModel(
    id: jsonData['_id'],
    user: userJson is Map<String, dynamic>
        ? User.fromJson(userJson)
        : User(
            userName: "Unknown",
            profileImage: ProfileImage(url: "", id: ''), id: '',
          ),
    postId: jsonData['postId'],
    content: jsonData['content'],
    createdAt: DateTime.parse(jsonData['createdAt']),
    repliesCount: jsonData['repliesCount'] ?? 0,
    likes: jsonData['likes'] ?? [],
    likesCount: jsonData['likesCount'] ?? 0,
    isLiked: jsonData['isLiked'] ?? false,
    media: jsonData['media'] ?? [],
  );
}

}
