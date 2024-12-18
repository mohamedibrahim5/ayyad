import 'package:hive/hive.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:ibnelbarh/model/requests/add_my_address_request.dart';

class Constants {


   //  static String
 // static String  baseUrl = "http://192.168.88.149:8000/";
 //   static String baseUrl = "http://192.168.88.149:8000/";
 // static String baseUrl = "https://octopus-app-2-5ipqv.ondigitalocean.app/";
    // static String baseUrl = "https://apishawarma.cyparta.com/";
     static String baseUrl2 = "http://192.168.88.55:9000/";
     static String baseUrl = "https://apirestaurant.cyparta.com/" ;
  static String emailRegix =
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  static String registerClientUrl = "register/client/";
  static String loginFCM = "api/devices/login/";
  static String registerOwnerUrl = "register/service/";
  static String verifyOtpClient = "api/verify-otp/";
  static String verifyOtpOwner  = "api/verifyotp/service/";
  static String resendOtp = "api/send-otp/";
  static String getHomeDataUrl = "food/home/";
  static String deleteCartItemUrl = "food/cart/";
     static String deleteCartItemUrl2 = "orders/cart/items/";
   static String deleteAccount = "api/delete-account/";
  // static String addCartItemUrl = "food/cart/add-to-cart/";
  static String getHomeCategoryDataUrl = "food/products/";
  static String profileUrl = "api/profile/";
  static String getCart = "orders/cart/";

  static String resetPassUrl = "api/reset-password/";
  static String changePassUrl = "api/change-password/";
  // static String forgotPassUrl = "api/request-reset/";//unUsed
  static String verifyForgotPassOtpUrl = "api/reset_password/";
  static const String token = 'token';
  static const String riderStartLocationPolyline = 'riderStartLocationPolyline';
  static const String rememberMe = 'rememberMe';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String serviceProvider = 'serviceProvider';
  static const String masterCard = 'MasterCard';
  static const String visa = 'Visa';
  static const String americanExpress = 'American Express';
  static const String unionPay = 'Union Pay';
  static const String tokenText = 'Token';
  static const String firstLunch = 'firstLunch';
  static const String showOnBoarding = 'showOnBoarding';
  static const String guestCheck = 'guestCheck';
  static const authorization = 'Authorization';
  static const acceptLang = 'Accept-Language';
  static const arabic = 'ar';
  static const english = 'en';
  static const russian = 'ru';
  static const String changePassword = "api/changepassword/";
  static const String logout = "api/devices/logout/";
  static const String notifications = "users/notifications/";
  static const String placeNameByCoordinates = "service/api/nominatim-Reverse/";
  static const String rateServiceProvider = "users/ratings/";
  static const String followUs = "users/follow-us/";
  static const String rateClient = "users/clientratings/";
  static const String searchMap="https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static const String searchPlace="service/api/nominatim-search/";
  ////
  static String creditCardFiller =  "xxxx xxxx xxxx";
  static const String rideService="service/ride/";
  static const String userLocation="users/location/";
  static const String sendWithdrawRequest="users/contact-us/";
  static const String currentRide="service/clienthistory/";
  static const String applyForService="service/appliers/";
  static const String acceptApplierService= "service/acceptapplier/";
  static const String arrivedToClient="service/provider-arrived/";
  static const String finishRide= "service/provider-done/";
  static const String acceptCash= "service/accept-cash/";
  static const String rideHistory="service/history/";
  static const String changePhone="api/changephone/";
  static const String verifyNewPhone="verify_new_phone/";
  static const String clientCancelStartedRide="service/ride/";
  static const String baseSocketUrl2 = "ws://192.168.88.55:9000/order/?";
     static const String baseSocketUrl = "wss://apirestaurant.cyparta.com/order/?";
  static const String payment="users/Payment-token/";
  /// socket data types
  static const String sendApply="send_apply";
  static const String sendAcceptance="send_acceptance";
  static const String sendNewRide="send_new_ride";
  static const String sendRideCancel="send_cancel";
  static const String sendApplyCancel="send_cancel_apply";
  static const String sendArrival="send_arrival";
  static const String sendDone="send_done";
  static const String sendCash="send_cash";
  static const String sendNotification="send_not";
  static const String failCard="fail_card";
  static const String driverLocationUpdated="location";
  static const String sendLocation="send_location";
  static const String type="type";
  static const String data="data";
  static const String completed="completed";
  static const String clientNotVerified="OTP code has been sent to your phone number!";
  static const String providerNotVerified="OTP code has been sent to your phone number!";
  static const String saveNewCard="/payments/save_card_with_first_purchase/";
  static const String applierDoes="type";
  static const String applierNotExist='applier does not exists';
  static const String rideNotExist='The ride service is not available any more';
  static const String accountIsSuspended='Your account is suspended or reached limit please contact customer service.';
  static const String accountIsSuspendedAr='Your account is suspended or reached limit please contact customer service.';
  static const String notFound= "Not found.";
  static const String cash="cash";
  static const String credit='credit';
  static const String payWithCard='payments/pay_with_saved_card/';
  // notification types
  static const String notificationChannelId="channelId";
  static const String notificationChannelName="channelName";
  static const String newTripNotification="New Trip"; // to service provider : on tap -> nav to OwnerHomeScreen  on init -> load rides
  static const String accountSuspendedNotification="Account suspended";  // to service provider : on tap ->nav to OwnerHomeScreen
  // static const String passwordChangedNotification="Password changed"; // to service provider : on tap ->nav to OwnerHomeScreen
  // static const String phoneChangedNotification="Phone number changed"; // to service provider : on tap ->nav to OwnerHomeScreen
  static const String orderCreatedNotification="Order created"; // to client  : on tap ->nav to Choose rider   on init -> load riders
  static const String negativeBalanceNotification="Negative balance"; // to service provider  : on tap ->nav to owner wallet  // on init -> get profile
  static const String tripAcceptedNotification="Trip accepted";  // to service provider  : on tap ->nav to owner journey  // on init -> get current  ride
  static const String tripDeclinedNotification="Trip Declined";  // to client  : on tap -> nav to Choose rider   on init -> load riders
  static const String youHaveBeenFinedNotification="You have been fined";
  static const String bikeArrivedNotification="Bike arrived"; // to client  : on tap ->nav to journey  // on init -> load current ride
  static const String newApplier= "New Applier"; // to client  : on tap -> nav to Choose rider   on init -> load riders
  // static const String reviewsNotification="Reviews";
  static const String paymentsNotification="Payments";
  static const String ridePaidByVisaNotification="Credit Card Payment"; // to service Provider  : on tap -> nav to wallet  on init -> get profile
  static const String payCashToRider="Cash Payment"; // to client  : on tap -> nav to rate screen  on init -> load current ride
  static const String paymentDifference="Payment Difference"; // to client  : on tap -> nav to wallet  on init -> load profile
  static const String ridePaymentFailedOwnerNotification="Credit Card Failed Payment"; // to service provider  : on tap -> nav to cash screen  on init -> load current ride
  static const String ridePaymentFailedClientNotification="Payment Failed"; // to client  : on tap -> nav to rate screen  on init -> load current ride
  static const String payoffDebt="Pay Debt"; // to service  : on tap -> nav to wallet  on init -> load profile
  static const String orderCancelledNotification="Order cancelled"; // to service provider  : on tap -> nav to home  on init -> load rides
  static const String rideClientDone="Ride Done"; // to service provider  : on tap -> nav to home  on init -> load rides
  static const String cancelledNotification="Cancelled";
  static const String phoneNumber = 'phoneNumber';
  static const String emailAddress = 'emailAddress';
  static const String checkNavigateForgetPasswordOrRegister = 'checkNavigateForgetPasswordOrRegister';
  static const String otpForgetPassword = 'otpForgetPassword';
  static const String otpText = 'otpText';
  static const String guest = 'guest';
  static const String cartItemHome = 'cartItemHome';
  static const String cartItem = 'cartItem';
  static const String cartItemUpdate = 'cartItemUpdate';
   static const String cartItemOrder = 'cartItemOrder';

