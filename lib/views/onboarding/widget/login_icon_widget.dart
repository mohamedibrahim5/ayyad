import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/constant.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';

Widget loginIconWidget({
  required BuildContext context
}){
  return GestureDetector(
    onTap: (){
      sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
      sl<PrefsHelper>().setData(key: Constants.showOnBoarding, value: false);
    },
    child: Text(
      StringsManager.skip.tr(),
      style:Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 14.sp,
      )
    ),
  );
}