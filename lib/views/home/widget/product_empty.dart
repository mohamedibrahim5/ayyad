import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';

import '../../../shared/resources/string_manager.dart';

class ProductEmpty extends StatelessWidget {
  const ProductEmpty({super.key,required this.title});
  final String title ;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Center(child: Lottie.asset(AssetsManager.emptyLottie)),
        Padding(
          padding:  REdgeInsets.only(
              top: 38,
              bottom: 8,
            right: 16,
            left: 16
          ),
          child: Text(StringsManager.productEmpty.tr(),style:Theme.of(context).textTheme.bodySmall!.copyWith(
              // fontSize: 16.sp,
              fontWeight: FontWeight.w600
          )
          ),
        ),

        Padding(
          padding:  REdgeInsets.symmetric(
            horizontal: 50
          ),
          child: Text('${StringsManager.sorryButAll.tr()}$title${StringsManager.areCurrentlySoldOut.tr()}',style:Theme.of(context).textTheme.displaySmall!.copyWith(
              // fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            // color:ColorsManager.greyTextColor,
          ),
            textAlign: TextAlign.center,
          ),
        ),

      ],
    );
  }
}
