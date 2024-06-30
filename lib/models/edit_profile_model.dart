class EditProfileModel {
  final String message;
  final int id;
  final String name;
  final String address;
  final String email;
  final String password;
  final bool isAdmin;
  final bool isPremium;
  final String carLicense;
  final String? resetCode;
  final DateTime lastResetDate;
  final bool? isVerified;
  final String? avatar;

  EditProfileModel({
    required this.message,
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.password,
    required this.isAdmin,
    required this.isPremium,
    required this.carLicense,
    this.resetCode,
    required this.lastResetDate,
    this.isVerified,
    this.avatar,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return EditProfileModel(
      message: jsonData['message'] ?? '',
      id: jsonData['user']['id'] ?? 0,
      name: jsonData['user']['name'] ?? '',
      address: jsonData['user']['address'] ?? '',
      email: jsonData['user']['email'] ?? '',
      password: jsonData['user']['password'] ?? '',
      isAdmin: jsonData['user']['is_admin'] ?? false,
      isPremium: jsonData['user']['is_premium'] ?? false,
      carLicense: jsonData['user']['car_license'] ?? '',
      resetCode: jsonData['user']['reset_code'],
      lastResetDate: DateTime.parse(jsonData['user']['last_reset_date']),
      isVerified: jsonData['user']['is_verified'],
      avatar: jsonData['user']['avatar'],
    );
  }
}
