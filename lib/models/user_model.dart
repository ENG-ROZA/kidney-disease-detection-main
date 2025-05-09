class UserModel {
  UserModel({
    this.success,
    this.results,
  });

  UserModel.fromJson(dynamic json) {
    success = json['success'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  bool? success;
  Results? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (results != null) {
      map['results'] = results?.toJson();
    }
    return map;
  }
}

class Results {
  Results({
    this.user,
  });

  Results.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    this.profileImage,
    this.userName,
    this.email,
  });

  User.fromJson(dynamic json) {
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    userName = json['userName'];
    email = json['email'];
  }

  ProfileImage? profileImage;
  String? userName;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profileImage != null) {
      map['profileImage'] = profileImage?.toJson();
    }
    map['userName'] = userName;
    map['email'] = email;
    return map;
  }
}

class ProfileImage {
  ProfileImage({
    this.url,
    this.id,
  });

  ProfileImage.fromJson(dynamic json) {
    url = json['url'];
    id = json['id'];
  }

  String? url;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['id'] = id;
    return map;
  }
}
