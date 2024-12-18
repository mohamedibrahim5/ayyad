import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/order/widget/re_order_dialog.dart';

import '../../../model/responses/get_order_response.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/dialog_reusable.dart';
import '../../../shared/resources/divider.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../cubit/order_cubit.dart';
import 'cancel_order_widget.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({super.key,required this.order});
  final GetOrderResponse order;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}



class _OrderItemWidgetState extends State<OrderItemWidget> {

  bool showMore = false;
  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<OrderCubit,OrderState>(
      listener: (BuildContext context, state) {

      },
      builder: (BuildContext context, Object? state) {
        return  Container(
          decoration: BoxDecoration(
            border: !ThemeCubit.get(context).isDark ? null :Border.all(
              color: ColorsManager.bottomNavigationColorDark,
              width: 1.w
            ),
              color: !ThemeCubit.get(context).isDark ? ColorsManager.backgroundColor:null,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                if(!ThemeCubit.get(context).isDark)
                  BoxShadow(
                    color: ColorsManager.blackColorShadow.withOpacity(0.12),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),

              ]
          ),
          child: Padding(
            padding:  REdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${StringsManager.order.tr()} #${widget.order.id}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                          fontWeight: FontWeight.w500
                        )),
                        SizedBox(
                          height: 4.h,
                        ),


                      ],
                    ),
                    widget.order.orderStatus != "Pending" && state is OrderLoadingCancel ? const LoadingIndicatorWidget()  :   GestureDetector(
                      onTap: (){
                        if(widget.order.orderStatus == "Pending"){
                          // add dialog her
                          showReusableDialog(
                              image: AssetsManager.deleteAccount,
                              context: context,
                              widget:  CancelOrderWidget(
                                orderId: widget.order.id ?? 1,
                              )
                          );
                        }else {
                          showReusableDialog(
                              padding:  REdgeInsets.symmetric(
                                  horizontal: 0
                              ),
                              image:AssetsManager.reOrder,

                              context: context,
                              widget:  ReOrderDialog(
                                orderId: widget.order.id ?? 1,
                              )
                          );

                        }
                      },
                      child: Text(widget.order.orderStatus == "Pending" ? StringsManager.cancel.tr() :StringsManager.reOrder.tr()  ,style: Theme.of(context).textTheme.bodyLarge!.copyWith(

                        fontSize: 10.sp
                      )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${widget.order.orderStatus} - ${widget.order.type}',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color:!ThemeCubit.get(context).isDark ? null :ColorsManager.blackColor2DarkMode
                    )),
                    Text( getFormatedDate(widget.order.createdAt) ?? '',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color:!ThemeCubit.get(context).isDark ? null :ColorsManager.blackColor2DarkMode
                    )),
                  ],
                ),

                dividerWidget(
                  bottom: 9,
                  top: 12
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          showMore = !showMore;
                        });
                      },
                      child: Row(
                        children: [
                          Text('${widget.order.items?.length} ${StringsManager.items.tr()}',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color:!ThemeCubit.get(context).isDark ? null :ColorsManager.blackColor2DarkMode
                    ).copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            color: ColorsManager.greyText3
                          )),
                          SizedBox(
                            width: 2.w,
                          ),
                          SvgPicture.asset(!showMore ? AssetsManager.arrowUp:AssetsManager.arrowDownIcon,matchTextDirection: true,colorFilter: const ColorFilter.mode(
                              ColorsManager.greyText3, BlendMode.srcIn
                          ),height:14.h ,width: 14.w,),
                        ],
                      ),
                    ),
                    Text('${StringsManager.priceOfProduct.tr()}${widget.order.totalAmount}',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color:!ThemeCubit.get(context).isDark ? null :ColorsManager.blackColor2DarkMode
                    )),

                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),

                showMore ?
                ListView.separated(
                  separatorBuilder: (context,index) => SizedBox(height:12.h ,),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        sl<NavigationService>().navigateTo(RoutesManager.cartItemOrderScreen,arguments: {
                          Constants.cartItemOrder:widget.order.items?[index],
                          Constants.indexOfItem : index
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ImageCard(
                                imageUrl:widget.order.items?[index].product?.image ,
                                width: 36.w,
                                height: 22.h,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(widget.order.items?[index].product?.title ?? '',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 10.sp,
                                  fontWeight: FontWeight.w400
                                ),overflow: TextOverflow.ellipsis,maxLines: 1,),
                              )
                            ],
                          ),
                          Text('${StringsManager.priceOfProduct.tr()}${widget.order.items?[index].price}',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color:!ThemeCubit.get(context).isDark ? null :ColorsManager.blackColor2DarkMode
                    ).copyWith(
                            fontSize: 10.sp
                          )),

                        ],
                      ),
                    ) ;
                  },
                  itemCount: widget.order.items?.length ?? 0,
                ) : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  //  OrderCubit.get(context).getOrder(orderStatus: widget.orderStatus);
  }

  getFormatedDate(date) {
    date = date.replaceAll('T', ' ');
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate).toString();
  }
}
