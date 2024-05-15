class CamModel {
  CamModel({
    this.message,
      this.camera,});

  CamModel.fromJson(dynamic json) {
    message=json['message'];
    if (json['camera'] != null) {
      camera = [];
      json['camera'].forEach((v) {
        camera?.add(Camera.fromJson(v));
      });
    }
  }
  List<Camera>? camera;
  String? message;
  Map<String, dynamic> toJson() {

    final map = <String, dynamic>{};
    map['message'] = message;
    if (camera != null) {
      map['camera'] = camera?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Camera {
  Camera({
      this.id, 
      this.model, 
      this.startService, 
      this.factory,
    this.message});

  Camera.fromJson(dynamic json) {
    id = json['id'];
    message=json['message'];
    model = json['model'];
    startService = json['start_service'];
    factory = json['factory'];
  }
  int? id;
  String? model;
  String? message;
  dynamic startService;
  String? factory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['model'] = model;
    map['message'] = message;
    map['start_service'] = startService;
    map['factory'] = factory;
    return map;
  }

}