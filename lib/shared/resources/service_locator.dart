

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ibnelbarh/data/remote/remote_datasource.dart';
import 'package:ibnelbarh/data/remote/remote_datasource_impl.dart';
import 'package:ibnelbarh/repository/repository.dart';
import 'package:ibnelbarh/repository/repository_impl.dart';
import 'package:ibnelbarh/shared/resources/dio_helper.dart';
import 'package:ibnelbarh/shared/resources/hive_helper.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/network_info.dart';
import 'package:ibnelbarh/shared/resources/prefs_helper.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/base_button_bar/cubit/base_screen_navigation_cubit.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';
import 'package:ibnelbarh/views/forget_password/cubit/forget_password_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/home_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/map_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/order_status_cubit.dart';
import 'package:ibnelbarh/views/login/cubit/login_cubit.dart';
import 'package:ibnelbarh/views/order/cubit/order_cubit.dart';
import 'package:ibnelbarh/views/otp/cubit/otp_cubit.dart';
import 'package:ibnelbarh/views/register/cubit/register_cubit.dart';
import 'package:ibnelbarh/views/set_new_password/cubit/set_new_password_screen_cubit.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';
import 'package:location/location.dart';
import 'package:ibnelbarh/views/splash/cubit/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../views/socket/socket_cubit.dart';


final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // register helpers, datasource
    await _registerLazySingleton();

    // register cubits/blocs
    await _registerFactory();
  }
}

Future<void> _registerLazySingleton() async {
  // register dio and dio helper
  if (sl.isRegistered<Dio>()) {
    debugPrint('------------------- unregister Dio --------------------');
    sl.unregister<Dio>();
    sl.unregister<DioHelper>();
  }
  final Dio dio = DioHelper().init();
  debugPrint(
      '------------------- register Dio: ${dio.options.baseUrl} --------------------');
  sl.registerLazySingleton<Dio>(() => dio);
  sl.registerLazySingleton<DioHelper>(() => DioHelper());

  // register shared preferences
  if (sl.isRegistered<SharedPreferences>()) {
    sl.unregister<SharedPreferences>();
  }
  final sharedPrefs = await PrefsHelper().init();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  if (sl.isRegistered<PrefsHelper>()) {
    sl.unregister<PrefsHelper>();
  }

  sl.registerLazySingleton<PrefsHelper>(() => PrefsHelper());
  // hive
  final appDocumentDirectory =
  await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  sl.registerLazySingleton<HiveHelper>(() => HiveHelper());
  // network info
  if (sl.isRegistered<NetworkInfo>()) {
    sl.unregister<NetworkInfo>();
  }
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // navigation service
  if (sl.isRegistered<NavigationService>()) {
    sl.unregister<NavigationService>();
  }
  sl.registerLazySingleton<NavigationService>(() => NavigationService());



  // remote datasource
  if (sl.isRegistered<RemoteDataSource>()) {
    sl.unregister<RemoteDataSource>();
  }

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: sl(), dioHelper: sl()));

  // repositories
  if (sl.isRegistered<Repository>()) {
    sl.unregister<Repository>();
  }

  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<Location>(
          () => Location());

}

Future<void> _registerFactory() async {
  if (sl.isRegistered<LoginCubit>()) {
    sl.unregister<LoginCubit>();
  }

  sl.registerFactory(() => LoginCubit(repository: sl()));

  if (sl.isRegistered<RegisterCubit>()) {
    sl.unregister<RegisterCubit>();
  }

  sl.registerFactory(() => RegisterCubit(repository: sl()));

  if (sl.isRegistered<OrderStatusCubit>()) {
    sl.unregister<OrderStatusCubit>();
  }

  sl.registerFactory(() => OrderStatusCubit(repository: sl()));



  if (sl.isRegistered<OtpCubit>()) {
    sl.unregister<OtpCubit>();
  }

  sl.registerFactory(() => OtpCubit(repository: sl()));

  if (sl.isRegistered<ForgetPasswordCubit>()) {
    sl.unregister<ForgetPasswordCubit>();
  }

  sl.registerFactory(() => ForgetPasswordCubit(repository: sl()));

  if (sl.isRegistered<SetNewPasswordCubit>()) {
    sl.unregister<SetNewPasswordCubit>();
  }

  sl.registerFactory(() => SetNewPasswordCubit(repository: sl()));


  if (sl.isRegistered<MapCubit>()) {
    sl.unregister<MapCubit>();
  }

  sl.registerFactory(() => MapCubit(repository: sl()));

  if (sl.isRegistered<BaseScreenNavigationCubit>()) {
    sl.unregister<BaseScreenNavigationCubit>();
  }

  sl.registerFactory(() => BaseScreenNavigationCubit());

  if (sl.isRegistered<HomeCubit>()) {
    sl.unregister<HomeCubit>();
  }

  sl.registerFactory(() => HomeCubit(repository: sl()));



  sl.registerFactory(() => ThemeCubit());


  if (sl.isRegistered<CartCubit>()) {
    sl.unregister<CartCubit>();
  }
  sl.registerFactory(() => CartCubit(repository:sl()));

  if (sl.isRegistered<SettingsCubit>()) {
    sl.unregister<SettingsCubit>();
  }
  sl.registerFactory(() => SettingsCubit(repository:sl()));


  if (sl.isRegistered<OrderCubit>()) {
    sl.unregister<OrderCubit>();
  }
  sl.registerFactory(() => OrderCubit(repository:sl()));

  if (sl.isRegistered<SplashCubit>()) {
    sl.unregister<SplashCubit>();
  }
  sl.registerFactory(() => SplashCubit(repository:sl()));

  if (sl.isRegistered<SocketCubit>()) {
    sl.unregister<SocketCubit>();
  }
  sl.registerFactory(() => SocketCubit());




}
