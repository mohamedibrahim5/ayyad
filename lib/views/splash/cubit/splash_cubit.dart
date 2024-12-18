import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnelbarh/views/home/cubit/home_cubit.dart';

import '../../../repository/repository.dart';
import '../../../shared/resources/service_locator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Repository repository;
  SplashCubit({required this.repository}) : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  getOrganization({required String domain})async{
    emit(OrganizationLoadingState());
    final getHomeSuccessFailure = await repository.getOrganization(domain: domain);
    getHomeSuccessFailure.fold(
            (success) {
              sl<HomeCubit>().addSession();
          emit(OrganizationSuccess());
        },
            (failure) => emit(OrganizationErrorState())
    );
  }
}
