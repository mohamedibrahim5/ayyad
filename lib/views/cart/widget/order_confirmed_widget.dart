import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../home/cubit/home_cubit.dart';

class OrderConfirmedEmptyWidget extends StatefulWidget {
  const OrderConfirmedEmptyWidget({super.key});

  @override
  State<OrderConfirmedEmptyWidget> createState() => _OrderConfirmedEmptyWidgetState();
}

class _OrderConfirmedEmptyWidgetState extends State<OrderConfirmedEmptyWidget> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Lottie.asset('assets/lottie/Animation - 1719645290808.json',
                  ),),
                  Padding(
                    padding:  REdgeInsets.only(
                        top: 38,
                        bottom: 8
                    ),
                    child: Text(StringsManager.orderEmpty3.tr(),style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600
                    )
                    ),
                  ),

                  Text(StringsManager.orderEmpty4.tr(),style:Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w400
                  )
                  ),

                ],
              ),
            ),
            Padding(
              padding: REdgeInsets.only(
                  bottom: 82,
                  left: 44,
                  right: 44
              ),
              child: MainButton(
                title: StringsManager.done.tr(),
                onPressed:() async {
                  sl<NavigationService>().navigateReplacementTo(RoutesManager.orderScreen);
                } ,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getAdsAndCategory();
  }
}
