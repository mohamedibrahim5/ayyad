

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnelbarh/model/requests/add_cart_item_request.dart';
import 'package:ibnelbarh/model/requests/check_out_request.dart';
import 'package:ibnelbarh/model/requests/patch_cart_item_request.dart';
import 'package:ibnelbarh/model/responses/add_coupon_response.dart';
import 'package:ibnelbarh/model/responses/add_delete_cart_item_response.dart';
import 'package:ibnelbarh/model/responses/get_cart_model.dart';
import 'package:ibnelbarh/model/responses/get_extra_response.dart';
import 'package:ibnelbarh/model/responses/get_question_response.dart';
import 'package:ibnelbarh/model/responses/reset_pass_response.dart';
import 'package:ibnelbarh/repository/repository.dart';

import '../../../model/responses/get_all_branches_model_response.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Repository repository;
  CartCubit({required this.repository}) : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  List<bool> isAddedToCart = [];
  GetCartModel? getCartModel;
  List<int> itemsTotalId = [] ;
  List<int> itemsTotalIdUpdateCart = [] ;
  late double totalPrice ;
  late double totalPriceCart ;
  List<bool> allIndexOfChooseItem = [] ;
  List<Questions> requiredQuestions = [] ;
  List<Questions> requiredQuestionsUpdateCart = [] ;
  List<GetAllBranchesModelResponse> allBranches = [] ;







  chooseItemCheck(List<Extras> extras,int index,Questions question) {
    requiredQuestions.removeWhere((element) => element.title == question.title);
    for (int i = 0; i < extras.length; i++) {
      if(extras[i].isSelectedCHECK == true){
        totalPrice = totalPrice - double.parse(extras[i].price!);
      }
      extras[i].isSelectedCHECK = false;
    }
    totalPrice = totalPrice + double.parse(extras[index].price!);
    extras[index].isSelectedCHECK = true;
    emit(CartChange());
  }

  chooseItemOptional(List<Extras> extras,int index,Questions question) {

    bool isRequired = false;
    extras[index].isSelectedOPTIONAL = extras[index].isSelectedOPTIONAL == true ? false : true;
    totalPrice = extras[index].isSelectedOPTIONAL == true ? totalPrice + double.parse(extras[index].price!) : totalPrice - double.parse(extras[index].price!);
    if(question.isRequired == true && extras[index].isSelectedOPTIONAL == true){
      for (var element in question.extras!) {
        if(element.isSelectedOPTIONAL == true){
          requiredQuestions.removeWhere((element) => element.title == question.title);
        }
      }
    }else if (question.isRequired == true && extras[index].isSelectedOPTIONAL == false){
      for (var element in question.extras!) {
        if(element.isSelectedOPTIONAL == true){
         isRequired = true;
        }
      }
      if(isRequired == false){
        requiredQuestions.add(question);
      }

    }
    emit(CartChange());
  }



  chooseItemCheck2(List<Extras> extras,int index) {
    for (int i = 0; i < extras.length; i++) {
      if(extras[i].isSelectedCHECK == true){
        totalPriceCart = totalPriceCart - double.parse(extras[i].price!);
      }
      extras[i].isSelectedCHECK = false;
    }
    totalPriceCart = totalPriceCart + double.parse(extras[index].price!);
    extras[index].isSelectedCHECK = true;
    emit(CartChange());
  }

  chooseItemOptional2(List<Extras> extras,int index,Questions question) {

    bool isRequired = false;
    extras[index].isSelectedOPTIONAL = extras[index].isSelectedOPTIONAL == true ? false : true;
    totalPriceCart = extras[index].isSelectedOPTIONAL == true ? totalPriceCart + double.parse(extras[index].price!) : totalPriceCart - double.parse(extras[index].price!);
    if(question.isRequired == true && extras[index].isSelectedOPTIONAL == true){
      for (var element in question.extras!) {
        if(element.isSelectedOPTIONAL == true){
          requiredQuestionsUpdateCart.removeWhere((element) => element.title == question.title);
        }
      }
    }else if (question.isRequired == true && extras[index].isSelectedOPTIONAL == false){
      for (var element in question.extras!) {
        if(element.isSelectedOPTIONAL == true){
          isRequired = true;
        }
      }
      if(isRequired == false){
        requiredQuestionsUpdateCart.add(question);
      }

    }
    emit(CartChange());
  }


  // chooseItemOptional2(List<Extras> extras,int index) {
  //   extras[index].isSelectedOPTIONAL = extras[index].isSelectedOPTIONAL == true ? false : true;
  //   totalPriceCart = extras[index].isSelectedOPTIONAL == true ? totalPriceCart + double.parse(extras[index].price!) : totalPriceCart - double.parse(extras[index].price!);
  //   emit(CartChange());
  // }

  void addItemToCart({required AddCartItemRequest addCartItemRequest })async{
    emit(AddItemLoadingState(id: addCartItemRequest.productId));
    final getHomeSuccessFailure = await repository.addCartItem(addCartItemRequest: addCartItemRequest);
    getHomeSuccessFailure.fold(
            (success) {
              // if(sl<PrefsHelper>().getToken2().isEmpty){
              //   sl<PrefsHelper>().setSession2(success.sessionKey ?? '');
              // }else {
              //   sl<PrefsHelper>().setSession2('');
              // }
          emit(AddItemSuccess(addDeleteCartItemResponse: success,id: addCartItemRequest.productId));
        },
            (failure) {
              emit(AddItemErrorState(message: failure.message));
            }
    );
  }

  getCart()async{
    emit(AddItemLoadingState());
    final getHomeSuccessFailure = await repository.getCart();
    getHomeSuccessFailure.fold(
            (success) {
              getCartModel = success;
              totalPrice = double.parse(getCartModel?.totalPrice ?? '0') ;
          emit(GetCartSuccess(getCartModel: success));
        },
            (failure) => emit(AddItemErrorState(message: failure.message))
    );
  }





  changeItemCart(int index){
    if(isAddedToCart[index]){
      isAddedToCart[index] = false;
    }else {
      isAddedToCart[index] = true;
    }
    // isAddedToCart[index] = !isAddedToCart[index];
    emit(CartChange());
  }

  deleteCartItem({required int cartId })async{
    emit(DeleteItemLoadingState());
    final getHomeSuccessFailure = await repository.deleteCart(cartId: cartId);
    getHomeSuccessFailure.fold(
            (success) {
          emit(DeleteItemSuccess(addDeleteCartItemResponse: success,));
        },
            (failure) => emit(AddItemErrorState(message: failure.message))
    );
  }

  changeState(){
    emit(CartInitial());
  }


  patchCartItem({required PatchCartItemRequest addCartItemRequest })async{
    emit(AddItemLoadingState(id: addCartItemRequest.productId));
    final getHomeSuccessFailure = await repository.patchCartItem(addCartItemRequest: addCartItemRequest);
    getHomeSuccessFailure.fold(
            (success) {
          emit(PatchItemSuccess(item: success,id: addCartItemRequest.productId));
        },
            (failure) => emit(AddItemErrorState(message: failure.message))
    );
  }


  checkOut({required CheckOutRequest checkOutRequest}) async {
    emit(CheckOutLoadingState());
    final cheekOut = await  repository.checkOut(checkOutRequest: checkOutRequest);
    cheekOut.fold(
            (success) {
          emit(CheckOutSuccess(addCheckOutSuccess: success));
        }, (failure) => emit(CheckOutErrorState(message: failure.message??''))
    );
  }

  addCoupon({required String coupon}) async {
    emit(AddCoupanLoadingState());
    final cheekOut = await  repository.addCoupon(coupon: coupon);
    cheekOut.fold(
            (success) {
          emit(AddCouponSuccess(addCouponResponse: success));
        }, (failure) {

          emit(AddCoupanErrorState(message: failure.message?? failure.code ?? ''));
        }
    );
  }

  removeCoupon() async {
    emit(RemoveCouponSuccess());
  }

  getBranches()async{
    emit(GetBranchesLoadingState());
    final getHomeSuccessFailure = await repository.getAllBranchesModelResponse();
    getHomeSuccessFailure.fold(
            (success) {
              allBranches.clear();
              allBranches.addAll(success);
          emit(GetBranchesSuccess(getAllBranchesModelResponse: success));
        },
            (failure) => emit(GetBranchesErrorState(message: failure.message))
    );
  }

}
