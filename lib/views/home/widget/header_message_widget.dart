import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/home/cubit/home_cubit.dart';

import '../../../shared/resources/utils.dart';

class HeaderMessageWidget extends StatelessWidget {
  const HeaderMessageWidget({super.key,required this.guest});
  final bool guest ;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400
          ),
          text:guest ? '' : '${StringsManager.hey.tr()} ${HomeCubit.get(context).getProfileResponse?.fullName?.split(' ').first ?? ''} ',
          children: [
            TextSpan(
                text: Utils.getTimeGreetings(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600
                )
            ),
          ]),
    ) ;
  }
}

