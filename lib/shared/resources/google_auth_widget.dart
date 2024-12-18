import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import 'assets_manager.dart';
import 'colors_manager.dart';

Widget googleAuthWidget({
  required Function() onPressed,
  required BuildContext context
}){
  return GestureDetector(
    onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.blue,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: ColorsManager.whiteColor,
            width: 1.w
          )
        ),
        child: Padding(
          padding:  REdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(AssetsManager.googleIcon,matchTextDirection: true),
              Text(StringsManager.continueWithGoogle.tr(),
                style:Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ) ,
              ),
              SvgPicture.asset(AssetsManager.googleIcon,colorFilter: const ColorFilter.mode(
              Colors.transparent, BlendMode.srcIn
              ),matchTextDirection: true),
            ],
          ),
        ),
      )
  );
}