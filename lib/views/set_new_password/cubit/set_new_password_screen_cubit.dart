import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/requests/reset_pass_request.dart';
import '../../../model/responses/reset_pass_response.dart';
import '../../../repository/repository.dart';

part 'set_new_password_screen_state.dart';

class SetNewPasswordCubit extends Cubit<SetNewPasswordState> {
  final Repository repository;
  SetNewPasswordCubit({required this.repository}) : super(SetNewPasswordInitial());
  static SetNewPasswordCubit get(context) => BlocProvider.of(context);

  void resetPassword
      ({required ResetPasswordRequest resetPasswordRequest,required String token})async{

    emit(ResetPasswordLoadingState());
    final resetPasswordFailure = await repository.resetPassword
      (resetPasswordRequest: resetPasswordRequest,token: token);
    resetPasswordFailure.fold(
            (success) => emit(
            ResetPasswordSuccessState(resetPasswordSuccessResponse: success )),
            (failure) => emit(ResetPasswordErrorState(message: failure.message ?? ''))
    );




  }

}
