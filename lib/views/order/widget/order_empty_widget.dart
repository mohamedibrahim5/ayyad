import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';

class OrderEmptyWidget extends StatelessWidget {
  const OrderEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 162.h,
        ),
        Center(child: Image.asset(!ThemeCubit.get(context).isDark ?AssetsManager.orderEmpty:AssetsManager.orderEmptyDark)),
        Padding(
          padding:  REdgeInsets.only(
            top: 38,
            bottom: 8
          ),
          child: Text(StringsManager.orderEmpty.tr(),style:Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w600
           )
          ),
        ),

        // Text(StringsManager.orderEmpty2,style:Theme.of(context).textTheme.displaySmall!.copyWith(
        //     fontSize: 14.sp,
        //     fontWeight: FontWeight.w400
        // )
        // ),

      ],
    );
  }
}
