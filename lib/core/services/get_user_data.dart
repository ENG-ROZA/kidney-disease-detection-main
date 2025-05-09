// import 'package:g_p_alaa/core/helper/api.dart';
// import 'package:g_p_alaa/feature/comunity_screen/data/models/post_model.dart';

// class AllPostsServices {
//   Future<List<PostModel>> getAllPosts() async {
//     print("1");
//     Map<String, dynamic> data = await ApiMethod().get(
//       url: "https://renalyze-amiras-projects-2023fd67.vercel.app/user",
//     );

//     final results = data['results'];
//     final postsJson = results['posts'] as List<dynamic>;

//     List<PostModel> postList = [];

//     for (var postJson in postsJson) {
//       if (postJson != null) {
//         postList.add(PostModel.fromJson(postJson));
//       }
//     }

//     print(postList.length);
//     return postList;
//   }
// }
