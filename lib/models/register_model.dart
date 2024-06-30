class RegisterModel {
  final String token;
  final String name;
  final String email;
  final String password;
  final String address;
  final String carLicense;
  final int id;

  RegisterModel({
    required this.token,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.carLicense,
    required this.id,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> jsonData) {
    return RegisterModel(
      name: jsonData['data']['user']['name'] ?? '',
      email: jsonData['data']['user']['email'] ?? '',
      address: jsonData['data']['user']['address'] ?? '',
      carLicense: jsonData['data']['user']['car_license'] ?? '',
      id: jsonData['data']['user']['id'] ?? 0,
      token: jsonData['data']['user']['token'] ?? '',
      password: jsonData['data']['user']['password'] ?? '',
    );
  }
}
