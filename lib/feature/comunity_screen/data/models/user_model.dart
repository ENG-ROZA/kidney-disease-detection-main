class User {
  final String id;
  final String userName;
  final ProfileImage profileImage;

  User({
    required this.id,
    required this.userName,
    required this.profileImage,
  });

  factory User.fromJson(dynamic jsonData) {
    if (jsonData == null) {
      return User(
        id: '',
        userName: '',
        profileImage: ProfileImage(url: '', id: ''),
      );
    }
    return User(
      id: jsonData['_id'] ?? '',
      userName: jsonData['userName'] ?? '',
      profileImage: ProfileImage.fromJson(jsonData['profileImage'] ?? {}),
    );
  }
}

class ProfileImage {
  final String url;
  final String id;

  ProfileImage({
    required this.url,
    required this.id,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'],
      id: json['id'],
    );
  }
}