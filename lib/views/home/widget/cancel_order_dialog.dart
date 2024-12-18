import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/service_locator.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Text(
              StringsManager.cancelOrder.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            Padding(
              padding:  REdgeInsets.all(6.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(AssetsManager.sharkIconDialog)),
            ),

          ],
        ),
        Padding(
          padding:  REdgeInsets.only(
              right: 50,
              left: 50,
              bottom:35,
              top: 6
          ),
          child: Text(
            StringsManager.cancelOrderDesc.tr(),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        Padding(
          padding:  REdgeInsets.symmetric(
              horizontal: 24
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MainButton(

                  colorTitle: ColorsManager.primaryColor,
                  onPressed: (){
                    sl<NavigationService>().popup();
                  },
                  title: StringsManager.no.tr(),
                  color: Colors.transparent,
                  colorBorder: ColorsManager.primaryColor,
                ),
              ),
              SizedBox(
                width: 9.w,
              ),
              Expanded(
                child: MainButton(
                  onPressed: () async {
                    sl<NavigationService>().popup();
                  },
                  title: StringsManager.yes.tr(),
                  color: ColorsManager.primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 33.h,
        ),


      ],
    );
  }
}
