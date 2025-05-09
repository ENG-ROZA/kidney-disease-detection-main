import 'package:graduation_project/feature/comunity_screen/data/models/post_model.dart';

class UserPostsDataModel {
  bool? success;
  UserDataModel? userData;

  List<PostModel>? posts;

  UserPostsDataModel({this.success, this.userData, this.posts});

  factory UserPostsDataModel.fromJson(Map<String, dynamic> json) {
    return UserPostsDataModel(
      success: json['success'] as bool,
      userData: UserDataModel.fromJson(json['user']),
      posts: (json['posts'] as List).map((e) => PostModel.fromJson(e)).toList(),
    );
  }
}

class UserDataModel {
  UserProfileImageModel? profileImage;

  String? id;
  String? userName;

  UserDataModel({
    this.profileImage,
    this.id,
    this.userName,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      profileImage: UserProfileImageModel.fromJson(json['profileImage']),
      id: json['_id'].toString(),
      userName: json['userName'].toString(),
    );
  }
}

class UserProfileImageModel {
  String? url;
  String? id;

  UserProfileImageModel({this.url, this.id});

  factory UserProfileImageModel.fromJson(Map<String, dynamic> json) {
    return UserProfileImageModel(
      url: json['url'].toString(),
      id: json['id'].toString(),
    );
  }
}
