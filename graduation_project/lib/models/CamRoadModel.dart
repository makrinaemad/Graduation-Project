import 'dart:convert';
import 'package:http/http.dart' as http;

import 'CamModel.dart';

class CamRoadModel {
  CamRoadModel({
    this.camera,
    this.roadCamera,
  });

  CamRoadModel.fromJson(dynamic json) {
    camera = json['Camera'] != null ? Camera.fromJson(json['Camera']) : null;
    roadCamera = json['RoadCamera'] != null ? RoadCamera.fromJson(json['RoadCamera']) : null;
  }

  Camera? camera;
  RoadCamera? roadCamera;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (camera != null) {
      map['Camera'] = camera?.toJson();
    }
    if (roadCamera != null) {
      map['RoadCamera'] = roadCamera?.toJson();
    }
    return map;
  }
}

class RoadCamera {
  RoadCamera({
    this.id,
    this.roadId,
    this.camId,
    this.dimensions,
    this.active,
    this.startDate,
    this.endDate,
  });

  RoadCamera.fromJson(dynamic json) {
    id = json['id'];
    roadId = json['road_id'];
    camId = json['cam_id'];
    dimensions = json['dimensions'];
    active = json['active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  int? id;
  int? roadId;
  int? camId;
  String? dimensions;
  bool? active;
  String? startDate;
  dynamic endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['road_id'] = roadId;
    map['cam_id'] = camId;
    map['dimensions'] = dimensions;
    map['active'] = active;
    map['start_date'] = startDate;
    map['end_date'] = endDate;
    return map;
  }
}