class ResetPasswordSuccessResponse{
  final String? token;
  final String? phone;
  final String? email;
  final String? fullName;
  final String? message;
  // final String? code ;

  ResetPasswordSuccessResponse({this.phone, this.email, this.fullName, this.token,this.message});

  factory ResetPasswordSuccessResponse.fromJson({
    required Map<String,dynamic>json}){
    return ResetPasswordSuccessResponse(
      token : json['token'],
      phone : json['phone'],
      email : json['email'],
      fullName : json['full_name'],
      message : json['message'],
    );
  }

  factory ResetPasswordSuccessResponse.fromNotVerified({required Map<String, dynamic> json}) {
    return ResetPasswordSuccessResponse(
      message :json['password'] ?? json['message'] ??  json['non_field_errors'] == null ? '' : List<String>.from(json['non_field_errors']).first,
      // code: json['code'],
    );
  }


}

class ResetPasswordErrorResponse{
  final String? message;
  final String? code ;
  ResetPasswordErrorResponse({ this.message, this.code});
  factory ResetPasswordErrorResponse.fromJson({
    required Map<String,dynamic>json}){
    return ResetPasswordErrorResponse(
      message :json['password'] ?? json['message'] ??  json['non_field_errors'] == null ? null : List<String>.from(json['non_field_errors']).first,
      code: json['code'],
    );
  }
}


class ChangePasswordSuccessResponse{
  final String? oldPassword;
  final String? message ;
  final String? url ;

  ChangePasswordSuccessResponse({this.oldPassword,this.message,this.url});

  factory ChangePasswordSuccessResponse.fromJson({
    required Map<String,dynamic>json}){
    return ChangePasswordSuccessResponse(
      message : json['message'],
      url : json['url'],
    );
  }

  factory ChangePasswordSuccessResponse.fromNotVerified({required Map<String, dynamic> json}) {
    return ChangePasswordSuccessResponse(
        oldPassword: json['old_password'],
      message : json['message'],
    );
  }

}

class ChangePasswordErrorResponse{
  final String? message;
  ChangePasswordErrorResponse({required this.message});
  factory ChangePasswordErrorResponse.fromJson({
    required Map<String,dynamic>json}){
    return ChangePasswordErrorResponse(
      message : json['message'] ,
    );
  }
}