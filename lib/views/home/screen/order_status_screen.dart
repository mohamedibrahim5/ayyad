import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/dialog_reusable.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/home/cubit/order_status_cubit.dart';

import '../../../shared/resources/constant.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../order/widget/cancel_order_widget.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  // late String label ;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<OrderStatusCubit,OrderStatusState>(
      listener: (BuildContext context, state) {

      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child: Column(
                children: [
                  ArrowBack(
                    title: StringsManager.orderStatus.tr(),
                    onPressed: (){
                     sl<NavigationService>().popup();
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     GestureDetector(
                  //         onTap: (){
                  //           BaseScreenNavigationCubit.get(context).reset();
                  //         },
                  //         child: Padding(
                  //           padding:  REdgeInsets.only(
                  //             right: 16,
                  //           ),
                  //           child: Icon(
                  //             Icons.arrow_back_ios,
                  //             color: Theme.of(context).canvasColor,
                  //             size: 24.sp,
                  //           ),
                  //         )
                  //     ),
                  //     Text(
                  //         StringsManager.setting,
                  //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //             fontWeight: FontWeight.w600,
                  //             fontSize: 16.sp
                  //         )
                  //     ),
                  //     GestureDetector(
                  //         onTap: (){
                  //         },
                  //         child: Padding(
                  //           padding:  REdgeInsets.only(
                  //             left: 16,
                  //           ),
                  //           child: Icon(
                  //             Icons.arrow_back_ios,
                  //             color: Colors.transparent,
                  //             size: 24.sp,
                  //           ),
                  //         )
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),
                 // 12345
                 Image.asset(AssetsManager.deliveryOrder2,height:110.h ,width: 134.w,),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.orderPlaced ? StringsManager.orderPlaced.tr() :OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.preparingOrder ?   StringsManager.preparingOrder.tr():OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.outForDelivery ? StringsManager.onTheWay.tr(): '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),

                    ],
                  ),

                  SizedBox(
                    height: 6.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        OrderStatusCubit.get(context).trackOrderModelResponse?.data?.message ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color:ThemeCubit.get(context).isDark ? null : ColorsManager.blackColor4
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FAProgressBar(
                          progressColor: ColorsManager.primaryColor,
                          backgroundColor: ColorsManager.bottombarcolor,
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          //      animatedDuration: const Duration(milliseconds: 1000),
                          size: 5,
                          currentValue: OrderStatusCubit.get(context).currentValue1,
                          // displayText: '%',
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: FAProgressBar(
                          progressColor: ColorsManager.primaryColor,
                          backgroundColor: ColorsManager.bottombarcolor,
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          //          animatedDuration: const Duration(milliseconds: 1000),
                          size: 5,
                          currentValue: OrderStatusCubit.get(context).currentValue2,
                          // displayText: '%',
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Expanded(
                        child: FAProgressBar(
                          progressColor: ColorsManager.primaryColor,
                          backgroundColor: ColorsManager.bottombarcolor,
                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                          //      animatedDuration: const Duration(milliseconds: 1000),
                          size: 5,
                          currentValue: OrderStatusCubit.get(context).currentValue3,
                          // displayText: '%',
                        ),
                      ),

                    ],
                  ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),


                  Padding(
                    padding:  REdgeInsets.symmetric(
                      vertical: 16
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          border:!ThemeCubit.get(context).isDark ? null : Border.all(color: ColorsManager.greyText4),
                          color:!ThemeCubit.get(context).isDark ? ColorsManager.whiteColor:ColorsManager.backgroundColorDarkMode,
                          borderRadius: BorderRadius.circular(10.0.r),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.blackColor.withOpacity(0.12),
                              spreadRadius: 0,
                              blurRadius: 8,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ]
                      ),
                      child: Padding(
                        padding:  REdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsManager.location,
                              height: 14.sp,
                              width: 14.sp,
                              colorFilter: ColorFilter.mode(
                                  !ThemeCubit.get(context).isDark ? ColorsManager.greyTextScreen:ColorsManager.blackColor2DarkMode, BlendMode.srcIn)
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.address!.label ?? '',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: 10.sp
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.h,
                                  ),
                                  Text(
                                    OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.address!.locationName ?? '',
                                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),





                  Container(
                    decoration: BoxDecoration(
                      border:!ThemeCubit.get(context).isDark ? null : Border.all(color: ColorsManager.greyText4),
                        color:!ThemeCubit.get(context).isDark ? ColorsManager.whiteColor:ColorsManager.backgroundColorDarkMode,
                        borderRadius: BorderRadius.circular(10.0.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.blackColor.withOpacity(0.12),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ]
                    ),
                    child: Padding(
                      padding:  REdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringsManager.orderDetails.tr(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              if(OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.orderPlaced)
                                GestureDetector(
                                  onTap: (){
                                    showReusableDialog(
                                        image: AssetsManager.cancelOrder,
                                        padding:  REdgeInsets.symmetric(
                                            horizontal: 0
                                        ),
                                        context: context,
                                        widget:  CancelOrderWidget(
                                          orderId: OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.id ?? 0,
                                          cancelOnTrack: true,
                                        )
                                    );
                                  },
                                  child: Text(
                                    StringsManager.cancel.tr(),
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),



                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/order.svg',colorFilter: ColorFilter.mode(
                                      !ThemeCubit.get(context).isDark ? ColorsManager.greyTextScreen:ColorsManager.blackColor2DarkMode, BlendMode.srcIn) ,),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    StringsManager.orderNumber.tr(),
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.id.toString(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10.sp
                                ),
                              ),



                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1.h,
                            color:!ThemeCubit.get(context).isDark ?  ColorsManager.greyText4:ColorsManager.bottomNavigationColorDark,
                            margin:  REdgeInsets.only(
                                bottom: 16,top: 12
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.items!.length ,
                                  (indexQuestion) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.items![indexQuestion].product?.title ?? '',
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color:!ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.items![indexQuestion].quantity.toString()} x',
                                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: !ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor

                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Deluxe Quarter Pounder',
                          //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          //           fontSize: 14.sp,
                          //           fontWeight: FontWeight.w500,
                          //         color:!ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                          //       ),
                          //     ),
                          //     Text(
                          //       'x2',
                          //       style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          //         fontWeight: FontWeight.w500,
                          //         fontSize: 12.sp,
                          //           color: !ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                          //
                          //       ),
                          //     ),
                          //
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 12.h,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Combo Breakfast',
                          //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          //           fontSize: 14.sp,
                          //           fontWeight: FontWeight.w500,
                          //           color: !ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                          //       ),
                          //     ),
                          //     Text(
                          //       'x1',
                          //       style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 12.sp,
                          //           color: !ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                          //
                          //       ),
                          //     ),
                          //
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 12.h,
                          // ),
                          //
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       'Combo Breakfast',
                          //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          //           fontSize: 14.sp,
                          //           fontWeight: FontWeight.w500,
                          //           color: !ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                          //       ),
                          //     ),
                          //     Text(
                          //       'x1',
                          //       style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 12.sp,
                          //           color: !ThemeCubit.get(context).isDark ?  ColorsManager.greyText2:ColorsManager.greyTextColor
                          //
                          //       ),
                          //     ),
                          //
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 12.h,
                          // ),
                          // Container(
                          //   width: double.infinity,
                          //   height: 1.h,
                          //   color:!ThemeCubit.get(context).isDark ?  ColorsManager.greyText4:ColorsManager.bottomNavigationColorDark,
                          //   margin:  REdgeInsets.only(
                          //       bottom: 16,top: 12
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 12.h,
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                StringsManager.total.tr(),
                                style:!ThemeCubit.get(context).isDark ? Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                ) : Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                ' ${OrderStatusCubit.get(context).trackOrderModelResponse!.data!.getOrderResponse!.totalAmount ?? ''}${StringsManager.priceOfProduct.tr()}  ',
                                style:!ThemeCubit.get(context).isDark ? Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ) : Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),



                            ],
                          ),



                        ],
                      ),
                    ),

                  ),



                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   if(Constants.addNewAddressRequestBox.values.isNotEmpty){
  //    label = Constants.addNewAddressRequestBox.values.last.label ?? '';
  //     Constants.addNewAddressRequestBox.values.forEach((element) {
  //       if(label == element.label) {
  //         allIndexOfChooseItem.add(true);
  //       }else {
  //         allIndexOfChooseItem.add(false);
  //       }
  //     });
  //      allIndexOfChooseItem = List.generate(Constants.addNewAddressRequestBox.length, (index) => false);
  //   }
  // }

// @override
  // void initState() {
  //   super.initState();
  //   OrderStatusCubit.get(context).resetValues();
  //   OrderStatusCubit.get(context).startUpdatingValues();
  // }
  //
  // @override
  // void dispose() {
  //   OrderStatusCubit.get(context).stopUpdatingValues();
  //   super.dispose();
  // }
}
