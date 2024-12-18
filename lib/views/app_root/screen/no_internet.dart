import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';

import '../../../shared/resources/network_info.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/utils.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  showSnackBar(String s,) {
    Utils.showSnackBar(s, context);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GestureDetector(
        onTap: ()async{
          if(await sl<NetworkInfo>().isConnected){
            sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
          }else {
            showSnackBar(StringsManager.noInternet.tr());
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Lottie.asset('assets/lottie/Animation - 1721219093848.json',width: 150.w,height: 200.h)),
            Padding(
              padding:  REdgeInsets.only(
                  top: 38,
                  bottom: 8
              ),
              child: Text(StringsManager.mustNoInternet.tr(),style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
              )
              ),
            ),

            Text(StringsManager.pressToTryAgain.tr(),style:Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
            )
            ),
          ],
        ),
      ),
    );
  }
}
