class ResendOtpSuccessResponse{
  final String? message;
  final String? phone;
  final String? otp;

  ResendOtpSuccessResponse({
    this.message,
    this.phone,
    this.otp});

  factory ResendOtpSuccessResponse.fromJson({
    required Map<String,dynamic>json}){
    return ResendOtpSuccessResponse(
        message: json['message'],
        phone: json['phone'],
        otp: json['otp']
    );
  }



}



class ResendOtpErrorResponse{
  final String message;
ResendOtpErrorResponse({required this.message});
  factory ResendOtpErrorResponse.fromJson({
    required Map<String,dynamic>json}){
    return ResendOtpErrorResponse(
      message : json['message'] ?? json['quantity'],
    );
  }



}