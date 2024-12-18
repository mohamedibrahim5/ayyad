import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/app_router.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/theme.dart';
import '../dark_mode_cubit/dark_mode_cubit.dart';
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: BlocBuilder<ThemeCubit, ThemeModeChanged>(
          builder: (context, state) {
            return MaterialApp(
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              title: "اسماك ابن البحر",
              locale: context.locale,
              navigatorKey: sl<NavigationService>().navigatorKey,
              supportedLocales: context.supportedLocales,
              onGenerateRoute: AppRouter.onGenerateRoute,
              localizationsDelegates: context.localizationDelegates,
              themeMode: state.userTheme== AppTheme.darkTheme? ThemeMode.dark:ThemeMode.light,
              debugShowCheckedModeBanner: false,
              initialRoute:RoutesManager.splashScreen,
            );
          },
        ),
      ),
    );
  }
}
