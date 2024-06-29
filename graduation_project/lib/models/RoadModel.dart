class RoadModel {
  RoadModel({
    this.id,
    this.name,
    this.address,
    this.message,
  });

  int? id;
  String? name;
  String? address;
  String? message;

  factory RoadModel.fromJson(Map<String, dynamic> json) {
    return RoadModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'message': message,
    };
  }
}
