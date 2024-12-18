import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ibnelbarh/shared/resources/prefs_helper.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constant.dart';
import 'navigation_service.dart';

class DioHelper {
  Dio init() {
    final dio = Dio(BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        receiveTimeout: const Duration(seconds: 1 * 30),
        validateStatus: (state) {
          if (state == 401) {
            Utils.showErrorToast(StringsManager.unAuthorizedUserMessage.tr());
            sl<PrefsHelper>().setData(key: Constants.guestCheck, value: true);
            _logout();
            return false;
          }
          else if (state == 500){
            _handleError();
            return false;
          }
          return state! < 500;
        }));
    dio.interceptors.add(PrettyDioLogger(
        requestBody: true, requestHeader: true, responseHeader: true));
    return dio;
  }

   addHeaders() async {
     final token =  sl<PrefsHelper>().getToken2();
     final session =  sl<PrefsHelper>().getSession2();


     if(token.isNotEmpty){
       sl<Dio>().options.headers['Authorization'] = 'Bearer $token' ;
     }
      if(session.isNotEmpty && token.isEmpty){
        sl<Dio>().options.headers['Authorization'] = session ;
      }

      sl<Dio>().options.headers['organization'] = sl<PrefsHelper>().getOrganizationId();

    // await sl<PrefsHelper>().getToken().then((value) {
    //
    //   if (value.isEmpty) return;
    //
    //     // Constants.acceptLang: lang,
    //
    // });


  }



  void removeHeader() {
    sl<Dio>().options.headers = {};
    sl<Dio>().options.headers['organization'] = sl<PrefsHelper>().getOrganizationId();
  }


  Future<void> _logout() async {
    await sl<PrefsHelper>().removeToken2();
    await sl<PrefsHelper>().removeSession2() ;
    sl<Dio>().options.headers = {

    };
    // sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.loginScreen);
  }

  _handleError() {
    sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.serverErrorScreen);
  }

}
