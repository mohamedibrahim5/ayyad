

import 'package:dio/dio.dart';
import 'package:ibnelbarh/data/remote/remote_datasource.dart';
import 'package:ibnelbarh/model/requests/add_cart_item_request.dart';
import 'package:ibnelbarh/model/requests/check_out_request.dart';
import 'package:ibnelbarh/model/requests/create_address_request.dart';
import 'package:ibnelbarh/model/requests/forgot_pass_request.dart';
import 'package:ibnelbarh/model/requests/get_product_request.dart';
import 'package:ibnelbarh/model/responses/add_session_model_response.dart';
import 'package:ibnelbarh/model/responses/create_address_model_respose.dart';
import 'package:ibnelbarh/model/responses/get_all_branches_model_response.dart';
import 'package:ibnelbarh/model/responses/get_product_model_response.dart';
import 'package:ibnelbarh/model/responses/organization_response.dart';
import 'package:ibnelbarh/model/responses/track_order_model_response.dart';

import '../../model/requests/login_request.dart';
import '../../model/requests/otp_verfiy_request.dart';
import '../../model/requests/patch_cart_item_request.dart';
import '../../model/requests/register_request.dart';
import '../../model/requests/resend_otp_request.dart';
import '../../model/requests/reset_pass_request.dart';
import '../../model/responses/add_coupon_response.dart';
import '../../model/responses/add_delete_cart_item_response.dart';
import '../../model/responses/forgot_pass_response.dart';
import '../../model/responses/get_cart_model.dart';
import '../../model/responses/get_home_response.dart';
import '../../model/responses/get_order_response.dart';
import '../../model/responses/get_profile_response.dart';
import '../../model/responses/google_map_search_model.dart';
import '../../model/responses/login_response.dart';
import '../../model/responses/otp_verify_response.dart';
import '../../model/responses/register_response.dart';
import '../../model/responses/resend_otp_response.dart';
import '../../model/responses/reset_pass_response.dart';
import '../../shared/resources/constant.dart';
import '../../shared/resources/dio_helper.dart';
import '../../shared/resources/prefs_helper.dart';
import '../../shared/resources/service_locator.dart';


class RemoteDataSourceImpl extends RemoteDataSource {
  final Dio dio;
  final DioHelper dioHelper;

  RemoteDataSourceImpl({required this.dio, required this.dioHelper});

