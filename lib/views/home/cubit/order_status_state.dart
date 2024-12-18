part of 'order_status_cubit.dart';

@immutable
sealed class OrderStatusState {}

final class OrderStatusInitial extends OrderStatusState {}
class OrderStatusUpdated extends OrderStatusState {}
class TrackErrorState extends OrderStatusState {
  final String message;
  TrackErrorState({required this.message});
}
class OrderStatusUpdatedDeliverd extends OrderStatusState {}
