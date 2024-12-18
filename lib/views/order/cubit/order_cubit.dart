import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/responses/get_order_response.dart';
import '../../../repository/repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {

  final Repository repository;
  OrderCubit({required this.repository}) : super(OrderInitial());
  static OrderCubit get(context) => BlocProvider.of(context);
  List<GetOrderResponse> order = [];

  getOrder({required String orderStatus}) async {
    emit(OrderLoading());
    final response = await repository.getOrder(orderStatus: orderStatus);
    response.fold((success) {
      order.clear ;
      order = success.createAddressModelResponse!;
      emit(OrderSuccess(order: success));
    }, (error) {
      emit(OrderError(message: error.message ?? ''));
    });
  }

  cancelOrder({required int orderId}) async {
    emit(OrderLoadingCancel());
    final response = await repository.cancelOrder(orderId: orderId);
    response.fold((success) {
      emit(CancelOrder(
        message: success.message ?? '',
      ));
    }, (error) {
      emit(OrderError(message: error.message ?? ''));
    });
  }
  reOrder({required int orderId}) async {
    emit(OrderLoadingCancel());
    final response = await repository.reOrder(orderId: orderId);
    response.fold((success) {
      emit(ReOrder());
    }, (error) {
      emit(OrderError(message: error.message ?? ''));
    });
  }
}
