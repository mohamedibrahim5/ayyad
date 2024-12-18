class LoginSuccessResponse {
  final String? refresh;
  final String? phone;
  final String? token;
  final bool? isVerified;
  final String? message;
  final String? email;
  final String? fullName;
  final LoginData? data;

  LoginSuccessResponse(
      {this.refresh,
      this.token,
      this.phone,
        this.isVerified,
        this.message,
        this.email,
        this.fullName,
        this.data
      });

  factory LoginSuccessResponse.fromJson({required Map<String, dynamic> json}) {
    return LoginSuccessResponse(
      refresh: json['refresh'],
      token: json['token'],
      phone: json['phone'],
      isVerified: json['is_verified'],
        message: json['message'],
        email: json['email'],
        fullName: json['full_name'],
        data: LoginData.fromJson(json: json['data'])
    );
  }
  factory LoginSuccessResponse.fromNotVerified({required Map<String, dynamic> json}) {
    return LoginSuccessResponse(
      isVerified: false,
      message: json['message']
    );
  }
}

class LoginErrorResponse {
  final String? message;
  final String? phone;
  final String? password;
  final bool? isVerified;
  LoginErrorResponse({ this.message, this.phone, this.password,this.isVerified});

  factory LoginErrorResponse.fromJson({required Map<String, dynamic> json}) {
    return LoginErrorResponse(
      message: json['message'],
      phone: json['phone'],
      password: json['password'],
        isVerified: json['is_active']
    );
  }
}

class LoginData {
  final String? access;

  LoginData({this.access,});

  factory LoginData.fromJson({required Map<String, dynamic> json}) {
    return LoginData(
      access: json['access'],
    );
  }
}
