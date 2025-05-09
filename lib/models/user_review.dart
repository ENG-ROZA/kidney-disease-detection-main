// class UserReviewModel {
//   final bool success;
//   final List<Review> results;

//   UserReviewModel({
//     required this.success,
//     required this.results,
//   });

//   factory UserReviewModel.fromJson(Map<String, dynamic> json) {
//     return UserReviewModel(
//       success: json['success'] as bool,
//       results: (json['results'] as List)
//           .map((review) => Review.fromJson(review as Map<String, dynamic>))
//           .toList(),
//     );
//   }
// }

// class Review {
//   final String id;
//   final ReviewUser user;
//   final ReviewDoctor doctor;
//   final double rating;
//   final String comment;
//   final String createdAt;
//   final String updatedAt;
//   final int version;

//   Review({
//     required this.id,
//     required this.user,
//     required this.doctor,
//     required this.rating,
//     required this.comment,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//   });

//   factory Review.fromJson(Map<String, dynamic> json) {
//     return Review(
//       id: json['_id'].toString(),
//       user: ReviewUser.fromJson(json['user'] as Map<String, dynamic>),
//       doctor: ReviewDoctor.fromJson(json['doctor'] as Map<String, dynamic>),
//       rating: double.tryParse(json['rating'].toString()) ?? 0.0,
//       comment: json['comment'].toString(),
//       createdAt: json['createdAt'].toString(),
//       updatedAt: json['updatedAt'].toString(),
//       version: int.tryParse(json['__v'].toString()) ?? 0,
//     );
//   }
// }

// class ReviewUser {
//   final String id;
//   final String userName;
//   final ProfileImage profileImage;

//   ReviewUser({
//     required this.id,
//     required this.userName,
//     required this.profileImage,
//   });

//   factory ReviewUser.fromJson(Map<String, dynamic> json) {
//     return ReviewUser(
//       id: json['_id'].toString(),
//       userName: json['userName'].toString(),
//       profileImage:
//           ProfileImage.fromJson(json['profileImage'] as Map<String, dynamic>),
//     );
//   }
// }

// class ProfileImage {
//   final String url;
//   final String id;

//   ProfileImage({
//     required this.url,
//     required this.id,
//   });

//   factory ProfileImage.fromJson(Map<String, dynamic> json) {
//     return ProfileImage(
//       url: json['url'].toString(),
//       id: json['id'].toString(),
//     );
//   }
// }

// class ReviewDoctor {
//   final String id;
//   final String name;
//   final String phoneNumber;
//   final String address;
//   final String aboutDoctor;
//   final double avgRating;
//   final int experience;
//   final DoctorImage image;
//   final MapLocation mapLocation;
//   final String createdAt;
//   final String updatedAt;
//   final int version;

//   ReviewDoctor({
//     required this.id,
//     required this.name,
//     required this.phoneNumber,
//     required this.address,
//     required this.aboutDoctor,
//     required this.avgRating,
//     required this.experience,
//     required this.image,
//     required this.mapLocation,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.version,
//   });

//   factory ReviewDoctor.fromJson(Map<String, dynamic> json) {
//     MapLocation mapLoc;
//     if (json['mapLocation'] is Map<String, dynamic>) {
//       mapLoc =
//           MapLocation.fromJson(json['mapLocation'] as Map<String, dynamic>);
//     } else {
//       mapLoc = MapLocation(lng: '', lat: '');
//     }

//     return ReviewDoctor(
//       id: json['_id'].toString(),
//       name: json['name'].toString(),
//       phoneNumber: json['phoneNumber'].toString(),
//       address: json['address'].toString(),
//       aboutDoctor: json['aboutDoctor'].toString(),
//       avgRating: double.tryParse(json['avgRating'].toString()) ?? 0.0,
//       experience: int.tryParse(json['experience'].toString()) ?? 0,
//       image: DoctorImage.fromJson(json['image'] as Map<String, dynamic>),
//       mapLocation: mapLoc,
//       createdAt: json['createdAt'].toString(),
//       updatedAt: json['updatedAt'].toString(),
//       version: int.tryParse(json['__v'].toString()) ?? 0,
//     );
//   }
// }

// class DoctorImage {
//   final String url;
//   final String id;

//   DoctorImage({
//     required this.url,
//     required this.id,
//   });

