import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    cardTheme:
    const CardTheme(color: Colors.white, surfaceTintColor: Colors.white),
    scaffoldBackgroundColor: ColorsManager.backgroundColor,
    primaryColor: ColorsManager.primaryColor,
    canvasColor: ColorsManager.blackColor,
    disabledColor: ColorsManager.greyTextColor,
    fontFamily: "Inter",
    appBarTheme:
    const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.primaryColor),
        bodySmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: ColorsManager.blackColor,
        ),
        titleMedium: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.whiteColor),
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            color: ColorsManager.blackColor2.withOpacity(0.6)),
        displayLarge: TextStyle(
            color: ColorsManager.greyText,
            fontWeight: FontWeight.w400,
            fontSize: 10.sp
        ),
        displaySmall: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.greyTextScreen
        ),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: ColorsManager.greyTextScreen2
        ),





        labelSmall: TextStyle(
            color: ColorsManager.labelSmall,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp
        ),
        headlineLarge: TextStyle(
            color: ColorsManager.headlineLarge,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp
        ),
        headlineSmall: TextStyle(
            color: ColorsManager.headlineSmall,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp
        ),
        headlineMedium: TextStyle(
            color: ColorsManager.whiteColorText,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp
        ),
        labelLarge: TextStyle(
            color: ColorsManager.labelLargeColor,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp
        ),
        labelMedium: TextStyle(
            color: ColorsManager.labelMediumColor,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp
        ),
        titleLarge: TextStyle(
            color: ColorsManager.blackText,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400
        )
    ),
    buttonTheme: const ButtonThemeData(disabledColor: ColorsManager.greyColor),
  );

  // use dark mode by default
  static ThemeData darkTheme = ThemeData(
    // useMaterial3: false,
    // cardTheme:
    // const CardTheme(color: Colors.white, surfaceTintColor: Colors.white),
    // scaffoldBackgroundColor: Colors.white,
    // primaryColor: ColorsManager.primaryColor,
    // fontFamily: "Roboto",
    // appBarTheme:
    // const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
    // textTheme: TextTheme(
    //     bodyLarge: TextStyle(
    //         fontSize: 16.sp,
    //         fontWeight: FontWeight.w400,
    //         color: ColorsManager.hintColor),
    //     bodySmall: TextStyle(
    //         fontSize: 14.sp,
    //         fontWeight: FontWeight.w600,
    //         color: ColorsManager.greyTextColor,
    //     ),
    //     titleMedium: TextStyle(
    //         fontSize: 20.sp,
    //         fontWeight: FontWeight.w600,
    //         color: ColorsManager.whiteColor),
    //     bodyMedium: TextStyle(
    //         fontWeight: FontWeight.w400,
    //         fontSize: 18.sp,
    //         color: ColorsManager.blackColor),
    //   displayLarge: TextStyle(
    //     color: ColorsManager.blue,
    //     fontWeight: FontWeight.w500,
    //     fontSize: 16.sp
    //   ),
    //   displaySmall: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.w400,
    //     color: ColorsManager.disPlaySmall
    //   ),
    //   displayMedium: TextStyle(
    //     fontWeight: FontWeight.w600,
    //     fontSize: 14.sp,
    //     color: ColorsManager.disPlayMedieum
    //   ),
    //   labelSmall: TextStyle(
    //     color: ColorsManager.labelSmall,
    //     fontWeight: FontWeight.w400,
    //     fontSize: 14.sp
    //   ),
    //   headlineLarge: TextStyle(
    //     color: ColorsManager.headlineLarge,
    //     fontWeight: FontWeight.w400,
    //     fontSize: 12.sp
    //   ),
    //   headlineSmall: TextStyle(
    //       color: ColorsManager.headlineSmall,
    //       fontWeight: FontWeight.w400,
    //       fontSize: 12.sp
    //   ),
    //   headlineMedium: TextStyle(
    //       color: ColorsManager.whiteColorText,
    //       fontWeight: FontWeight.w700,
    //       fontSize: 16.sp
    //   ),
    //   labelLarge: TextStyle(
    //       color: ColorsManager.labelLargeColor,
    //       fontWeight: FontWeight.w400,
    //       fontSize: 12.sp
    //   ),
    //   labelMedium: TextStyle(
    //       color: ColorsManager.labelMediumColor,
    //       fontWeight: FontWeight.w500,
    //       fontSize: 14.sp
    //   ),
    //   titleLarge: TextStyle(
    //     color: ColorsManager.blackText,
    //     fontSize: 14.sp,
    //      fontWeight: FontWeight.w400
    //   )
    // ),
    // buttonTheme: const ButtonThemeData(disabledColor: ColorsManager.greyColor),
  );
}
