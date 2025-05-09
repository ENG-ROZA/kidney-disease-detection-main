import 'package:graduation_project/core/helper/api.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/comment_model.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';

class CreateCommentServices {
  Future<CommentModel> createComment(
      {required String content,
      String? media,
      String? imagePath,
      required String postId}) async {
    Map<String, dynamic> body = {
      'content': content,
      'media': imagePath ?? (media != null && media.isNotEmpty ? media : []),
    };
    var token = CachedData.getFromCache('token');

    final response = await ApiMethod().post(
      url: "https://renalyze-production.up.railway.app/post/$postId/comment",
      body: body,
      token: "TOKEN__$token",
    );
    print("Response: $response");

    if (response != null && response['comment'] != null) {
      return CommentModel.fromJson(response['comment']);
    } else {
      throw Exception("Unexpected response format: $response");
    }
  }
}
