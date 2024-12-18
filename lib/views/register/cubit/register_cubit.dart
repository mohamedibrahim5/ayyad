import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/requests/register_request.dart';
import '../../../model/responses/register_response.dart';
import '../../../repository/repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final Repository repository;
  RegisterCubit({required this.repository}) : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  register({
    required UserRegisterRequest userRegisterRequest,
  }) async {
    emit(RegisterLoadingState());

    final registerModel = await repository.registerClient(clientRegisterRequest: userRegisterRequest);

    registerModel.fold((success) async {
      emit(RegisterSuccessState(userRegisterSuccessResponse: success));
    }, (failure) => emit(RegisterErrorState(userRegisterErrorResponse: failure)));
  }

}
