class RoadModel {
  RoadModel({
      this.id, 
      this.name, 
      this.address,
    this.message,
  });

  RoadModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    message= json['message'];
  }
  int? id;
  String? name;
  String? address;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['message'] =message;
    return map;
  }

}