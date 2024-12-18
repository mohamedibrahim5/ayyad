import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/string_manager.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Image.asset(!ThemeCubit.get(context).isDark ? AssetsManager.searchEmpty:AssetsManager.searchEmptyDark)),
        Padding(
          padding:  REdgeInsets.only(
              top: 38,
              bottom: 8
          ),
          child: Text(StringsManager.searchEmpty.tr(),style:Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600
           )
          ),
        ),

        Text(StringsManager.searchEmpty2.tr(),style:Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w400
        )
        ),

      ],
    );
  }
}
