import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/string_manager.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({super.key,required this.totalAmount,required this.deliveryFeesPres,required this.deliveryFee,required this.servesFees});
  final double totalAmount ;
  final double deliveryFeesPres ;
  final double deliveryFee ;
  final  double servesFees ;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              StringsManager.orderSummary.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12.sp
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringsManager.subTotal.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  ' $totalAmount${StringsManager.priceOfProduct.tr()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${StringsManager.discount.tr()} (${deliveryFeesPres == 0 ? '' : '-' }$deliveryFeesPres%)',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: ColorsManager.primaryColor2
                  ),
                ),
                Text(
                  ' $deliveryFee${StringsManager.priceOfProduct.tr()}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: ColorsManager.primaryColor2
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringsManager.serviceFees.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  ' $servesFees${StringsManager.priceOfProduct.tr()}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1.h,
              color: ColorsManager.greyText4,
              margin:  REdgeInsets.only(
                  bottom: 16,top: 12
              ),
            ),
            // dividerWidget(
            //     bottom: 16,top: 12
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringsManager.total.tr(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  ' ${totalAmount - deliveryFee}${StringsManager.priceOfProduct.tr()}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}
