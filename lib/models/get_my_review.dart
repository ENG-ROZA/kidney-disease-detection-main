class GetMyReview {
  final bool success;
  final Review? review;

  GetMyReview({
    required this.success,
    this.review,
  });

  GetMyReview copyWith({
    bool? success,
    Review? review,
  }) {
    return GetMyReview(
      success: success ?? this.success,
      review: review ?? this.review,
    );
  }

  factory GetMyReview.fromJson(Map<String, dynamic> json) {
    return GetMyReview(
      success: json["success"] ?? false,
      review: json["review"] == null ? null : Review.fromJson(json["review"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "review": review?.toJson(),
      };

  @override
  String toString() {
    return "$success, $review";
  }
}

class Review {
  final String id;
  final User? user;
  final Doctor? doctor;
  final int rating;
  final String comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  Review({
    required this.id,
    this.user,
    this.doctor,
    required this.rating,
    required this.comment,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  Review copyWith({
    String? id,
    User? user,
    Doctor? doctor,
    int? rating,
    String? comment,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Review(
      id: id ?? this.id,
      user: user ?? this.user,
      doctor: doctor ?? this.doctor,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json["_id"] ?? "",
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      rating: json["rating"] is int ? json["rating"] : int.tryParse(json["rating"].toString()) ?? 0,
      comment: json["comment"] ?? "",
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] is int ? json["__v"] : int.tryParse(json["__v"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "doctor": doctor?.toJson(),
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  String toString() {
    return "$id, $user, $doctor, $rating, $comment, $createdAt, $updatedAt, $v";
  }
}

class Doctor {
  final Image? image;
  final MapLocation? mapLocation;
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final String aboutDoctor;
  final double avgRating;
  final int experience;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  Doctor({
    this.image,
    this.mapLocation,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.aboutDoctor,
    required this.avgRating,
    required this.experience,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  Doctor copyWith({
    Image? image,
    MapLocation? mapLocation,
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? aboutDoctor,
    double? avgRating,
    int? experience,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Doctor(
      image: image ?? this.image,
      mapLocation: mapLocation ?? this.mapLocation,
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      aboutDoctor: aboutDoctor ?? this.aboutDoctor,
      avgRating: avgRating ?? this.avgRating,
      experience: experience ?? this.experience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // Safely parse mapLocation only if it's a Map
    MapLocation? mapLoc;
    if (json["mapLocation"] is Map<String, dynamic>) {
      mapLoc = MapLocation.fromJson(json["mapLocation"]);
    } else {
      mapLoc = null;
    }

    return Doctor(
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
      mapLocation: mapLoc,
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      address: json["address"] ?? "",
      aboutDoctor: json["aboutDoctor"] ?? "",
      avgRating: (json["avgRating"] is num)
          ? json["avgRating"].toDouble()
          : double.tryParse(json["avgRating"].toString()) ?? 0.0,
      experience: (json["experience"] is int)
          ? json["experience"]
          : int.tryParse(json["experience"].toString()) ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] is int ? json["__v"] : int.tryParse(json["__v"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "mapLocation": mapLocation?.toJson(),
        "_id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "aboutDoctor": aboutDoctor,
        "avgRating": avgRating,
        "experience": experience,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  String toString() {
    return "$image, $mapLocation, $id, $name, $phoneNumber, $address, $aboutDoctor, $avgRating, $experience, $createdAt, $updatedAt, $v";
  }
}

class Image {
  final String url;
  final String id;

  Image({
    required this.url,
    required this.id,
  });

  Image copyWith({
    String? url,
    String? id,
  }) {
    return Image(
      url: url ?? this.url,
      id: id ?? this.id,
    );
  }

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json["url"] ?? "",
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
      };

  @override
  String toString() {
    return "$url, $id";
  }
}

class MapLocation {
  final String lng;
  final String lat;

  MapLocation({
    required this.lng,
    required this.lat,
  });

  MapLocation copyWith({
    String? lng,
    String? lat,
  }) {
    return MapLocation(
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
    );
  }

  factory MapLocation.fromJson(Map<String, dynamic> json) {
    return MapLocation(
      lng: json["lng"]?.toString() ?? "",
      lat: json["lat"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "lng": lng,
        "lat": lat,
      };

  @override
  String toString() {
    return "$lng, $lat";
  }
}

class User {
  final Image? profileImage;
  final String id;
  final String userName;

  User({
    this.profileImage,
    required this.id,
    required this.userName,
  });

  User copyWith({
    Image? profileImage,
    String? id,
    String? userName,
  }) {
    return User(
      profileImage: profileImage ?? this.profileImage,
      id: id ?? this.id,
      userName: userName ?? this.userName,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profileImage: json["profileImage"] == null ? null : Image.fromJson(json["profileImage"]),
      id: json["_id"] ?? "",
      userName: json["userName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage?.toJson(),
        "_id": id,
        "userName": userName,
      };

  @override
  String toString() {
    return "$profileImage, $id, $userName";
  }
}