  @override
  Future<UserRegisterSuccessResponse> register(
      {required UserRegisterRequest registerRequest}) async {
    dioHelper.removeHeader();
    final response =
    await dio.post(Constants.registerUrl, data: registerRequest.toJson());

    if (response.statusCode == 201) {
      return UserRegisterSuccessResponse.fromJson(json: response.data);
    }else if (response.statusCode == 403) {
      return UserRegisterSuccessResponse.fromNotVerified(json: response.data);
    } else {
      throw UserRegisterErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<LoginSuccessResponse> login(
      {required LoginRequest loginRequest}) async {
    dioHelper.removeHeader();
    final response =
    await dio.post(Constants.loginUrl, data: loginRequest.toJson());

    if (response.statusCode == 200) {
      return LoginSuccessResponse.fromJson(json: response.data);
    } else if (response.statusCode == 403) {
      return LoginSuccessResponse.fromNotVerified(json: response.data);
    } else {
      throw LoginErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<LoginSuccessResponse> getUserProfile() async {

    // String value = await sl<PrefsHelper>().getToken();
    // dio.options.headers['Authorization'] = 'Bearer ${value}' ;
    dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getUserProfile,);

    if (response.statusCode == 200) {
      return LoginSuccessResponse.fromJson(json: response.data);
    } else if (response.statusCode == 403) {
      return LoginSuccessResponse.fromNotVerified(json: response.data);
    } else {
      throw LoginErrorResponse.fromJson(json: response.data);
    }
  }


  @override
  Future<UserOtpVerifySuccessResponse> userOtp(
      {required UserOtpVerifyRequest userOtpVerifyRequest}) async {
    final response = await dio.post(Constants.verifyOtpClient,
        data: userOtpVerifyRequest.toJson());
    if (response.statusCode == 200) {
      return UserOtpVerifySuccessResponse.fromJson(json: response.data);
    } else {
      throw UserOtpVerifyErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ForgotPassSuccessResponse> forgotPassword(
      {required ForgotPassRequest forgotPassRequest}) async {
    dioHelper.removeHeader();
    final response = await dio.post(Constants.resendOtp,
        data: forgotPassRequest.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ForgotPassSuccessResponse.fromJson(json: response.data);
    } else {
      throw ForgotPassErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ResetPasswordSuccessResponse> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest,required String token}) async {
    // dioHelper.addHeaders();
    sl<Dio>().options.headers['Authorization'] = 'Bearer $token' ;
    final response = await dio.post(Constants.resetPassUrl,
        data: resetPasswordRequest.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ResetPasswordSuccessResponse.fromJson(json: response.data);
    } else {
      throw ResetPasswordErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ResendOtpSuccessResponse> resendOtp(
      {required ResendOtpRequest resendOtpRequest}) async {
    dioHelper.removeHeader();
    final response =
    await dio.post(Constants.resendOtp, data: resendOtpRequest.toJson());
    if (response.statusCode == 200) {
      return ResendOtpSuccessResponse.fromJson(json: response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<HomeModel> getHomeData() async {
    dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getHomeDataUrl);
    if (response.statusCode == 200) {
      return HomeModel.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<List<CartItemModel>> getHomeDataCategory({required String categoryTitle,required String search}) async {
    dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getHomeCategoryDataUrl, queryParameters: {
          if(categoryTitle.isNotEmpty)
            'category__title': categoryTitle,
          if(search.isNotEmpty)
            'title': search

        });
    if (response.statusCode == 200) {
      return List.from(response.data)
          .map((category) => CartItemModel.fromJson(category))
          .toList();
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<AddDeleteCartItemResponse> addCartItem({required AddCartItemRequest addCartItemRequest}) async {
    dioHelper.addHeaders();
    final response =
        await dio.post(Constants.getCart, data: addCartItemRequest.toJson());
    if (response.statusCode == 201) {
      return AddDeleteCartItemResponse.fromJson(json: response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }


  @override
  Future<GetProfileResponse> getProfile() async {
    await dioHelper.addHeaders();
    final response =
        await dio.get(Constants.profileUrl);
    if (response.statusCode == 200) {
      return GetProfileResponse.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GetCartModel> getCart() async {
    await dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getCart);
    if (response.statusCode == 200) {
      return GetCartModel.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GetCartModel> deleteCart({required int cartId}) async {
    await dioHelper.addHeaders();
    final response =
    await dio.delete('${Constants.deleteCartItemUrl2}/$cartId/',);
    if (response.statusCode == 200) {
      return GetCartModel.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GetCartModel> patchCartItem({required PatchCartItemRequest addCartItemRequest}) async {
    dioHelper.addHeaders();
    final response =
    await dio.patch('${Constants.deleteCartItemUrl2}/${addCartItemRequest.productId}/', data: addCartItemRequest.toJson());
    if (response.statusCode == 200) {
      return GetCartModel.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ChangePasswordSuccessResponse> changePassword({required ChangePasswordRequest resetPasswordRequest}) async {
    dioHelper.addHeaders();
    final response = await dio.patch(Constants.changePassUrl,
        data: resetPasswordRequest.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ChangePasswordSuccessResponse.fromJson(json: response.data);
    }else  if (response.statusCode == 400 ) {
      return ChangePasswordSuccessResponse.fromNotVerified(json: response.data);
    } else {
      throw ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ChangePasswordSuccessResponse> checkOut({required CheckOutRequest checkOutRequest}) async {
    dioHelper.addHeaders();
    final response = await dio.post(Constants.checkOut,
        data: checkOutRequest.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
    // else if (response.statusCode == 400){
    //   return ChangePasswordSuccessResponse.fromNotVerified(json: response.data);
    // }
      else {
      throw ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<AddCouponResponse> addCoupon({required String coupon}) async {
    dioHelper.addHeaders();
    final response = await dio.get(Constants.addCoupon,
        queryParameters: {
          'code': coupon
        });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return AddCouponResponse.fromJson(json: response.data);
    }
    else  if (response.statusCode == 400 ) {
      return AddCouponResponse.fromNotVerified(json: response.data);
    }
    else {
      throw ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GetOrderResponseModel> getOrder({required String orderStatus}) async {
    dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getOrder, queryParameters: {
          'order_status': orderStatus
    });
    if (response.statusCode == 200) {
      return GetOrderResponseModel.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ChangePasswordSuccessResponse> cancelOrder({required int orderId}) async {
    dioHelper.addHeaders();
    final response = await dio.post(Constants.cancelOrder,
        data: {
          'order_id': orderId
        });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ChangePasswordSuccessResponse.fromJson(json:response.data);
    } else {
      throw ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ChangePasswordSuccessResponse> reOrder({required int orderId}) async {
    dioHelper.addHeaders();
    final response = await dio.post(Constants.reOrder,data: {
      'order_id': orderId
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ChangePasswordSuccessResponse.fromJson(json: response.data);
    } else {
      throw ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GetProfileResponse> patchProfile({required String fullName,required String email}) async {
    await dioHelper.addHeaders();
    final response =
        await dio.patch(Constants.profileUrl,data: {
          'full_name': fullName,
          // 'email': email
        });
    if (response.statusCode == 200) {
      return GetProfileResponse.fromJson(response.data);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<ChangePasswordSuccessResponse> deleteAccount() async {
    await dioHelper.addHeaders();
    final response =
        await dio.delete(Constants.deleteAccount);
    if (response.statusCode == 200) {
      return ChangePasswordSuccessResponse.fromJson(json: response.data);
    } else {
      throw ChangePasswordSuccessResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GoogleMapSearchModel> getMapSearch({required String keyword}) async {
    final response = await dio.get(Constants.mapSearch, queryParameters: {
      "key": "AIzaSyDXSvQvWo_ay-Tgq7qIlXIgdn-vNNxOAFA",
      "query": keyword,
      // "country" : "egypt"
    });
    if (response.statusCode == 200) {
      // if the response is success then convert the response to user model
      return GoogleMapSearchModel.fromJson(response.data);
    } else {
      // if the response is not success the throw the response error message
      throw response.data;
    }
  }

  @override
  Future<List<OrganizationModelResponse>> getOrganization({required String domain}) async {
    final response =
        await dio.get(Constants.getOrganizations, queryParameters: {
          "name":domain
    });
    if (response.statusCode == 200) {
      sl<PrefsHelper>().setData(key: 'organizationId', value:response.data[0]['id']);
      return List.from(response.data)
          .map((organization) => OrganizationModelResponse.fromJson(json: organization))
          .toList();
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<List<AdsModel>> getAds() async {
    await dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getAds);
    if (response.statusCode == 200) {
      return List.from(response.data)
          .map((ads) => AdsModel.fromJson(ads))
          .toList();
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<List<Categories>> getCategories() async {
    await dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getCategories);
    if (response.statusCode == 200) {
      return List.from(response.data)
          .map((category) => Categories.fromJson(category))
          .toList();
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<GetProductModelResponse> getProduct({required GetProductRequest getProductRequest}) async {
    await dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getProduct,queryParameters: getProductRequest.toJson());
    if (response.statusCode == 200) {
      return GetProductModelResponse.fromJson(response.data,);
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<AddSessionModelResponse> addSession()async {
    await dioHelper.addHeaders();
    final response = await dio.post(Constants.addSession);
    if(response.statusCode == 201){
      return AddSessionModelResponse.fromJson(response.data);
    }else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<List<GetAllBranchesModelResponse>> getAllBranchesModelResponse() async {
    await dioHelper.addHeaders();
    final response =
        await dio.get(Constants.getBranches);
    if (response.statusCode == 200) {
      return List.from(response.data)
          .map((branch) => GetAllBranchesModelResponse.fromJson(branch))
          .toList();
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<CreateAddressModelResponse> createAddressModelResponse({required CreateAddressRequest createAddressRequest}) async {
    await dioHelper.addHeaders();
    final response = await dio.post(Constants.createAddress,data: createAddressRequest.toJson());
    if(response.statusCode == 201){
      return CreateAddressModelResponse.fromJson(response.data);
    }else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<List<CreateAddressModelResponse>> getAllAddressModelResponse({bool? isMain}) async {
    await dioHelper.addHeaders();
    final response = await dio.get(Constants.createAddress,queryParameters: {
      if(isMain != null)
        'is_main': isMain,
    });
    if(response.statusCode == 200){
      return List.from(response.data)
          .map((branch) => CreateAddressModelResponse.fromJson(branch))
          .toList();
      // return GetAllAddressModelResponse.fromJson(response.data);
    }else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<CreateAddressModelResponse> patchAddressModelResponse({required CreateAddressRequest createAddressRequest, required int id}) async {
    await dioHelper.addHeaders();
    final response = await dio.patch('${Constants.createAddress}/$id/',data: createAddressRequest.toJson());
    if(response.statusCode == 200){
      return CreateAddressModelResponse.fromJson(response.data);
    }else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<String> deleteAddress({required int addressId}) async {
    dioHelper.addHeaders();
    final response =
        await dio.delete('${Constants.createAddress}/$addressId/');
    if (response.statusCode == 204) {
      return 'Deleted';
    } else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<List<CreateAddressModelResponse>> getAllHomeAddressModelResponse() async {
    await dioHelper.addHeaders();
    final response = await dio.get(Constants.createAddress);
    if(response.statusCode == 200){
      return List.from(response.data)
          .map((branch) => CreateAddressModelResponse.fromJson(branch))
          .toList();
      // return GetAllAddressModelResponse.fromJson(response.data);
    }else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

  @override
  Future<TrackOrderModelResponse> trackOrder() async{
    await dioHelper.addHeaders();
    final response = await dio.get(Constants.trackOrder);
    if(response.statusCode == 200){
      return TrackOrderModelResponse.fromJson(response.data);
      // return GetAllAddressModelResponse.fromJson(response.data);
    }else {
      throw ResendOtpErrorResponse.fromJson(json: response.data);
    }
  }

}