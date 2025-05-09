import 'dart:io';

class UpdatePostRequest {
  String? content;
  String? tag;
  File? media;

  UpdatePostRequest({this.content, this.tag, this.media});

  Map<String, dynamic> toJson() {
    return {
      if (content != null) "content": content,
      if (tag != null) "tag": tag,
      if (media != null) "media": media,
    };
  }
}
