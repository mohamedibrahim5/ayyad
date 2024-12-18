class ResetPasswordRequest{
  final String phone;
  final String otp;
  final String password;

  ResetPasswordRequest({
    required this.phone,
    required this.otp,
    required this.password});


  Map<String,dynamic>toJson(){
    return{
      'phone':phone,
      // 'otp':otp,
      'password':password,
      'confirm_password':password
      // 'new_password2':password
    };
  }



}


class ChangePasswordRequest{
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    });


  Map<String,dynamic>toJson(){
    return{
      'old_password':oldPassword,
      'new_password':newPassword,
      'confirm_password':newPassword
    };
  }



}