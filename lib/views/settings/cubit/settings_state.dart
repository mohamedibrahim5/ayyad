part of 'settings_cubit.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

 class SettingsChangePassword extends SettingsState {}
 class SettingsErrorChangePassword extends SettingsState {
  SettingsErrorChangePassword({required this.message});
  final String message;
}
 class ChangePasswordSuccess extends SettingsState {
   ChangePasswordSuccess({required this.changePasswordSuccess});
   final ChangePasswordSuccessResponse changePasswordSuccess;
}

class SettingsDeleteAccount extends SettingsState {}
class DeleteAccountSuccess extends SettingsState {
  DeleteAccountSuccess({required this.message});
  final String message;
}
class AddNewAddressSuccess extends SettingsState {}
class UpdateAddressSuccess extends SettingsState {}
class DeleteAddressSuccess extends SettingsState {}
class SettingsLoadingGetAllAddress extends SettingsState {}
class GetAllAddressSuccess extends SettingsState {
  GetAllAddressSuccess({required this.getAllAddressModelResponse});
  final List<CreateAddressModelResponse> getAllAddressModelResponse;
}
class SettingsErrorGetAllAddress extends SettingsState {
  SettingsErrorGetAllAddress({required this.message});
  final String message;
}
class SettingsLoadingAddAddress extends SettingsState {}
class SettingsErrorGetAddAddress extends SettingsState {
  SettingsErrorGetAddAddress({required this.message});
  final String message;
}
class AddAddressSuccess extends SettingsState {
  AddAddressSuccess({required this.createAddressModelResponse});
  final CreateAddressModelResponse createAddressModelResponse;
}
class SettingsLoadingPatchAddress extends SettingsState {}
class PatchAddressSuccess extends SettingsState {
  PatchAddressSuccess({required this.createAddressModelResponse});
  final CreateAddressModelResponse createAddressModelResponse;
}
class SettingsErrorPatchAddAddress extends SettingsState {
  SettingsErrorPatchAddAddress({required this.message});
  final String message;
}
class DeleteAddressLoadingState extends SettingsState {}

class DeleteAddressErrorState extends SettingsState {
  DeleteAddressErrorState({required this.message});
  final String message;
}
class DeleteAddressSuccessState extends SettingsState {
  DeleteAddressSuccessState({required this.message});
  final String message;
}