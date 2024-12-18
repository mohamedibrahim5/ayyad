import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/requests/login_request.dart';
import '../../../model/responses/login_response.dart';
import '../../../repository/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository repository;
  LoginCubit({required this.repository}) : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

   login({
    required LoginRequest loginRequest,
  }) async {
    emit(LoginLoadingState());

    final loginModel = await repository.login(loginRequest: loginRequest);

    loginModel.fold((success) async {
        emit(LoginSuccessState(loginSuccessResponse: success));
    }, (failure) => emit(LoginErrorState(loginErrorResponse: failure)));
  }


}
