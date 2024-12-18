part of 'otp_cubit.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}
class OtpTime extends OtpState {}

class OtpLoadingState extends OtpState{}

class OtpSuccessState extends OtpState{
  final UserOtpVerifySuccessResponse clientOtpVerifySuccessResponse;
  OtpSuccessState({required this.clientOtpVerifySuccessResponse});

}

class OtpErrorState extends OtpState{
  final String message;
  OtpErrorState({required this.message});
}

class ResendOtpLoadingState extends OtpState{

  ResendOtpLoadingState();
}

class ResendOtpSuccessState extends OtpState{
  final ResendOtpSuccessResponse resendOtpSuccessResponse;
  ResendOtpSuccessState({required this.resendOtpSuccessResponse});
}

class ResendOtpErrorState extends OtpState{
  final String message;
  ResendOtpErrorState({required this.message});
}