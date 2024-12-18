part of 'order_cubit.dart';

sealed class OrderState {}

final class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}
class OrderSuccess extends OrderState {
  final GetOrderResponseModel order;
  OrderSuccess({required this.order});
}

class OrderError extends OrderState {
  final String message;
  OrderError({required this.message});
}

class CancelOrder extends OrderState {
  final String message;
  CancelOrder({required this.message});
}
class OrderLoadingCancel extends OrderState {}
class ReOrder extends OrderState {}
