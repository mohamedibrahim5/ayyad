part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}


class RegisterErrorState extends RegisterState{
  final UserRegisterErrorResponse userRegisterErrorResponse;
  RegisterErrorState({required this.userRegisterErrorResponse});
}

class RegisterLoadingState extends RegisterState{}

class RegisterSuccessState extends RegisterState {

  final UserRegisterSuccessResponse userRegisterSuccessResponse;

  RegisterSuccessState({required this.userRegisterSuccessResponse});
}
