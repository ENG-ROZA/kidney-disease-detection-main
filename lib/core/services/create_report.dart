import 'package:graduation_project/core/helper/api.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';

class CreateReportServices {
  Future<PostModel> createPost({
    required String tag,
    required String content,
    String? media,
  }) async {
    Map<String, dynamic> body = {
      'tag': tag,
      'content': content,
      "media": media,
    };
    var token = CachedData.getFromCache("token");
    if (media != null && media.isNotEmpty) {
      body['media'] = media;
    }

    final response = await ApiMethod().post(
      url: "https://renalyze-amiras-projects-2023fd67.vercel.app/post/add",
      body: body,
      token: "TOKEN__$token",
    );

    return PostModel.fromJson(response);
  }
}
