
import '../../model/requests/add_cart_item_request.dart';
import '../../model/requests/check_out_request.dart';
import '../../model/requests/create_address_request.dart';
import '../../model/requests/forgot_pass_request.dart';
import '../../model/requests/get_product_request.dart';
import '../../model/requests/login_request.dart';
import '../../model/requests/otp_verfiy_request.dart';
import '../../model/requests/patch_cart_item_request.dart';
import '../../model/requests/register_request.dart';
import '../../model/requests/resend_otp_request.dart';
import '../../model/requests/reset_pass_request.dart';
import '../../model/responses/add_coupon_response.dart';
import '../../model/responses/add_delete_cart_item_response.dart';
import '../../model/responses/add_session_model_response.dart';
import '../../model/responses/create_address_model_respose.dart';
import '../../model/responses/forgot_pass_response.dart';
import '../../model/responses/get_all_branches_model_response.dart';
import '../../model/responses/get_cart_model.dart';
import '../../model/responses/get_home_response.dart';
import '../../model/responses/get_order_response.dart';
import '../../model/responses/get_product_model_response.dart';
import '../../model/responses/get_profile_response.dart';
import '../../model/responses/google_map_search_model.dart';
import '../../model/responses/login_response.dart';
import '../../model/responses/organization_response.dart';
import '../../model/responses/otp_verify_response.dart';
import '../../model/responses/register_response.dart';
import '../../model/responses/resend_otp_response.dart';
import '../../model/responses/reset_pass_response.dart';
import '../../model/responses/track_order_model_response.dart';

abstract class RemoteDataSource {

  Future<UserRegisterSuccessResponse> register(
      {required UserRegisterRequest registerRequest});

  Future<LoginSuccessResponse> login({required LoginRequest loginRequest});


  Future<LoginSuccessResponse> getUserProfile();

  Future<UserOtpVerifySuccessResponse> userOtp(
      {required UserOtpVerifyRequest userOtpVerifyRequest});

  Future<ForgotPassSuccessResponse> forgotPassword(
      {required ForgotPassRequest forgotPassRequest});

  Future<ResetPasswordSuccessResponse> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest,required String token});

  Future<ResendOtpSuccessResponse> resendOtp(
      {required ResendOtpRequest resendOtpRequest});

  Future<HomeModel> getHomeData();
  Future<List<CartItemModel>> getHomeDataCategory({required String categoryTitle,required String search});

  Future<AddDeleteCartItemResponse> addCartItem({required AddCartItemRequest addCartItemRequest});


  Future<GetProfileResponse> getProfile();

  Future<GetCartModel> getCart() ;

  Future<GetProfileResponse> patchProfile({required String fullName,required String email});

  Future<GetCartModel> deleteCart({required int cartId});

  Future<GetCartModel> patchCartItem({required PatchCartItemRequest addCartItemRequest});

  Future<ChangePasswordSuccessResponse> changePassword(
      {required ChangePasswordRequest resetPasswordRequest});

  Future<ChangePasswordSuccessResponse> checkOut(
      {required CheckOutRequest checkOutRequest});

  Future<AddCouponResponse> addCoupon(
      {required String coupon});


  Future<GetOrderResponseModel> getOrder(
      {required String orderStatus});

  Future<ChangePasswordSuccessResponse> cancelOrder(
      {required int orderId});

  Future<ChangePasswordSuccessResponse> reOrder({required int orderId});

  Future<ChangePasswordSuccessResponse> deleteAccount();

  Future<GoogleMapSearchModel> getMapSearch({
    required String keyword
  });

  Future<List<OrganizationModelResponse>> getOrganization({
    required String domain
});

  Future<List<AdsModel>> getAds();

  Future<List<Categories>> getCategories();

  Future<GetProductModelResponse> getProduct({required GetProductRequest getProductRequest});

  Future<AddSessionModelResponse> addSession();

  Future<List<GetAllBranchesModelResponse>> getAllBranchesModelResponse();
  Future<CreateAddressModelResponse> createAddressModelResponse({required CreateAddressRequest createAddressRequest});

  Future<List<CreateAddressModelResponse>> getAllAddressModelResponse({bool? isMain});
  Future<CreateAddressModelResponse> patchAddressModelResponse({required CreateAddressRequest createAddressRequest,required int id});


  Future<List<CreateAddressModelResponse>> getAllHomeAddressModelResponse();




  Future<String> deleteAddress({required int addressId});

  Future<TrackOrderModelResponse> trackOrder();

}
