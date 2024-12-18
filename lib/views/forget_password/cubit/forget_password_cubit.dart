import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/requests/forgot_pass_request.dart';
import '../../../model/responses/forgot_pass_response.dart';
import '../../../repository/repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final Repository repository;
  ForgetPasswordCubit({required this.repository}) : super(ForgetPasswordInitial());
  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  void forgotPassword(
      {required ForgotPassRequest forgotPassRequest})async{
    emit(ForgotPassLoadingState());
    final forgotPassFailure = await repository.forgotPassword(
        forgotPassRequest: forgotPassRequest);
    forgotPassFailure.fold(
            (success) => emit(
            ForgotPassSuccessState(forgotPassSuccessResponse: success)),
            (failure) => emit(ForgotPassErrorState(message: failure.phone??''))
    );



  }
}
