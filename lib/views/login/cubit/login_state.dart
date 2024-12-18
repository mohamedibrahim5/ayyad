part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginErrorState extends LoginState{
  final LoginErrorResponse loginErrorResponse;
  LoginErrorState({required this.loginErrorResponse});
}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState {

  final LoginSuccessResponse loginSuccessResponse;

  LoginSuccessState({required this.loginSuccessResponse});
}


