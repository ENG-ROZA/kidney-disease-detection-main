import 'package:graduation_project/core/helper/api.dart';
import 'package:graduation_project/feature/comunity_screen/data/models/user_data_model.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';

class GetUserPostsDataService {
  static Future<UserPostsDataModel> getUserPostsDataByPost(
      String userId) async {
    Map<String, dynamic> data = await ApiMethod().get(
      url: "https://renalyze-production.up.railway.app/post/profile/$userId",
      token: CachedData.getFromCache("token"),
    );

    UserPostsDataModel postList = UserPostsDataModel.fromJson(data);

    return postList;
  }
}
