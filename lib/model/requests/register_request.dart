
class UserRegisterRequest {
  final String fullName;
  final String phone;
  final String email;
  final String password;
  UserRegisterRequest({
    required this.fullName,
required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
        'full_name': fullName,
        'phone': phone,
        'password': password,
        'email':email
    };
  }
}
