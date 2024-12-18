import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/order/cubit/order_cubit.dart';

import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/utils.dart';
import '../../home/cubit/order_status_cubit.dart';

class CancelOrderWidget extends StatelessWidget {
  const CancelOrderWidget({super.key,required this.orderId,this.cancelOnTrack = false});
  final int orderId ;
  final bool cancelOnTrack ;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<OrderCubit,OrderState>(
      listener: (BuildContext context, state) {
        if(state is CancelOrder){
          // OrderCubit.get(context).order.remove(OrderCubit.get(context).order.firstWhere((element) => element.id == orderId));
          Utils.showSnackBar(state.message,context);
          OrderCubit.get(context).order.forEach((element) {
            if(element.id == orderId){
              element.orderStatus = 'Cancelled';
            }
          });
          sl<NavigationService>().popup();
          if(cancelOnTrack){
            OrderStatusCubit.get(context).orderStatusEnum = OrderStatus.orderDelivered;
            OrderStatusCubit.orderStatus = '' ;
            OrderStatusCubit.get(context).resetValuesHome();
            sl<NavigationService>().popup();
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(
                  StringsManager.cancel.tr(),
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
                StringsManager.areYouSureToCancel.tr(),
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
                 state is OrderLoadingCancel ? const LoadingIndicatorWidget() : Expanded(
                    child: MainButton(
                      onPressed: () async {
                       await OrderCubit.get(context).cancelOrder(orderId: orderId);

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
      },
    );
  }
}
