class DoctorsDetailsModel {
  DoctorsDetailsModel({
    this.success,
    this.doctor,
  });

  DoctorsDetailsModel.fromJson(dynamic json) {
    success = json['success'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }

  bool? success;
  Doctor? doctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    return map;
  }
}

class Doctor {
  Doctor({
    this.image,
    this.mapLocation,
    this.id,
    this.name,
    this.phoneNumber,
    this.address,
    this.aboutDoctor,
    this.avgRating,
    this.experience,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Doctor.fromJson(dynamic json) {
    // Handle image
    image = json['image'] != null ? Image.fromJson(json['image']) : null;

    // Safely parse mapLocation only if it's a Map
    if (json['mapLocation'] is Map<String, dynamic>) {
      mapLocation = MapLocation.fromJson(json['mapLocation']);
    } else {
      mapLocation = null; // Skip invalid mapLocation
    }

    // String fields
    id = json['_id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    aboutDoctor = json['aboutDoctor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    // Numeric fields with safe parsing
    avgRating = double.tryParse(json['avgRating'].toString()) ?? 0.0;
    experience = int.tryParse(json['experience'].toString()) ?? 0;
    v = int.tryParse(json['__v'].toString()) ?? 0;
  }

  Image? image;
  MapLocation? mapLocation;
  String? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? aboutDoctor;
  double? avgRating;
  int? experience;
  String? createdAt;
  String? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (image != null) {
      map['image'] = image?.toJson();
    }
    if (mapLocation != null) {
      map['mapLocation'] = mapLocation?.toJson();
    }
    map['_id'] = id;
    map['name'] = name;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['aboutDoctor'] = aboutDoctor;
    map['avgRating'] = avgRating;
    map['experience'] = experience;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class Image {
  Image({
    this.url,
    this.id,
  });

  Image.fromJson(dynamic json) {
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

class MapLocation {
  MapLocation({
    this.lng,
    this.lat,
  });

  MapLocation.fromJson(dynamic json) {
    lng = json['lng']?.toString(); // Force string conversion
    lat = json['lat']?.toString();
  }

  String? lng;
  String? lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lng'] = lng;
    map['lat'] = lat;
    return map;
  }
}