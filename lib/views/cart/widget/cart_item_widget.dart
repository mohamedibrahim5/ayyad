import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/model/requests/patch_cart_item_request.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';

import '../../../model/responses/get_cart_model.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';


class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key,this.delete,required this.items,this.editFunction});
  final Function()? delete;
  final Items? items;
  final Function()? editFunction;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {

  // late int countNumber ;
  late double totalPrice ;
  late int quantityNumber ;
  @override
  Widget build(BuildContext context) {
    totalPrice = double.parse(widget.items?.price ?? '0') / (widget.items?.quantity?.toDouble() ?? 1.0);
    quantityNumber = widget.items?.product!.quantity ?? 1;
    return  BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is PatchItemSuccess){
          // if(state.id == widget.items?.id){
          //   widget.items!.quantity = state.item.items?.firstWhere((element) => element.id == widget.items?.id).quantity ?? 1;
          //   CartCubit.get(context).totalPrice = state.item.totalAmount?.toDouble() ?? 1 ;
          //   totalPrice = state.item.items?.firstWhere((element) => element.id == widget.items?.id).price!.toDouble() ?? 1;
          // }

        }
      },
      builder: (BuildContext context, Object? state) {
        return InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: widget.editFunction,
          child: Container(
            // height: 99.h,
            decoration: BoxDecoration(
              border: !ThemeCubit.get(context).isDark ? null : Border.all(
                  color: ColorsManager.bottomNavigationColorDark,
                  width: 1.w),
                color:!ThemeCubit.get(context).isDark ? ColorsManager.backgroundColor:Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow:  [
                  BoxShadow(
                    color: ColorsManager.blackColorShadow.withOpacity(0.12),
                    blurRadius: 8.0,
                    spreadRadius: 0,
                    offset: const Offset(0.0, 1.0),
                  )
                ]),
            child: Padding(
              padding:  REdgeInsets.symmetric(
                vertical: 9
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      Center(child: ImageCard(imageUrl:widget.items?.product?.image!,height: 64.h,width: 64.w)),
                      SizedBox(
                        width: 12.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 134.w,
                            child: Text(
                              widget.items?.product?.title ?? '',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding:  REdgeInsets.only(
                                top: 4,
                                bottom: 9
                            ),
                            child: SizedBox(
                              width: 134.w,
                              child: Text(
                                widget.items?.product?.description ?? '',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
          
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:  REdgeInsets.only(
                        right:context.locale.languageCode == 'en' ?  16 : 0,
                        left: context.locale.languageCode == 'en' ?  0 : 16
                      // right: 16
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:  REdgeInsets.only(
                            // right: 4
                              right:context.locale.languageCode == 'en' ?  4 : 0,
                              left: context.locale.languageCode == 'en' ?  0 : 4
                          ),
                          child: Text(
                            '${StringsManager.priceOfProduct.tr()}${(totalPrice * widget.items!.quantity!).toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 17.h
                        ),
                        state is AddItemLoadingState && state.id == widget.items?.id ?  Center(child: LoadingIndicatorWidget(
                          size: 30.sp,
                          isCircular: true,
                        )) :   Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                if(widget.items?.quantity == 1){
                                  widget.delete!();
                                }
                                else if(widget.items?.quantity != 1){
                                  Map<String, int> numberMap = Map.fromIterables(
                                    widget.items!.extras!.map((e) => e.id!).toList().map((num) => num.toString()), // Convert each number to a string
                                    widget.items!.extras!.map((e) => e.id!).toList().map((num) => widget.items!.quantity! - 1),                              // Keep the numbers as values
                                    // CartCubit.get(context).itemsTotalId,                              // Keep the numbers as values
                                  );
                                  CartCubit.get(context).patchCartItem(addCartItemRequest: PatchCartItemRequest(
                                      productId:  widget.items!.id!,
                                      quantity:   widget.items!.quantity! - 1,
                                      extrasaIds:widget.items?.extras?.map((e) => e.id!).toList() ?? [],
                                      quantities: numberMap
                                  ));

                                  // setState(() {
                                  //   CartCubit.get(context).totalPrice = CartCubit.get(context).totalPrice - widget.items!.extras!.first.price!.toDouble();
                                  //   CartCubit.get(context).changeState();
                                  //   countNumber -- ;
                                  // });
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: ColorsManager.borderColor2,
                                        width: 1.w
                                    ),
                                    shape: BoxShape.circle,
                                    // borderRadius: BorderRadius.circular(10.r)
                                  ),
                                  width:30.w ,
                                  height: 30.h,
                                  child: Center(child: SvgPicture.asset(widget.items?.quantity == 1 ? AssetsManager.delete :AssetsManager.minus,matchTextDirection: true,colorFilter: const ColorFilter.mode(
                                      // countNumber == 1 ? Color(0xffB3B3B3) :
                                      ColorsManager.primaryColor
                                      , BlendMode.srcIn
                                  )))),
                            ),
                            Padding(
                              padding:  REdgeInsets.symmetric(
                                horizontal: 12
                              ),
                              child: Text(
                                widget.items?.quantity.toString() ?? '',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp
                                ),
                              ),
                            ),
                            InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: (){
                                  if(widget.items!.quantity! < quantityNumber){
                                    Map<String, int> numberMap = Map.fromIterables(
                                      widget.items!.extras!.map((e) => e.id!).toList().map((num) => num.toString()), // Convert each number to a string
                                      widget.items!.extras!.map((e) => e.id!).toList().map((num) => widget.items!.quantity! + 1),                              // Keep the numbers as values
                                      // CartCubit.get(context).itemsTotalId,                              // Keep the numbers as values
                                    );
                                    print('numberMap2 $numberMap');
                                    CartCubit.get(context).patchCartItem(addCartItemRequest: PatchCartItemRequest(
                                        productId:  widget.items!.id!,
                                        quantity:   widget.items!.quantity! + 1,
                                        extrasaIds:widget.items?.extras?.map((e) => e.id!).toList() ?? [],
                                        quantities: numberMap
                                    ));
                                  }else {
                                    Utils.showSnackBar('${StringsManager.noMore.tr()}$quantityNumber ${StringsManager.items.tr()}',context);
                                  }
          
                                  // setState(() {
                                  //   CartCubit.get(context).totalPrice = CartCubit.get(context).totalPrice + widget.items!.extras!.first.price!.toDouble();
                                  //   CartCubit.get(context).changeState();
                                  //   countNumber ++ ;
                                  // });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                          color: ColorsManager.borderColor2,
                                          width: 1.w
                                      ),
                                      shape: BoxShape.circle,
                                      // borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    width:30.w ,
                                    height: 30.h,
                                    child: Center(child: SvgPicture.asset(AssetsManager.plus,matchTextDirection: true,colorFilter:const ColorFilter.mode(
                                        ColorsManager.primaryColor, BlendMode.srcIn
                                    ) ,)))),
                          ],
                        ),
                      ],
                    ),
                  ),
          
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // countNumber  = widget.items?.quantity ?? 1;
    // totalPrice = widget.items?.totalAmount?.toDouble() ?? 1;
    // print('widget.items?.quantity ${widget.items?.price}');
    // totalPrice = double.parse(widget.items?.price ?? '0') / (widget.items?.quantity?.toDouble() ?? 1.0);
    // quantityNumber = widget.items?.product!.quantity ?? 1;

    super.initState();
  }
}