//   factory DoctorImage.fromJson(Map<String, dynamic> json) {
//     return DoctorImage(
//       url: json['url'].toString(),
//       id: json['id'].toString(),
//     );
//   }
// }

// class MapLocation {
//   final String lng;
//   final String lat;

//   MapLocation({
//     required this.lng,
//     required this.lat,
//   });

//   factory MapLocation.fromJson(Map<String, dynamic> json) {
//     return MapLocation(
//       lng: json['lng']?.toString() ?? '',
//       lat: json['lat']?.toString() ?? '',
//     );
//   }
// }
class UserReviewModel {
  final bool success;
  final List<Review> results;

  UserReviewModel({
    required this.success,
    required this.results,
  });

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return UserReviewModel(
      success: (json['success'] as bool?) ?? false,
      results: (json['results'] as List<dynamic>?)
              ?.map((review) => Review.fromJson(review))
              .toList() ??
          [],
    );
  }
}

class Review {
  final String id;
  final ReviewUser? user; // Allow user to be nullable
  final ReviewDoctor? doctor; // Allow doctor to be nullable
  final double rating;
  final String comment;
  final String createdAt;
  final String updatedAt;
  final int version;

  Review({
    required this.id,
    this.user,
    this.doctor,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: (json['_id']?.toString()) ?? '',
      user: json['user'] != null
          ? ReviewUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      doctor: json['doctor'] != null
          ? ReviewDoctor.fromJson(json['doctor'] as Map<String, dynamic>)
          : null,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: (json['comment']?.toString()) ?? '',
      createdAt: (json['createdAt']?.toString()) ?? '',
      updatedAt: (json['updatedAt']?.toString()) ?? '',
      version: (json['__v'] as int?) ?? 0,
    );
  }
}

class ReviewUser {
  final String id;
  final String userName;
  final ProfileImage? profileImage; // Allow profileImage to be nullable

  ReviewUser({
    required this.id,
    required this.userName,
    this.profileImage,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: (json['_id']?.toString()) ?? '',
      userName: (json['userName']?.toString()) ?? 'Unknown User',
      profileImage: json['profileImage'] != null
          ? ProfileImage.fromJson(json['profileImage'] as Map<String, dynamic>)
          : null,
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
      url: (json['url']?.toString()) ?? '',
      id: (json['id']?.toString()) ?? '',
    );
  }
}

class ReviewDoctor {
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final String aboutDoctor;
  final double avgRating;
  final int experience;
  final DoctorImage? image; // Allow image to be nullable
  final MapLocation mapLocation;
  final String createdAt;
  final String updatedAt;
  final int version;

  ReviewDoctor({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.aboutDoctor,
    required this.avgRating,
    required this.experience,
    this.image,
    required this.mapLocation,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ReviewDoctor.fromJson(Map<String, dynamic> json) {
    return ReviewDoctor(
      id: (json['_id']?.toString()) ?? '',
      name: (json['name']?.toString()) ?? 'Unknown Doctor',
      phoneNumber: (json['phoneNumber']?.toString()) ?? 'N/A',
      address: (json['address']?.toString()) ?? 'No address provided',
      aboutDoctor: (json['aboutDoctor']?.toString()) ?? '',
      avgRating: (json['avgRating'] as num?)?.toDouble() ?? 0.0,
      experience: (json['experience'] as int?) ?? 0,
      image: json['image'] != null
          ? DoctorImage.fromJson(json['image'] as Map<String, dynamic>)
          : null,
      mapLocation: json['mapLocation'] != null
          ? MapLocation.fromJson(json['mapLocation'] as Map<String, dynamic>)
          : MapLocation(lng: '', lat: ''),
      createdAt: (json['createdAt']?.toString()) ?? '',
      updatedAt: (json['updatedAt']?.toString()) ?? '',
      version: (json['__v'] as int?) ?? 0,
    );
  }
}

class DoctorImage {
  final String url;
  final String id;

  DoctorImage({
    required this.url,
    required this.id,
  });

  factory DoctorImage.fromJson(Map<String, dynamic> json) {
    return DoctorImage(
      url: (json['url']?.toString()) ?? '',
      id: (json['id']?.toString()) ?? '',
    );
  }
}

class MapLocation {
  final String lng;
  final String lat;

  MapLocation({
    required this.lng,
    required this.lat,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) {
    return MapLocation(
      lng: (json['lng']?.toString()) ?? '',
      lat: (json['lat']?.toString()) ?? '',
    );
  }
}
