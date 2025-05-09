import 'package:graduation_project/core/helper/api.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';

class ToggleLikeService {
  static Future<Map<String, dynamic>> toggleLike(
      {required String id, required String type}) async {
    final token = CachedData.getFromCache('token');

    final body = {
      "targetType": type,
    };

    final response = await ApiMethod().post(
      url: "https://renalyze-production.up.railway.app/post/toggleLike/$id",
      body: body,
      token: "TOKEN__$token",
    );

    if (response != null && response['success'] == true) {
      return {
        'message': response['message'],
        'postId': response['postId'],
        'like': response['like'],
      };
    } else {
      throw Exception("Failed to toggle like: $response");
    }
  }
}
