class ScanResultDetails {
  ScanResultDetails({
    this.success,
    this.result,
  });

  ScanResultDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result = json['result'] != null 
        ? ScanResult.fromJson(json['result']) 
        : null;
  }

  bool? success;
  ScanResult? result;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class ScanResult {
  ScanResult({
    this.scanFile,
    this.scanId,
    this.userId,
    this.diagnosis,
    this.confidence,
    this.condition,
    this.details,
    this.recommendations,
    this.pdfUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ScanResult.fromJson(Map<String, dynamic> json) {
    scanFile = json['scanFile'] != null
        ? ScanFile.fromJson(json['scanFile'])
        : null;
    scanId = json['_id'];
    userId = json['userId'];
    diagnosis = json['diagnosis'];
    confidence = json['confidence'];
    condition = json['condition'];
    details = json['details'];
    recommendations = json['recommendations'];
    pdfUrl = json['pdfUrl'];
    createdAt = json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null;
    updatedAt = json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null;
    v = json['__v'];
  }

  ScanFile? scanFile;
  String? scanId;
  String? userId;
  String? diagnosis;
  String? confidence;
  String? condition;
  String? details;
  String? recommendations;
  String? pdfUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (scanFile != null) {
      data['scanFile'] = scanFile?.toJson();
    }
    data['_id'] = scanId;
    data['userId'] = userId;
    data['diagnosis'] = diagnosis;
    data['confidence'] = confidence;
    data['condition'] = condition;
    data['details'] = details;
    data['recommendations'] = recommendations;
    data['pdfUrl'] = pdfUrl;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['__v'] = v;
    return data;
  }
}

class ScanFile {
  ScanFile({
    this.url,
    this.id,
  });

  ScanFile.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    id = json['id'];
  }

  String? url;
  String? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['id'] = id;
    return data;
  }
}