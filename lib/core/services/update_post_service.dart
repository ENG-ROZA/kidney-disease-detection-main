import 'package:graduation_project/feature/comunity_screen/data/models/update_post_request.dart';
import 'package:graduation_project/shared/network/local/cached_data.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class UpdatePostService {
  static Future<http.StreamedResponse> updatePost({
    required String postId,
    required UpdatePostRequest requestData,
  }) async {
    final uri = Uri.parse(
        "https://renalyze-production.up.railway.app/post/update/$postId"); // غيرها حسب API

    final request = http.MultipartRequest("PATCH", uri);

    request.headers['token'] = 'TOKEN__${CachedData.getFromCache('token')}';

    if (requestData.content != null) {
      request.fields["content"] = requestData.content!;
    }

    if (requestData.tag != null) {
      request.fields["tag"] = requestData.tag!;
    }

    if (requestData.media != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "media",
          requestData.media!.path,
          filename: basename(requestData.media!.path),
          contentType: MediaType("image", "jpeg"), // تأكد من نوع الصورة
        ),
      );
    }

    return await request.send();
  }
}
