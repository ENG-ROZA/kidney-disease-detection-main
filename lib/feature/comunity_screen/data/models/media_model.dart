class MediaModel {
  final String id;
  final String url;
  final String mediaId;

  MediaModel({
    required this.id,
    required this.url,
    required this.mediaId,
  });

  factory MediaModel.fromJson(jsonData) {
    return MediaModel(
      id: jsonData['_id'],
      url: jsonData['url'],
      mediaId: jsonData['id'],
    );
  }
}
