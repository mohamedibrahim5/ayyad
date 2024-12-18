import 'package:dartz/dartz.dart';
import 'package:ibnelbarh/model/requests/add_cart_item_request.dart';
import 'package:ibnelbarh/model/requests/patch_cart_item_request.dart';
import 'package:ibnelbarh/model/responses/google_map_search_model.dart';

import '../model/requests/check_out_request.dart';
import '../model/requests/create_address_request.dart';
import '../model/requests/forgot_pass_request.dart';
import '../model/requests/get_product_request.dart';
import '../model/requests/login_request.dart';
import '../model/requests/otp_verfiy_request.dart';
import '../model/requests/register_request.dart';
import '../model/requests/resend_otp_request.dart';
import '../model/requests/reset_pass_request.dart';
import '../model/responses/add_coupon_response.dart';
import '../model/responses/add_delete_cart_item_response.dart';
import '../model/responses/add_session_model_response.dart';
import '../model/responses/create_address_model_respose.dart';
import '../model/responses/forgot_pass_response.dart';
import '../model/responses/get_all_branches_model_response.dart';
import '../model/responses/get_cart_model.dart';
import '../model/responses/get_home_response.dart';
import '../model/responses/get_order_response.dart';
import '../model/responses/get_product_model_response.dart';
import '../model/responses/get_profile_response.dart';
import '../model/responses/login_response.dart';
import '../model/responses/organization_response.dart';
import '../model/responses/otp_verify_response.dart';
import '../model/responses/register_response.dart';
import '../model/responses/resend_otp_response.dart';
import '../model/responses/reset_pass_response.dart';
import '../model/responses/track_order_model_response.dart';


abstract class Repository {
  Future<Either<UserRegisterSuccessResponse, UserRegisterErrorResponse>>
  registerClient({required UserRegisterRequest clientRegisterRequest});

  Future<Either<LoginSuccessResponse, LoginErrorResponse>> login(
      {required LoginRequest loginRequest});

  Future<Either<LoginSuccessResponse, LoginErrorResponse>> getUserProfile();

  Future<Either<UserOtpVerifySuccessResponse, UserOtpVerifyErrorResponse>>
  userOtp({required UserOtpVerifyRequest userOtpVerifyRequest});

  Future<Either<ForgotPassSuccessResponse, ForgotPassErrorResponse>>
  forgotPassword({required ForgotPassRequest forgotPassRequest});

  Future<Either<ResetPasswordSuccessResponse, ResetPasswordErrorResponse>>
  resetPassword({required ResetPasswordRequest resetPasswordRequest,required String token});

  Future<Either<ResendOtpSuccessResponse, ResendOtpErrorResponse>> resendOtp(
      {required ResendOtpRequest resendOtpRequest});

  Future<Either<HomeModel, ResendOtpErrorResponse>> getHomeData();


  Future<Either<List<CartItemModel>, ResendOtpErrorResponse>> getHomeDataCategory({required String categoryTitle,required String search});

  Future<Either<AddDeleteCartItemResponse, ResendOtpErrorResponse>> addCartItem({required AddCartItemRequest addCartItemRequest});


  Future<Either<GetProfileResponse, ResendOtpErrorResponse>> getProfile();

  Future<Either<GetCartModel, ResendOtpErrorResponse>> getCart();

  Future<Either<GetCartModel, ResendOtpErrorResponse>> deleteCart({required int cartId});

  Future<Either<GetCartModel, ResendOtpErrorResponse>> patchCartItem({required PatchCartItemRequest addCartItemRequest});

  Future<Either<ChangePasswordSuccessResponse, ResetPasswordErrorResponse>>
  changePassword({required ChangePasswordRequest resetPasswordRequest});


  Future<Either<ChangePasswordSuccessResponse, ChangePasswordErrorResponse>>
  checkOut({required CheckOutRequest checkOutRequest});

  Future<Either<AddCouponResponse, ResetPasswordErrorResponse>>
  addCoupon({required String coupon});


  Future<Either<GetOrderResponseModel, ResetPasswordErrorResponse>>
  getOrder({required String orderStatus});

  Future<Either<ChangePasswordSuccessResponse, ResetPasswordErrorResponse>>
  cancelOrder({required int orderId});

  Future<Either<ChangePasswordSuccessResponse, ResetPasswordErrorResponse>> reOrder({required int orderId});

  Future<Either<GetProfileResponse, ResendOtpErrorResponse>> patchProfile({required String fullName,required String email});

  Future<Either<ChangePasswordSuccessResponse, ResendOtpErrorResponse>> deleteAccount();

  Future<Either<GoogleMapSearchModel,String >> getMapSearch({
    required String keyword
  });

  Future<Either<List<OrganizationModelResponse>, ResendOtpErrorResponse>> getOrganization({
    required String domain
});


  Future<Either<List<AdsModel>, ResendOtpErrorResponse>> getAds();

  Future<Either<List<Categories>, ResendOtpErrorResponse>> getCategory();

  Future<Either<GetProductModelResponse, ResendOtpErrorResponse>> getProduct({required GetProductRequest getProductRequest});

  Future<Either<AddSessionModelResponse, ResendOtpErrorResponse>> addSession();

  Future<Either<List<GetAllBranchesModelResponse>, ResendOtpErrorResponse>> getAllBranchesModelResponse();

  Future<Either<CreateAddressModelResponse, ResendOtpErrorResponse>>  createAddressModelResponse({required CreateAddressRequest createAddressRequest});

  Future<Either<List<CreateAddressModelResponse>, ResendOtpErrorResponse>>  getAllAddress({bool? isMain});

  Future<Either<List<CreateAddressModelResponse>, ResendOtpErrorResponse>>  getAllHomeAddress();


  Future<Either<CreateAddressModelResponse, ResendOtpErrorResponse>>  patchAddressModelResponse({required CreateAddressRequest createAddressRequest,required int id});

  Future<Either<String, ResendOtpErrorResponse>> deleteAddress({required int addressId});

  Future<Either<TrackOrderModelResponse, ResendOtpErrorResponse>> trackOrder();




}
