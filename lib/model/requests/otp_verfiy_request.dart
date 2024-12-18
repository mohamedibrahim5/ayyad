class UserOtpVerifyRequest{
  final String? action;
  final String? phone;
  final String? otp;


  UserOtpVerifyRequest({
    this.action,
     this.phone,
    this.otp
});




  Map<String,dynamic>toJson(){
    return{
      if(action!=null)
        'action':action,
      'phone':phone,
      if(otp!=null)
        'otp':otp
    };
  }






}