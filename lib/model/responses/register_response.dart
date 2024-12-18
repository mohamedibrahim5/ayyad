class UserRegisterSuccessResponse {
  final String? phone;
  final String? email;
  final String? fullName;
  final bool? isVerified;
  final String? message;
  UserRegisterSuccessResponse({
    this.phone,
    this.email,
    this.isVerified,
    this.fullName,
    this.message,
  });

  factory UserRegisterSuccessResponse.fromJson(
      {required Map<String, dynamic> json}) {
    return UserRegisterSuccessResponse(
      isVerified: json['is_verified'],
      phone: json['phone'],
      email: json['email'],
      fullName: json['full_name'],
      message: json['message'],
    );
  }

  factory UserRegisterSuccessResponse.fromNotVerified({required Map<String, dynamic> json}) {
    return UserRegisterSuccessResponse(
      isVerified: false,
      message: json['message'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}



class UserRegisterErrorResponse {
  final String? user;
  final String? email;
  final String? phone;
  final bool? isVerified;
  final String? message;
  UserRegisterErrorResponse({
    this.user,
    this.email,
    this.phone,
    this.isVerified,
    this.message
  });

  factory UserRegisterErrorResponse.fromJson(
      {required Map<String, dynamic> json}) {
    return UserRegisterErrorResponse(
      isVerified: json['is_active'],
      phone: json['phone'],
      email: json['email'],
      user: json['user'],
      message: json['message'],
   //   user: List<String>.from(json['user']),
    );
  }


}