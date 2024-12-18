

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/prefs_helper.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/home/cubit/order_status_cubit.dart';
import 'package:ibnelbarh/views/order/cubit/order_cubit.dart';
import 'package:ibnelbarh/views/order/widget/order_empty_widget.dart';
import 'package:ibnelbarh/views/order/widget/order_item_widget.dart';

import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/utils.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<OrderCubit,OrderState>(
      listener: (BuildContext context, state) {
        if(state is ReOrder){
          Utils.showSnackBar(StringsManager.addedToCart.tr(), context);
          if(!mounted){
            return ;
          }
          sl<NavigationService>().navigateReplacementTo(RoutesManager.baseScreen);

          // BaseScreenNavigationCubit.get(context).reset();
          // sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
          // BlocProvider.of<BaseScreenNavigationCubit>(
          //     context)
          //     .getNavBarItem(
          //     HomeNavigationBarTabs.home);
        }else if (state is OrderError){
          Utils.showSnackBar(state.message,context);
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ArrowBack(
                    title: StringsManager.orders.tr(),
                    onPressed: (){
                      sl<NavigationService>().popup();
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //
                  //     GestureDetector(
                  //         onTap: (){
                  //           sl<NavigationService>().popup();
                  //         },
                  //         child: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: Theme.of(context).canvasColor,
                  //           size: 24.sp,
                  //         )
                  //     ),
                  //     Text(
                  //         StringsManager.orders,
                  //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 16.sp
                  //         )
                  //     ),
                  //     GestureDetector(
                  //         onTap: (){
                  //           sl<NavigationService>().popup();
                  //         },
                  //         child: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: Colors.transparent,
                  //           size: 24.sp,
                  //         )
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // Container(
                  //   color: Colors.transparent,
                  //   child: TabBar(
                  //     labelColor: ColorsManager.primaryColor,
                  //     indicatorColor: ColorsManager.primaryColor,
                  //     unselectedLabelColor: ColorsManager.greyText.withOpacity(0.5),
                  //     dividerColor: ColorsManager.greyText.withOpacity(0.5),
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     onTap: (index){
                  //       if(index == 0){
                  //         if(sl<PrefsHelper>().getSession2().isEmpty && sl<PrefsHelper>().getToken2().isEmpty){
                  //
                  //         }else {
                  //           OrderCubit.get(context).getOrder(orderStatus: 'Pending');
                  //         }
                  //       }else{
                  //         if(sl<PrefsHelper>().getSession2().isEmpty && sl<PrefsHelper>().getToken2().isEmpty){
                  //
                  //         }else {
                  //           OrderCubit.get(context).getOrder(orderStatus: 'Confirmed,Cancelled');
                  //         }
                  //
                  //       }
                  //     },
                  //     unselectedLabelStyle: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 14.sp
                  //     ),
                  //     labelStyle: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 14.sp
                  //     ),
                  //     tabs: [
                  //       Padding(
                  //         padding:  REdgeInsets.only(
                  //           top: 19,
                  //           bottom: 16
                  //         ),
                  //         child: Text(StringsManager.upcoming),
                  //       ),
                  //       Padding(
                  //         padding:  REdgeInsets.only(
                  //             top: 19,
                  //             bottom: 16
                  //         ),
                  //         child: Text(StringsManager.history),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 16.h,
                  ),
                  sl<PrefsHelper>().getSession2().isEmpty && sl<PrefsHelper>().getToken2().isEmpty ? const OrderEmptyWidget():
                  state is OrderLoading ?  const Center(child: LoadingIndicatorWidget()) :(state is OrderSuccess || state is CancelOrder) && OrderCubit.get(context).order.isEmpty ? const OrderEmptyWidget() :state is OrderSuccess || state is CancelOrder || state is ReOrder ?
                  BlocConsumer<OrderStatusCubit,OrderStatusState>(
                    listener: (BuildContext context, stateDelivery) {
                      if(stateDelivery is OrderStatusUpdatedDeliverd){
                        OrderCubit.get(context).order[0].orderStatus = 'Completed';
                      }
                    },
                    builder: (BuildContext context, Object? state) {
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context,index){
                            return  SizedBox(
                              height: 12.h,
                            );
                          },
                          itemBuilder:(context,index){
                            return InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                if(OrderCubit.get(context).order[index].orderStatus == 'Pending'){
                                  sl<NavigationService>().navigateTo(RoutesManager.orderStatusScreen);
                                }
                              },
                              child: OrderItemWidget(
                                order: OrderCubit.get(context).order[index],
                              ),
                            );
                          },
                          itemCount:  OrderCubit.get(context).order.length,
                        ),
                      );
                    },
                  ):const SizedBox(),
                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if(sl<PrefsHelper>().getSession2().isEmpty && sl<PrefsHelper>().getToken2().isEmpty){

    }else {
      OrderCubit.get(context).getOrder(orderStatus: 'Cancelled,Confirmed');
    }

  }
}