   static const String theme = 'theme';
  static const String light = 'light';
  static const String dark = 'dark';
  static const String lockApp = 'lockApp';
  static const String passwordLockApp = 'passwordLockApp';
  static const String getColorPreference = 'getColorPreference';
  static const String getCurrency = 'getCurrency';
  static const String currencyUrl = 'https://api.coincap.io/v2/assets';
  static String loginUrl = "api/login/";
  static const String registerUrl = 'api/register/';
  static const String getUserProfile = 'api/profile/';
  static const String indexOfItem = 'indexOfItem';
   static const String indexOfItemOrder = 'indexOfItemOrder';
   static const String updateCart = 'updateCart';
  static const String cartModel = 'cartModel';
  static const String checkOut = 'orders/orders/checkout/';
  static const String addCoupon = 'core/promocodes/apply/';
  static const String getOrder = 'orders/orders/';
     static const String cancelOrder = 'orders/orders/cancel/';
     static const String reOrder = 'orders/orders/reorder/';
  static  Box<AddNewAddressRequest> addNewAddressRequestBox = Hive.box<AddNewAddressRequest>('addNewAddressRequestBox');
  static  Box<AddNewAddressRequest> myAddressRequestBox = Hive.box<AddNewAddressRequest>('myAddressRequestBox');


  static  String mapSearch ="https://maps.googleapis.com/maps/api/place/textsearch/json" ;
  static  String getOrganizations ="core/organizations/" ;

     static  String getAds ="food/ads/" ;
     static String getCategories ="food/categories/" ;
     static String getProduct ="food/products/" ;
     static String addSession ="api/anonymous-users/" ;
     static String getBranches ="core/branches/" ;
     static String createAddress ="core/addresses/" ;
      // static String getAddresses ="core/addresses/" ;
      static String createOrder ="create_order" ;
      static String prepareOrder = 'prepare_order' ;
      static String outOfDelivery = 'out_of_delivery_order' ;
      static String deliveredOrder ="delivered_order" ;
      static String trackOrder = 'orders/track-order/' ;

      static Country selectedCountry =  const Country(
        code: 'EG',
        name: 'Egypt',
        dialCode: '+20',
        flag: 'assets/flags/eg.png',
        nameTranslations: {},
        minLength: 11,
        maxLength: 11,
      );

      // static String priceOfProduct = 'LE' ;


}
