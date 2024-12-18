import 'package:flutter/cupertino.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/views/home/screen/google_map_background.dart';
import 'package:ibnelbarh/views/home/screen/order_status_screen.dart';
import 'package:ibnelbarh/views/home/screen/search_screen.dart';
import 'package:ibnelbarh/views/settings/screen/address_detailes_screen.dart';
import 'package:ibnelbarh/views/settings/screen/change_password_screen.dart';
import 'package:ibnelbarh/views/settings/screen/my_address_screen.dart';
import 'package:ibnelbarh/views/settings/screen/my_point_screen.dart';
import 'package:ibnelbarh/views/settings/screen/profile_screen.dart';
import 'package:ibnelbarh/views/settings/screen/settings_screen.dart';
import 'package:ibnelbarh/views/web_view_payment/screen/web_view_payment_screen.dart';

import '../../views/app_root/screen/no_internet.dart';
import '../../views/app_root/screen/server_error.dart';
import '../../views/base_button_bar/screen/base_screen.dart';
import '../../views/cart/screen/cart_item_order_screen.dart';
import '../../views/cart/screen/cart_item_screen.dart';
import '../../views/cart/screen/check_out_screen.dart';
import '../../views/cart/widget/order_confirmed_widget.dart';
import '../../views/forget_password/screen/forget_password_screen.dart';
import '../../views/login/screen/login_screen.dart';
import '../../views/onboarding/screen/on_bording_screen.dart';
import '../../views/order/screen/order_screen.dart';
import '../../views/otp/screen/otp_screen.dart';
import '../../views/register/screen/register_screen.dart';
import '../../views/set_new_password/screen/set_new_password_screen.dart';
import '../../views/splash/screen/splash_screen.dart';


class AppRouter {
  // method to generate screen routes
  static Route? onGenerateRoute(RouteSettings routeSettings) {


    switch (routeSettings.name) {
      case RoutesManager.splashScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const SplashScreen(),
        );
      case RoutesManager.firstScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const OnBoardingScreen(),
        );
    case RoutesManager.secondScreen:
    return CupertinoPageRoute(
    settings: routeSettings,
    builder: (_) =>  const OnBoardingScreen(),
    );
    case RoutesManager.thirdScreen:
    return CupertinoPageRoute(
    settings: routeSettings,
    builder: (_) =>  const OnBoardingScreen(),
    );
      case RoutesManager.loginScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const LoginScreen(),
        );
      case RoutesManager.registerScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const RegisterScreen(),
        );
      case RoutesManager.otpScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const OtpScreen(),
        );

      case RoutesManager.forgetPassword:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const ForgetPasswordScreen(),
        );
      case RoutesManager.setNewPassword:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const SetNewPasswordScreen(),
        );

      case RoutesManager.baseScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const BaseScreen(),
        );

      case RoutesManager.cartItemScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const CartItemScreen(),
        );

      case RoutesManager.settingScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const SettingsScreen(),
        );

      // case RoutesManager.cartItemUpdateScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) =>  const CartItemUpdateScreen(),
      //   );

      case RoutesManager.searchScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const SearchScreen(),
        );

      case RoutesManager.changePasswordScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const ChangePasswordScreen(),
        );

      case RoutesManager.myPointScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const MyPointScreen(),
        );

      case RoutesManager.myAddressScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const MyAddressScreen(),
        );

      case RoutesManager.googleMap:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const MapBackground(),
        );

      case RoutesManager.addressDetails:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const AddressDetails(),
        );

      case RoutesManager.orderStatusScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const OrderStatusScreen(),
        );








      case RoutesManager.checkOutScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const CheckoutScreen(),
        );

      case RoutesManager.orderConfirmedScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const OrderConfirmedEmptyWidget(),
        );

      case RoutesManager.orderScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const OrderScreen(),
        );

      case RoutesManager.profileScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const ProfileScreen(),
        );

      case RoutesManager.cartItemOrderScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const CartItemOrderScreen(),
        );

      case RoutesManager.webViewPaymentScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const WebViewPaymentScreen(),
        );

      case RoutesManager.serverErrorScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const ServerErrorScreen(),
        );

      case RoutesManager.noInternetScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) =>  const NoInternetScreen(),
        );
































      default:
        return null;
    }
  }
}
