import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/order/cubit/order_cubit.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/utils.dart';
import '../../base_button_bar/cubit/base_screen_navigation_cubit.dart';

class ReOrderDialog extends StatelessWidget {
  const ReOrderDialog({super.key,required this.orderId});
  final int orderId ;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<OrderCubit,OrderState>(
      listener: (BuildContext context, state) {
        if(state is ReOrder){
          sl<NavigationService>().popup();
          sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
          BaseScreenNavigationCubit.get(context).reset2();

          // BlocProvider.of<BaseScreenNavigationCubit>(
          //     context)
          //     .getNavBarItem(
          //     HomeNavigationBarTabs.cart);
        }else if (state is OrderError){
          Utils.showSnackBar(state.message,context);
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
                    StringsManager.reOrder.tr(),
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
                  StringsManager.reOrderMessage.tr(),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),


              state is OrderLoadingCancel ?  const Center(child: LoadingIndicatorWidget()) :
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
                          await OrderCubit.get(context).reOrder(orderId: orderId);

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
          ) ;
      },
    );
  }
}
