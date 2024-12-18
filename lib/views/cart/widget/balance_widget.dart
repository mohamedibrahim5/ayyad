import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../home/cubit/home_cubit.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key,required this.addBalance,required this.onChanged});
  final bool addBalance ;
  final   Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return sl<PrefsHelper>().getToken2().isNotEmpty ?
    Padding(
      padding:  REdgeInsets.only(
          top: 16
      ),
      child: Container(
        width: double.infinity,
        decoration:!ThemeCubit.get(context).isDark ? BoxDecoration(
            color: ColorsManager.backgroundColor,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.blackColorShadow.withOpacity(0.12),
                spreadRadius: 0,
                blurRadius: 8.r,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]
        ):null,
        child: Padding(
          padding:  REdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsManager.useBalance.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12.sp
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                width: double.infinity,
                height: 44.h,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border:  Border.all(
                        width: 1.w, color: ColorsManager.greyTextScreen3
                    )

                ),
                child: Padding(
                  padding:  REdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${StringsManager.used.tr()} ${HomeCubit.get(context).getProfileResponse?.points ?? ''} ${StringsManager.points.tr()} (${StringsManager.priceOfProduct.tr()}${HomeCubit.get(context).getProfileResponse?.cashback ?? ''})',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 22.0.h,
                        width: 38.w,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: CupertinoSwitch(
                            activeColor: ColorsManager.primaryColor,
                            thumbColor:!ThemeCubit.get(context).isDark ? ColorsManager.whiteColor:ColorsManager.backgroundColorDarkMode,
                            trackColor: const Color(0xffDADADA).withOpacity(0.8),
                            value: addBalance,
                            onChanged: onChanged,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    ):const SizedBox() ;
  }
}
