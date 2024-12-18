class ForgotPassRequest{
  final String phone;

  ForgotPassRequest({required this .phone});


  Map<String,dynamic> toJson(){
    return{
      'phone':phone,

    };

  }



}