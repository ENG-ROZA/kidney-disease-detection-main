import 'package:graduation_project/core/helper/api.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';

class AllPostsServices {
  Future<List<PostModel>> getAllPosts(
      {String? userId, bool? isAllCommunity}) async {
    String url = userId == null
        ? 'https://renalyze-production.up.railway.app/user'
        : 'https://renalyze-production.up.railway.app/post/profile/$userId';
    print("1");
    Map<String, dynamic> data = await ApiMethod().get(
      url: isAllCommunity == true
          ? "https://renalyze-production.up.railway.app/post/all"
          : url,
      token: CachedData.getFromCache("token"),
    );

    List<dynamic> results = isAllCommunity == true
        ? data['results']
        : (userId == null ? data['results']['posts'] : data['posts']);
    List<PostModel> postList = [];
    for (int i = 0; i < results.length; i++) {
      final jsonItem = results[i];
      if (jsonItem != null) {
        postList.add(PostModel.fromJson(jsonItem));
      }
    }
    print(postList.length);
    return postList;
  }
}
