import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/string_manager.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';

class ChoosePayWithWidget extends StatelessWidget {
  const ChoosePayWithWidget({super.key,required this.isCash,required this.onTapCash,required this.onTapCreditCard});
  final bool isCash  ;
  final Function()? onTapCash ;
  final Function()? onTapCreditCard ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  REdgeInsets.symmetric(
          vertical: 16
      ),
      child: Container(
        width: double.infinity,
        decoration:!ThemeCubit.get(context).isDark ?
        BoxDecoration(
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
                StringsManager.payWith.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap:onTapCash,
                child: Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      border:  Border.all(
                          width: 1.w, color:isCash ? ColorsManager.primaryColor : ColorsManager.greyTextScreen3
                      )

                  ),
                  child: Padding(
                    padding:  REdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          StringsManager.cash.tr(),
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if(isCash)
                          Container(
                            height: 12.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorsManager.primaryColor,
                                    width: 1
                                )
                            ),
                            child: Center(
                              child: Container(
                                height: 8.h,
                                width: 8.w,
                                decoration: const BoxDecoration(
                                    color: ColorsManager.primaryColor,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                          )

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onTapCreditCard,
                child: Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                      border:  Border.all(
                          width: 1.w, color:!isCash ? ColorsManager.primaryColor : ColorsManager.greyTextScreen3
                      )

                  ),
                  child: Padding(
                    padding:  REdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          StringsManager.creditCard.tr(),
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        if(!isCash)
                          Container(
                            height: 12.h,
                            width: 12.w,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorsManager.primaryColor,
                                    width: 1
                                )
                            ),
                            child: Center(
                              child: Container(
                                height: 8.h,
                                width: 8.w,
                                decoration: const BoxDecoration(
                                    color: ColorsManager.primaryColor,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ),
                          )

                      ],
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
