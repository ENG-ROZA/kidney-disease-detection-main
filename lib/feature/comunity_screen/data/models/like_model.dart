
import 'package:graduation_project/feature/comunity_screen/data/models/user_model.dart';

class LikeModel {
  final String id;
  final User user;
  final String targetId;

  LikeModel({
    required this.id,
    required this.user,
    required this.targetId,
  });

  factory LikeModel.fromJson(jsonData) {
    return LikeModel(
      id: jsonData['_id'],
      user: User.fromJson(jsonData['userId']),
      targetId: jsonData['targetId'],
    );
  }
}
