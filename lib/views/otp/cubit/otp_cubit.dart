import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/requests/otp_verfiy_request.dart';
import '../../../model/requests/resend_otp_request.dart';
import '../../../model/responses/otp_verify_response.dart';
import '../../../model/responses/resend_otp_response.dart';
import '../../../repository/repository.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final Repository repository;
  OtpCubit({required this.repository}) : super(OtpInitial());
  static OtpCubit get(context) => BlocProvider.of(context);

  userOtp({required UserOtpVerifyRequest userOtpVerifyRequest}) async {
    emit(OtpLoadingState());
    final clientOtpFailure = await repository.userOtp(
        userOtpVerifyRequest: userOtpVerifyRequest);

    clientOtpFailure.fold(
            (success) {
         //  sl<PrefsHelper>().setToken(success.token??'');
          emit(
              OtpSuccessState(clientOtpVerifySuccessResponse: success));
        },
            (failure) => emit(OtpErrorState(message: failure.message ?? '')));
  }

  void resendOtp({required ResendOtpRequest resendOtpRequest}) async {
    emit(ResendOtpLoadingState());
    final resendOtpFailure =
    await repository.resendOtp(resendOtpRequest: resendOtpRequest);
    resendOtpFailure.fold(
            (success) =>
            emit(ResendOtpSuccessState(resendOtpSuccessResponse: success)),
            (failure) => emit(ResendOtpErrorState(message: failure.message)));
  }


}
