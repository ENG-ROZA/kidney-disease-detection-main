import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:http_parser/http_parser.dart';

class CreatePostServices {
  Future<PostModel> createPost({
    required String tag,
    required String content,
    File? mediaFile,
  }) async {
    var token = CachedData.getFromCache("token");
    print("Token: $token");
    var uri = Uri.parse(
        "https://renalyze-amiras-projects-2023fd67.vercel.app/post/add");

    var request = http.MultipartRequest('POST', uri);

    request.headers.addAll({
      'token': 'TOKEN__$token' ?? '',
    });

    request.fields['tag'] = tag;
    request.fields['content'] = content;

    if (mediaFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'media',
          mediaFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return PostModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)["message"] ??
          "Error ${response.statusCode}: ${response.body}");
    }
  }
}
