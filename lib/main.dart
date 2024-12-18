import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ibnelbarh/shared/resources/bloc_observer.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/app_root/screen/app_root.dart';
import 'package:ibnelbarh/views/base_button_bar/cubit/base_screen_navigation_cubit.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/home_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/map_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/order_status_cubit.dart';
import 'package:ibnelbarh/views/order/cubit/order_cubit.dart';
import 'package:ibnelbarh/views/otp/cubit/otp_cubit.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';
import 'package:ibnelbarh/views/socket/socket_cubit.dart';
import 'package:ibnelbarh/views/splash/cubit/splash_cubit.dart';

import 'model/hive_type/profile_hive.dart';
import 'model/requests/add_my_address_request.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();

  // Register the adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AddNewAddressRequestAdapter());
  await Hive.openBox<AddNewAddressRequest>('addNewAddressRequestBox');
  await Hive.openBox<AddNewAddressRequest>('myAddressRequestBox');

  await ServiceLocator.init();

  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();


  runApp(EasyLocalization(startLocale:const Locale('ar') ,
    supportedLocales: const [Locale('ar'), Locale('en')],
    path: 'assets/translation',
    fallbackLocale: const Locale('ar'),
    saveLocale: true,

    child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ThemeCubit>()..getSavedTheme(),),
          BlocProvider(create: (context) => sl<BaseScreenNavigationCubit>()),
          BlocProvider(create: (context) => sl<OtpCubit>()),
          BlocProvider(create: (context) => sl<HomeCubit>()),
          BlocProvider(create: (context) => sl<CartCubit>()),
          BlocProvider(create: (context) => sl<SettingsCubit>()),
          BlocProvider(create: (context) => sl<OrderCubit>()),
          BlocProvider(create: (context) => sl<MapCubit>()),
          BlocProvider(create: (context) => sl<OrderStatusCubit>()),
          BlocProvider(create: (context) => sl<SplashCubit>()),
          BlocProvider(create: (context) => sl<SocketCubit>()),
          // BlocProvider(create: (context) {
          //   return SocketCubit();
          // }),
          // BlocProvider(create: (context) => sl<RideServiceCubit>()),
          

        ],
        child: const AppRoot()),
  ));
}
