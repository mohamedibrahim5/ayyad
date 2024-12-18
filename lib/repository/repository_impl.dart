import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibnelbarh/data/remote/remote_datasource.dart';
import 'package:ibnelbarh/model/requests/add_cart_item_request.dart';
import 'package:ibnelbarh/model/requests/check_out_request.dart';
import 'package:ibnelbarh/model/requests/create_address_request.dart';
import 'package:ibnelbarh/model/requests/forgot_pass_request.dart';
import 'package:ibnelbarh/model/requests/get_product_request.dart';
import 'package:ibnelbarh/model/requests/login_request.dart';
import 'package:ibnelbarh/model/requests/otp_verfiy_request.dart';
import 'package:ibnelbarh/model/requests/patch_cart_item_request.dart';
import 'package:ibnelbarh/model/requests/register_request.dart';
import 'package:ibnelbarh/model/requests/resend_otp_request.dart';
import 'package:ibnelbarh/model/requests/reset_pass_request.dart';
import 'package:ibnelbarh/model/responses/add_coupon_response.dart';
import 'package:ibnelbarh/model/responses/add_delete_cart_item_response.dart';
import 'package:ibnelbarh/model/responses/add_session_model_response.dart';
import 'package:ibnelbarh/model/responses/create_address_model_respose.dart';
import 'package:ibnelbarh/model/responses/forgot_pass_response.dart';
import 'package:ibnelbarh/model/responses/get_all_branches_model_response.dart';
import 'package:ibnelbarh/model/responses/get_cart_model.dart';
import 'package:ibnelbarh/model/responses/get_home_response.dart';
import 'package:ibnelbarh/model/responses/get_order_response.dart';
import 'package:ibnelbarh/model/responses/get_product_model_response.dart';
import 'package:ibnelbarh/model/responses/get_profile_response.dart';
import 'package:ibnelbarh/model/responses/google_map_search_model.dart';
import 'package:ibnelbarh/model/responses/login_response.dart';
import 'package:ibnelbarh/model/responses/organization_response.dart';
import 'package:ibnelbarh/model/responses/otp_verify_response.dart';
import 'package:ibnelbarh/model/responses/register_response.dart';
import 'package:ibnelbarh/model/responses/resend_otp_response.dart';
import 'package:ibnelbarh/model/responses/reset_pass_response.dart';
import 'package:ibnelbarh/model/responses/track_order_model_response.dart';
import 'package:ibnelbarh/repository/repository.dart';
import 'package:ibnelbarh/shared/resources/error_handler.dart';
import 'package:ibnelbarh/shared/resources/network_info.dart';
import 'package:ibnelbarh/shared/resources/print_func.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import '../shared/resources/navigation_service.dart';
import '../shared/resources/routes_manager.dart';
import '../shared/resources/service_locator.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({required this.remoteDataSource, required this.networkInfo});




  Future<bool> handleCheckInternet() async {
    if(!await networkInfo.isConnected){
      sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.noInternetScreen);
    }
    return await networkInfo.isConnected;
  }

  @override
  Future<Either<LoginSuccessResponse, LoginErrorResponse>> login({required LoginRequest loginRequest}) async {

     
     if (await handleCheckInternet()) {
      try {
        final login = await remoteDataSource.login(loginRequest: loginRequest);

        return Left(login);
      } on LoginErrorResponse catch (error) {
        printFunc(printName:
            '-------------- on LoginErrorResponse error: $error --------------');
        return Right(error);
      } catch (error) {
        printFunc(printName:'-------------- login error: $error --------------');
        return Right(
            LoginErrorResponse(message: ErrorHandler.handle(error).failure));
      }
    } else {
      // no internet connection error
      return Right(
          LoginErrorResponse(message: StringsManager.notFoundError.tr()));
    }

  }

  @override
  Future<Either<UserRegisterSuccessResponse, UserRegisterErrorResponse>> registerClient({required UserRegisterRequest clientRegisterRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final register = await remoteDataSource.register(
            registerRequest: clientRegisterRequest);
        return Left(register);
      } on UserRegisterErrorResponse catch (error) {
        printFunc(printName: '-------------- on UserRegisterErrorResponse error: $error --------------');
        return Right(error);
      } catch (error) {
        printFunc(printName: '-------------- registerClient error: $error --------------');
        return Right(UserRegisterErrorResponse(
            user: ErrorHandler.handle(error).failure
        ));
      }
    } else {
      // no internet connection error
      return Right(UserRegisterErrorResponse(
          user: StringsManager.notFoundError.tr()));
    }

  }

  @override
  Future<Either<LoginSuccessResponse, LoginErrorResponse>> getUserProfile() async {
    if (await handleCheckInternet()) {
      try {
        final login = await remoteDataSource.getUserProfile();

        return Left(login);
      } on LoginErrorResponse catch (error) {
        printFunc(printName:
        '-------------- on LoginErrorResponse error: $error --------------');
        return Right(error);
      } catch (error) {
        printFunc(printName:'-------------- getProfile error: $error --------------');
        return Right(
            LoginErrorResponse(message: ErrorHandler.handle(error).failure));
      }
    } else {
      // no internet connection error
      return Right(
          LoginErrorResponse(message: StringsManager.notFoundError.tr()));
          }

}

  @override
  Future<Either<UserOtpVerifySuccessResponse, UserOtpVerifyErrorResponse>>
  userOtp(
      {required UserOtpVerifyRequest userOtpVerifyRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final clientOtp = await remoteDataSource.userOtp(
            userOtpVerifyRequest: userOtpVerifyRequest);
        return left(clientOtp);
      } on UserOtpVerifyErrorResponse catch (error) {
        printFunc(printName:
            '-------------- on OtpErrorResponse error: $error --------------');
        return Right(error);
      } catch (error) {
        printFunc(printName: '-------------- userOtp error: $error --------------');
        return Right(UserOtpVerifyErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(UserOtpVerifyErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }


  @override
  Future<Either<ForgotPassSuccessResponse, ForgotPassErrorResponse>>
  forgotPassword({required ForgotPassRequest forgotPassRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final forgotPass = await remoteDataSource.forgotPassword(
            forgotPassRequest: forgotPassRequest);
        return left(forgotPass);
      } on ForgotPassErrorResponse catch (error) {
        debugPrint(
            '-------------- on Forgot Password Response error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint(
            '-------------- forgotPassword error: $error --------------');
        return Right(ForgotPassErrorResponse(
            phone: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ForgotPassErrorResponse(phone: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<ResetPasswordSuccessResponse, ResetPasswordErrorResponse>>
  resetPassword(
      {required ResetPasswordRequest resetPasswordRequest,required String token}) async {
     
     if (await handleCheckInternet()) {
      try {
        final resetPassPassword = await remoteDataSource.resetPassword(
            resetPasswordRequest: resetPasswordRequest,token: token);
        return left(resetPassPassword);
      } on ResetPasswordErrorResponse catch (error) {
        debugPrint(
            '-------------- on ResetPassword error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- ResetPassword error: $error --------------');
        return Right(ResetPasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(ResetPasswordErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }


  @override
  Future<Either<ResendOtpSuccessResponse, ResendOtpErrorResponse>> resendOtp(
      {required ResendOtpRequest resendOtpRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final resendOtp = await remoteDataSource.resendOtp(
            resendOtpRequest: resendOtpRequest);
        return left(resendOtp);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on ResendOtp error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- ResendOtp error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<HomeModel, ResendOtpErrorResponse>> getHomeData() async {
     
     if (await handleCheckInternet()) {
      try {
        final getHomeData = await remoteDataSource.getHomeData();
        return left(getHomeData);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on GetHomeData error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- GetHomeData error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<List<CartItemModel>, ResendOtpErrorResponse>> getHomeDataCategory({required String categoryTitle,required String search}) async {
     
     if (await handleCheckInternet()) {
      try {
        final getFilterHomeData = await remoteDataSource.getHomeDataCategory(categoryTitle: categoryTitle,search: search);
        return left(getFilterHomeData);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on GetFilterHomeData error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- GetFilterHomeData error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<AddDeleteCartItemResponse, ResendOtpErrorResponse>> addCartItem({required AddCartItemRequest addCartItemRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final addItemToCart = await remoteDataSource.addCartItem(addCartItemRequest: addCartItemRequest);
        return left(addItemToCart);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on addItemToCart12 error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- addItemToCart error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GetProfileResponse, ResendOtpErrorResponse>> getProfile() async {
     
     if (await handleCheckInternet()) {
      try {
        final getProfile = await remoteDataSource.getProfile();
        return left(getProfile);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on getProfile error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- getProfile error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GetCartModel, ResendOtpErrorResponse>> getCart() async {
    //  
    if(await handleCheckInternet()){
      try {
        final getCart = await remoteDataSource.getCart();
        return left(getCart);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on getCart error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- getCart error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GetCartModel, ResendOtpErrorResponse>> deleteCart({required int cartId}) async {
     
     if (await handleCheckInternet()) {
      try {
        final deleteCartItem = await remoteDataSource.deleteCart(cartId: cartId);
        return left(deleteCartItem);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on deleteCartItem error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- deleteCartItem error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }


  @override
  Future<Either<GetCartModel, ResendOtpErrorResponse>> patchCartItem({required PatchCartItemRequest addCartItemRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final patchItemToCart = await remoteDataSource.patchCartItem(addCartItemRequest: addCartItemRequest);
        return left(patchItemToCart);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on patchItemToCart error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- patchItemToCart error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<ChangePasswordSuccessResponse, ResetPasswordErrorResponse>> changePassword({required ChangePasswordRequest resetPasswordRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final changePassword = await remoteDataSource.changePassword(
            resetPasswordRequest: resetPasswordRequest);
        if(changePassword.oldPassword != null){
          return Right(ResetPasswordErrorResponse(
            message: changePassword.oldPassword ?? StringsManager.notFoundError.tr()
          ));
        }
        return left(changePassword);
      } on ResetPasswordErrorResponse catch (error) {
        debugPrint(
            '-------------- on changePassword error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- changePassword error: ${error.toString()} --------------');
        return Right(ResetPasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(ResetPasswordErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<ChangePasswordSuccessResponse, ChangePasswordErrorResponse>> checkOut({required CheckOutRequest checkOutRequest}) async {
     
     if (await handleCheckInternet()) {
      try {
        final checkOut = await remoteDataSource.checkOut(
            checkOutRequest: checkOutRequest);
        // if(checkOut.url == null){
        //   return Right(ChangePasswordErrorResponse(
        //       message: checkOut.message ?? StringsManager.notFoundError.tr()
        //   ));
        // }
        return left(checkOut);
      } on ResetPasswordErrorResponse catch (error) {
        debugPrint(
            '-------------- on checkOut error: $error --------------');
        return Right(ChangePasswordErrorResponse(
            message: error.message ?? StringsManager.notFoundError.tr()));
      } catch (error) {
        debugPrint('-------------- checkOut error: ${error.toString()} --------------');
        return Right(ChangePasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(ChangePasswordErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<AddCouponResponse, ResetPasswordErrorResponse>> addCoupon({required String coupon}) async {
     
     if (await handleCheckInternet()) {
      try {
        final addCoupon = await remoteDataSource.addCoupon(
            coupon: coupon);
        if(addCoupon.discount != null){
          return left(addCoupon);
        }
        if(addCoupon.code != null){
          return Right(ResetPasswordErrorResponse(
              message: addCoupon.coupon ??  addCoupon.code ??  StringsManager.notFoundError.tr()
          ));
        }
        return left(addCoupon);
      } on ResetPasswordErrorResponse catch (error) {
        debugPrint(
            '-------------- on addCoupon error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- addCoupon error: ${error.toString()} --------------');
        return Right(ResetPasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(ResetPasswordErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GetOrderResponseModel, ResetPasswordErrorResponse>> getOrder({required String orderStatus}) async {
     
     if (await handleCheckInternet()) {
      try {
        final getOrder = await remoteDataSource.getOrder(orderStatus: orderStatus);
        return left(getOrder);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on getOrder error: $error --------------');
        return Right(ResetPasswordErrorResponse(
            message: error.message));
      } catch (error) {
        debugPrint('-------------- getOrder error: $error --------------');
        return Right(ResetPasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResetPasswordErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<ChangePasswordSuccessResponse, ResetPasswordErrorResponse>> cancelOrder({required int orderId}) async {
     
     if (await handleCheckInternet()) {
      try {
        final cancelOrder = await remoteDataSource.cancelOrder(
            orderId: orderId);

        return left(cancelOrder);
      } on ResetPasswordErrorResponse catch (error) {
        debugPrint(
            '-------------- on cancelOrder error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- cancelOrder error: ${error.toString()} --------------');
        return Right(ResetPasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(ResetPasswordErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<ChangePasswordSuccessResponse, ResetPasswordErrorResponse>> reOrder({required int orderId}) async {
     
     if (await handleCheckInternet()) {
      try {
        final reOrder = await remoteDataSource.reOrder(
            orderId: orderId);

        return left(reOrder);
      } on ResetPasswordErrorResponse catch (error) {
        debugPrint(
            '-------------- on reOrder error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- reOrder error: ${error.toString()} --------------');
        return Right(ResetPasswordErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(ResetPasswordErrorResponse(
          message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GetProfileResponse, ResendOtpErrorResponse>> patchProfile({required String fullName,required String email}) async {
     
     if (await handleCheckInternet()) {
      try {
        final getProfile = await remoteDataSource.patchProfile(fullName: fullName, email: email);
        return left(getProfile);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on getProfile error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- getProfile error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<ChangePasswordSuccessResponse, ResendOtpErrorResponse>> deleteAccount() async{
     
     if (await handleCheckInternet()) {
      try {
        final deleteAccount = await remoteDataSource.deleteAccount();
        return left(deleteAccount);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on deleteAccount error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- deleteAccount error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GoogleMapSearchModel, String>> getMapSearch(
      {required String keyword}) async {
     
     if (await handleCheckInternet()) {
      try {
        final mapSearchModel =
        await remoteDataSource.getMapSearch(keyword: keyword);
        return left(mapSearchModel);
      } catch (error) {
        return Right(ErrorHandler.handle(error).failure);
      }
    } else {
      // no internet connection error
      return Right(StringsManager.notFoundError.tr());
    }
  }

  @override
  Future<Either<List<OrganizationModelResponse>, ResendOtpErrorResponse>> getOrganization({required String domain}) async {
    if (await handleCheckInternet()) {
    try {
    final getOrganizationModel = await remoteDataSource.getOrganization(domain: domain);
    return left(getOrganizationModel);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on getOrganizationModel error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: error.message));
    } catch (error) {
    debugPrint('-------------- getOrganizationModel error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler.handle(error).failure));
    }
    } else {
    return Right(
        ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<List<AdsModel>, ResendOtpErrorResponse>> getAds() async {
    if (await handleCheckInternet()){
      try {
        final getAdsModel = await remoteDataSource.getAds();
        return left(getAdsModel);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on getAdsModel error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: error.message));
      } catch (error) {
        debugPrint('-------------- getAdsModel error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    }else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<List<Categories>, ResendOtpErrorResponse>> getCategory() async {
    if(await handleCheckInternet()){
      try {
        final getCategories = await remoteDataSource.getCategories();
        return left(getCategories);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on getCategories error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: error.message));
      } catch (error) {
        debugPrint('-------------- getCategories error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler.handle(error).failure));
      }
    }else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<GetProductModelResponse, ResendOtpErrorResponse>> getProduct({required GetProductRequest getProductRequest}) async {
    if (await handleCheckInternet()) {
    try {
    final getProduct = await remoteDataSource.getProduct(
      getProductRequest: getProductRequest
    );
    return left(getProduct);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on getProduct error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- getProduct error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler.handle(error).failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<AddSessionModelResponse, ResendOtpErrorResponse>> addSession()async {
    if (await handleCheckInternet()) {
      try {
        final addSession = await remoteDataSource.addSession();
        return left(addSession);
      } on ResendOtpErrorResponse catch (error) {
        debugPrint('-------------- on addSession error: $error --------------');
        return Right(error);
      } catch (error) {
        debugPrint('-------------- addSession error: $error --------------');
        return Right(ResendOtpErrorResponse(
            message: ErrorHandler
                .handle(error)
                .failure));
      }
    } else {
      return Right(
          ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<List<GetAllBranchesModelResponse>, ResendOtpErrorResponse>> getAllBranchesModelResponse() async {
    if (await handleCheckInternet()) {
    try {
    final getAllBranches = await remoteDataSource.getAllBranchesModelResponse();
    return left(getAllBranches);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on getAllBranches error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- getAllBranches error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler
        .handle(error)
        .failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<CreateAddressModelResponse, ResendOtpErrorResponse>> createAddressModelResponse({required CreateAddressRequest createAddressRequest}) async {
    if (await handleCheckInternet()) {
    try {
    final createAddressModelResponse = await remoteDataSource.createAddressModelResponse(
      createAddressRequest: createAddressRequest
    );
    return left(createAddressModelResponse);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on createAddressModelResponse error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- createAddressModelResponse error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler
        .handle(error)
        .failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<List<CreateAddressModelResponse>, ResendOtpErrorResponse>> getAllAddress({bool? isMain}) async {
    if (await handleCheckInternet()) {
    try {
    final createAddressModelResponse = await remoteDataSource.getAllAddressModelResponse(
      isMain: isMain
    );
    return left(createAddressModelResponse);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on createAddressModelResponse error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- createAddressModelResponse error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler
        .handle(error)
        .failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<CreateAddressModelResponse, ResendOtpErrorResponse>> patchAddressModelResponse({required CreateAddressRequest createAddressRequest, required int id}) async {
    if (await handleCheckInternet()) {
    try {
    final patchAddressModelResponse = await remoteDataSource.patchAddressModelResponse(
    createAddressRequest: createAddressRequest,
      id: id
    );
    return left(patchAddressModelResponse);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on patchAddressModelResponse error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- patchAddressModelResponse error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler
        .handle(error)
        .failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<String, ResendOtpErrorResponse>> deleteAddress({required int addressId}) async {
    if (await handleCheckInternet()) {
    try {
    final deleteAddress = await remoteDataSource.deleteAddress(addressId: addressId);
    return left(deleteAddress);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on deleteAddress error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- deleteAddress error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler.handle(error).failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<List<CreateAddressModelResponse>, ResendOtpErrorResponse>> getAllHomeAddress() async {
    if (await handleCheckInternet()) {
    try {
    final createAddressModelResponse = await remoteDataSource.getAllAddressModelResponse();
    return left(createAddressModelResponse);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on createAddressModelResponse error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- createAddressModelResponse error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler
        .handle(error)
        .failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }

  @override
  Future<Either<TrackOrderModelResponse, ResendOtpErrorResponse>> trackOrder() async{
    if (await handleCheckInternet()) {
    try {
    final trackOrderModel = await remoteDataSource.trackOrder();
    return left(trackOrderModel);
    } on ResendOtpErrorResponse catch (error) {
    debugPrint('-------------- on trackOrderModel error: $error --------------');
    return Right(error);
    } catch (error) {
    debugPrint('-------------- trackOrderModel error: $error --------------');
    return Right(ResendOtpErrorResponse(
    message: ErrorHandler
        .handle(error)
        .failure));
    }
    } else {
    return Right(
    ResendOtpErrorResponse(message: StringsManager.notFoundError.tr()));
    }
  }


}
