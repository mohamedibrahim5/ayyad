part of 'set_new_password_screen_cubit.dart';

abstract class SetNewPasswordState {}

class SetNewPasswordInitial extends SetNewPasswordState {}

class ResetPasswordLoadingState extends SetNewPasswordState{}


class ResetPasswordSuccessState extends SetNewPasswordState{
  final ResetPasswordSuccessResponse resetPasswordSuccessResponse;

  ResetPasswordSuccessState({required this.resetPasswordSuccessResponse});


}
class ResetPasswordErrorState extends SetNewPasswordState{
  final String message ;

  ResetPasswordErrorState({required this.message});


}
