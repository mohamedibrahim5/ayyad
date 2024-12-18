import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

Widget instractionPassword({
  required BuildContext context
}){
  return Padding(
    padding:  REdgeInsets.only(
        top: 8,
        bottom: 16
    ),
    child: Text.rich(
        TextSpan(
            children: [
              TextSpan(text: StringsManager.must.tr(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12.sp
              )),
              TextSpan(
                  text: StringsManager.must2.tr(),
                  style: Theme.of(context).textTheme.displaySmall
              ),
              TextSpan(text: StringsManager.must3.tr(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12.sp
              )),
              TextSpan(
                  text: StringsManager.must4.tr(),
                  style: Theme.of(context).textTheme.displaySmall
              ),
              TextSpan(text: StringsManager.must5.tr(),style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 12.sp
              )),
              TextSpan(
                  text: StringsManager.must6.tr(),
                  style: Theme.of(context).textTheme.displaySmall
              ),
            ]
        )
    ),
  );
}