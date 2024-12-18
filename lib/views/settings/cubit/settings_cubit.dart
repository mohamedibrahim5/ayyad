import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnelbarh/model/requests/add_my_address_request.dart';
import 'package:ibnelbarh/shared/resources/constant.dart';

import '../../../model/requests/create_address_request.dart';
import '../../../model/requests/reset_pass_request.dart';
import '../../../model/responses/create_address_model_respose.dart';
import '../../../model/responses/reset_pass_response.dart';
import '../../../repository/repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final Repository repository;
  SettingsCubit({required this.repository}) : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  List<CreateAddressModelResponse>? getAllAddressModelResponse;

  CreateAddressModelResponse? homeAddressModelResponse;


  void changePassword
      ({required ChangePasswordRequest resetPasswordRequest})async{

    emit(SettingsChangePassword());
    final resetPasswordFailure = await repository.changePassword
      (resetPasswordRequest: resetPasswordRequest);
    resetPasswordFailure.fold(
            (success) => emit(
                ChangePasswordSuccess(changePasswordSuccess: success )),
            (failure) => emit(SettingsErrorChangePassword(message: failure.message ?? ''))
    );
  }

  deleteAccount() async {
    emit(SettingsDeleteAccount());
    final resetPasswordFailure = await repository.deleteAccount();
    resetPasswordFailure.fold(
            (success) => emit(
                DeleteAccountSuccess(message: success.message ?? '' )),
            (failure) => emit(SettingsErrorChangePassword(message: failure.message))
    );

  }

  void onAddTask({required AddNewAddressRequest addNewAddressRequest}) {
    Constants.addNewAddressRequestBox.add(addNewAddressRequest);
    emit(AddNewAddressSuccess());
  }

  void onUpdateTask({required int index,required AddNewAddressRequest addNewAddressRequest}) {
    Constants.addNewAddressRequestBox.putAt(index, addNewAddressRequest);
     emit(UpdateAddressSuccess());
  }

  void deleteTask({required int index}) {
    Constants.addNewAddressRequestBox.deleteAt(index);
    emit(DeleteAddressSuccess());
  }

  getAllAddress({bool? isMain})async{
    emit(SettingsLoadingGetAllAddress());
    final getAllAddressFailure = await repository.getAllAddress(
      isMain: isMain
    );
    getAllAddressFailure.fold(
            (success) {
              getAllAddressModelResponse = success;
              emit(
                GetAllAddressSuccess(getAllAddressModelResponse: success ));
            },
            (failure) => emit(SettingsErrorGetAllAddress(message: failure.message ))
    );
  }



  getAllAddressHome()async{
    emit(SettingsLoadingGetAllAddress());
    final getAllAddressFailure = await repository.getAllHomeAddress();
    getAllAddressFailure.fold(
            (success) {

              for (var element in success) {
                if(element.isMain == true){
                  homeAddressModelResponse = element;
                }
              }
              getAllAddressModelResponse = success;

          emit(
              GetAllAddressSuccess(getAllAddressModelResponse: success ));
        },
            (failure) => emit(SettingsErrorGetAllAddress(message: failure.message ))
    );
  }


  addAddress({required CreateAddressRequest createAddressRequest})async{
    emit(SettingsLoadingAddAddress());
    final getAllAddressFailure = await repository.createAddressModelResponse(createAddressRequest: createAddressRequest);
    getAllAddressFailure.fold(
            (success) {
              emit(
                AddAddressSuccess(createAddressModelResponse: success ));
            },
            (failure) => emit(SettingsErrorGetAddAddress(message: failure.message ))
    );
  }

  patchAddress({required CreateAddressRequest createAddressRequest,required int id})async{
    emit(SettingsLoadingPatchAddress());
    final patchAddressFailure = await repository.patchAddressModelResponse(createAddressRequest: createAddressRequest,id: id);
    patchAddressFailure.fold(
            (success) {
              homeAddressModelResponse = success;
          emit(
              PatchAddressSuccess(createAddressModelResponse: success ));
        },
            (failure) => emit(SettingsErrorPatchAddAddress(message: failure.message ))
    );
  }

  deleteAddress({required int addressId })async{
    emit(DeleteAddressLoadingState());
    final getHomeSuccessFailure = await repository.deleteAddress(
      addressId: addressId
    );
    getHomeSuccessFailure.fold(
            (success) {
          emit(DeleteAddressSuccessState(message: success,));
        },
            (failure) => emit(DeleteAddressErrorState(message: failure.message))
    );
  }


}
