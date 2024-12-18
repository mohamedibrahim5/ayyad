import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'constant.dart';
import 'service_locator.dart';

class PrefsHelper {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }
// Create storage
  final storage =  const FlutterSecureStorage();


  Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sl<SharedPreferences>().setString(key, value);
    } else if (value is int) {
      return await sl<SharedPreferences>().setInt(key, value);
    } else if (value is bool) {
      return await sl<SharedPreferences>().setBool(key, value);
    } else if (value is double) {
      return await sl<SharedPreferences>().setDouble(key, value);
    } else if (value is List<String>) {
      return await sl<SharedPreferences>().setStringList(key, value);
    } else {
      return false;
    }
  }


  // removeToken() async{
  //   await  storage.delete(key: Constants.token);
  // }
  // Future<String?> getToken() {
  //   return storage.read(key: Constants.token);
  // }

  int getOrganizationId() {
    return sl<SharedPreferences>().getInt('organizationId') ?? 0;
  }
  String getToken2(){
    return sl<SharedPreferences>().getString(Constants.token) ?? "";
  }

  setToken2(String token) async {
    await sl<SharedPreferences>().setString(Constants.token, token);
  }


  removeToken2() async{
    await  sl<SharedPreferences>().setString(Constants.token, '');
  }




  String getSession2()  {
    return sl<SharedPreferences>().getString('session') ?? '';
  }

   setSession2(String token)  async{
     await sl<SharedPreferences>().setString('session', token);
  }

  removeSession2() async{
    await  sl<SharedPreferences>().setString('session', '');
  }

  String getRideType()  {
    return sl<SharedPreferences>().getString('rideType') ?? '';
  }
  // Future<bool> setToken(String token) async {
  //   try{
  //     await storage.write(key:Constants.token, value:token);
  //   }catch(e){
  //     printFunc(printName: 'error in setToken');
  //   }
  //   return true;
  // }

  bool guestCheck() {
    return sl<SharedPreferences>().getBool(Constants.guestCheck) ?? true;
  }


  Future<bool> setRememberMe(bool rememberMeVal) async {
    return await sl<SharedPreferences>()
        .setBool(Constants.rememberMe, rememberMeVal);
  }

  Future<bool> disableOnBoarding() async {
    return await sl<SharedPreferences>()
        .setBool(Constants.showOnBoarding, false);
  }

  bool checkOnBoarding() {
    return sl<SharedPreferences>().getBool(Constants.showOnBoarding) ?? true;
  }

  bool checkRememberMe() {
    return sl<SharedPreferences>().getBool(Constants.rememberMe) ?? false;
  }

  Future<bool> setPhone(String phone) async {
    return await sl<SharedPreferences>().setString(Constants.phone, phone);
  }

  Future<bool> setPassword(String password) async {
    return await sl<SharedPreferences>()
        .setString(Constants.password, password);
  }

  String getPhone() {
    return sl<SharedPreferences>().getString(Constants.phone) ?? "";
  }

  String getPassword() {
    return sl<SharedPreferences>().getString(Constants.password) ?? "";
  }

  bool getLockApp() {
    return sl<SharedPreferences>().getBool(Constants.lockApp) ?? false;
  }

   setLockApp(bool lockApp) async {
     await sl<SharedPreferences>().setBool(Constants.lockApp, lockApp);
  }

  String getPasswordLockApp() {
    return sl<SharedPreferences>().getString(Constants.passwordLockApp) ?? '';
  }

   setPasswordLockApp(String lockApp) async {
     await sl<SharedPreferences>().setString(Constants.passwordLockApp, lockApp);
  }

  String getColorPreference(){
    return sl<SharedPreferences>().getString(Constants.getColorPreference) ?? StringsManager.green.tr();
  }

  setColorPreference(String colorPreference) async {
    await sl<SharedPreferences>().setString(Constants.getColorPreference, colorPreference);
  }

  String getCurrency(){
    return sl<SharedPreferences>().getString(Constants.getCurrency) ?? '';
  }

  setCurrency(String currency) async {
    await sl<SharedPreferences>().setString(Constants.getCurrency, currency);
  }

  //
  // bool addBiometrics() {
  //   return sl<SharedPreferences>().getBool(Constants.addBiometrics) ?? true;
  // }
  //
  // Future<bool> setAddBiometrics(bool addBiometrics) async {
  //   return await sl<SharedPreferences>()
  //       .setBool(Constants.addBiometrics, addBiometrics);
  // }


  Future<void> clearTokenProperties() async {
    sl<SharedPreferences>().setString(Constants.token,'');
    // await setToken('');
    // remove token from dio object stored in service locator
    sl<Dio>().options.headers['Authorization'] = '';
  }

  Future<void> logout() async {
    try {
      await clearTokenProperties();

    } catch (e) {
      rethrow;
    }
    // remove token from dio object stored in service locator
  }

  Future<bool> setRiderStartLocationPolyline(String polyline) async {
    return await sl<SharedPreferences>()
        .setString(Constants.riderStartLocationPolyline, polyline);
  }
  String getRiderStartLocationPolyline()  {
    return sl<SharedPreferences>().getString(Constants.riderStartLocationPolyline) ?? "";
  }
  removePolyline() async {
    return await sl<SharedPreferences>().remove(Constants.riderStartLocationPolyline);
  }
  Future<void> saveAppLanguage({required String locale}) async {

    await setData(key: Constants.acceptLang, value: locale);
  }

  String getAppLanguage() {

    return sl<SharedPreferences>().getString(Constants.acceptLang) ?? "en";
  }

  String getTheme(){

    String theme = sl<SharedPreferences>().getString(Constants.theme) ?? '';

    return theme;
  }

// Future<void> changeBaseUrlLanguage({required String locale}) async {
//   Constants().changeBaseUrlLanguage(locale: locale);
//
//   final dio = sl<Dio>();
//   dio.options.baseUrl = Constants.baseUrl;
//   // unregister the old MapRepository with the old base url
//   if (sl.isRegistered<Repository>()) {
//     await sl.unregister<Repository>();
//   }
//   // register the new MapRepository with the new base url depending on the language
//   sl.registerSingleton<Repository>(RepositoryImpl(
//       remoteDataSource: RemoteDataSourceImpl(dio: dio, dioHelper: sl()),
//       networkInfo: sl()));
// }
}
