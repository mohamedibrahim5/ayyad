part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgotPassLoadingState extends ForgetPasswordState{}

class ForgotPassSuccessState extends ForgetPasswordState{
  final ForgotPassSuccessResponse forgotPassSuccessResponse;
  ForgotPassSuccessState({required this.forgotPassSuccessResponse});
}

class ForgotPassErrorState extends ForgetPasswordState{

  final String message ;
  ForgotPassErrorState({required this.message});


}