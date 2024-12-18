part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}
final class CartChange extends CartState {}
final class AddItemLoadingState extends CartState {
  int? id;
  AddItemLoadingState({this.id});
}

final class AddItemSuccess extends CartState {
  int? id;
  final AddDeleteCartItemResponse addDeleteCartItemResponse;

  AddItemSuccess({required this.addDeleteCartItemResponse,this.id});
}


class AddItemErrorState extends CartState {
  final String message;
  AddItemErrorState({required this.message});
}

class GetCartSuccess extends CartState {
  final GetCartModel getCartModel;

  GetCartSuccess({required this.getCartModel});
}
class DeleteItemLoadingState extends CartState {}
class DeleteItemSuccess extends CartState {
  final GetCartModel addDeleteCartItemResponse;
  DeleteItemSuccess({required this.addDeleteCartItemResponse});
}


final class PatchItemSuccess extends CartState {
  int? id;
  final GetCartModel item;

  PatchItemSuccess({required this.item,this.id});
}

class CheckOutLoadingState extends CartState {}
class CheckOutSuccess extends CartState {
  final ChangePasswordSuccessResponse addCheckOutSuccess;
  CheckOutSuccess({required this.addCheckOutSuccess});
}


class CheckOutErrorState extends CartState {
  final String message;
  CheckOutErrorState({required this.message});
}

class AddCoupanLoadingState extends CartState {}

class AddCoupanErrorState extends CartState {
  final String message;
  AddCoupanErrorState({required this.message});
}
class AddCouponSuccess extends CartState {
  final AddCouponResponse addCouponResponse;
  AddCouponSuccess({required this.addCouponResponse});
}

class GetBranchesLoadingState extends CartState {}
class GetBranchesErrorState extends CartState {
  final String message;
  GetBranchesErrorState({required this.message});
}
class GetBranchesSuccess extends CartState {
  final List<GetAllBranchesModelResponse> getAllBranchesModelResponse;
  GetBranchesSuccess({required this.getAllBranchesModelResponse});
}
class RemoveCouponSuccess extends CartState {}