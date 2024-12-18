class ForgotPassSuccessResponse{
  final String? phone;
  final String? otp ;
  final Data? data ;


  ForgotPassSuccessResponse({this.phone,this.otp,this.data});


  factory ForgotPassSuccessResponse.fromJson({
    required Map<String,dynamic>json}){
    return ForgotPassSuccessResponse(
      phone : json['phone'] ,
      otp : json['otp'],
      data : Data.fromJson(json['data']),
    );
  }

}

class Data {
  final bool? isActive;

  Data({this.isActive,});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      isActive: json['is_active'],
    );
  }
}

class ForgotPassErrorResponse{
  final String? phone;
  ForgotPassErrorResponse({required this.phone});


  factory ForgotPassErrorResponse.fromJson(
  {required Map<String,dynamic>json}){
    return ForgotPassErrorResponse(
      phone : json['phone'] == null ? json['message'] : List<String>.from(json['phone']).first,
    );

  }

}