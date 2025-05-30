class DoctorsResponse {
  DoctorsResponse({
    this.success,
    this.results,
  });

  DoctorsResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Doctor.fromJson(v));
      });
    }
  }

  bool? success;
  List<Doctor>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
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
    image = json['image'] != null && json['image'] is Map<String, dynamic> 
        ? ImageModel.fromJson(json['image']) 
        : null;
    // Check if mapLocation is a Map before parsing
    mapLocation = json['mapLocation'] != null && json['mapLocation'] is Map<String, dynamic> 
        ? MapLocation.fromJson(json['mapLocation'])
        : null;
    id = json['_id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    aboutDoctor = json['aboutDoctor'];
    avgRating = double.tryParse(json['avgRating'].toString());
    experience = json['experience'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    v = json['__v'];
  }

  ImageModel? image;
  MapLocation? mapLocation;
  String? id;
  String? name;
  String? phoneNumber;
  String? address;
  String? aboutDoctor;
  double? avgRating;
  int? experience;
  DateTime? createdAt;
  DateTime? updatedAt;
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
    map['createdAt'] = createdAt?.toIso8601String();
    map['updatedAt'] = updatedAt?.toIso8601String();
    map['__v'] = v;
    return map;
  }
}

class ImageModel {
  ImageModel({
    this.url,
    this.id,
  });

  ImageModel.fromJson(dynamic json) {
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
    lng = json['lng'];
    lat = json['lat'];
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
