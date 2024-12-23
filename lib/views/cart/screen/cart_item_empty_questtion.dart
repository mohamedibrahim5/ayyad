import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/model/requests/add_cart_item_request.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/constant.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';

import '../../../model/responses/get_home_response.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';


class CartItemEmptyQuesttion extends StatefulWidget {
  const CartItemEmptyQuesttion({super.key,required this.cartItem,required this.indexOfItem});
  final CartItemModel cartItem ;
  final int indexOfItem ;

  @override
  State<CartItemEmptyQuesttion> createState() => _CartItemEmptyQuesttionState();
}

class _CartItemEmptyQuesttionState extends State<CartItemEmptyQuesttion> {
  int countNumber = 1 ;
  List<int> itemsExtraClick = [] ;
  List<int> itemsExtraOptional = [] ;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CartCubit.get(context).requiredQuestions.clear() ;
    CartCubit.get(context).totalPrice = widget.cartItem.price is! String ? widget.cartItem.price : double.parse(widget.cartItem.price ?? 0)  ;
    CartCubit.get(context).totalPrice = 0 ;
    widget.cartItem.questions?.forEach((element) {
      element.extras?.forEach((element) {
        element.isSelectedCHECK = false;
        element.isSelectedOPTIONAL = false;
      });
    });
    widget.cartItem.questions?.forEach((element) {
      if(element.isRequired!){
        CartCubit.get(context).requiredQuestions.add(element) ;
      }
    });
  }

  // a7aa7a
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is AddItemSuccess){
          Utils.showSnackBar(StringsManager.addedToCart.tr(), context);
          // Utils.showSnackBar(StringsManager.addedToCart);
          // if(cartItem.isAddedToCart ?? true){
          //   cartItem.isAddedToCart = false;
          // }else {
          //   cartItem.isAddedToCart = true;
          // }


          // cartItem.isAddedToCart = !cartItem.isAddedToCart;
          //  CartCubit.get(context).changeItemCart(indexOfItem);
          sl<NavigationService>().popup() ;
        }
        if(state is AddItemErrorState){
          Utils.showSnackBar(state.message, context);
        }
      },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ImageCard(imageUrl:widget.cartItem.image!,height: 200.h,width: double.infinity,boxFit: BoxFit.fill,radius: 8,),
                            Positioned(
                              left: 16,
                              top: 16,
                              child: InkWell (
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){
                                    sl<NavigationService>().popup() ;
                                  },
                                  child: Padding(
                                    padding:  REdgeInsets.only(
                                      right: 16,
                                    ),
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          color: ColorsManager.blackColor.withOpacity(0.5),
                                          shape: BoxShape.circle
                                      ),
                                      child: SvgPicture.asset(
                                        AssetsManager.close,
                                        height: 24.sp,
                                        width: 24.sp,
                                        colorFilter: const ColorFilter.mode(ColorsManager.whiteColor, BlendMode.srcIn),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:  REdgeInsets.symmetric(
                              horizontal: 16
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 14.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.cartItem.title ?? '',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if(widget.cartItem.quantity == 0)
                                    Text(
                                      StringsManager.solidOut.tr(),
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          color: ColorsManager.redScreen
                                      ),
                                    )
                                ],
                              ),
                              Padding(
                                padding:  REdgeInsets.only(
                                    top: 4,
                                    bottom: 24
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.cartItem.description ?? '',
                                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                            fontSize: 12.sp
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    sl<PrefsHelper>().getToken2().isNotEmpty ?
                                    Text(
                                      '(${widget.cartItem.point ?? "0"} ${StringsManager.points.tr()})',
                                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                      textAlign: TextAlign.start,
                                    ) : const SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Expanded(
                //   child: SingleChildScrollView(
                //     child: ListView.separated(
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemBuilder: (BuildContext context, int indexQuestion) {
                //         return Padding(
                //           padding:  REdgeInsets.symmetric(
                //               horizontal: 16
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Text(
                //                     widget.cartItem.questions?[indexQuestion].title ?? '',
                //                     style: Theme.of(context).textTheme.bodyMedium,
                //                   ),
                //
                //                   Text(
                //                     widget.cartItem.questions![indexQuestion].isRequired! ? StringsManager.required2.tr(): StringsManager.optional.tr(),
                //                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                         fontWeight: FontWeight.w500,
                //                         fontSize: 12.sp,
                //                         color: ColorsManager.redScreen
                //                     ),
                //                   )
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 24.h,
                //               ),
                //               ListView.separated(
                //                   shrinkWrap: true,
                //                   physics: const NeverScrollableScrollPhysics(),
                //                   itemBuilder: (context, index) {
                //                     // print('indexQuestion ${cartItem.questions?[indexQuestion].extras?[index].click}');
                //                     return  GestureDetector(
                //                         onTap: (){
                //
                //                           if(widget.cartItem.questions?[indexQuestion].click == 'RADIO'){
                //                             CartCubit.get(context).chooseItemCheck(
                //                                 widget.cartItem.questions?[indexQuestion].extras ?? []
                //                                 , index,widget.cartItem.questions![indexQuestion]);
                //                           }else {
                //                             CartCubit.get(context).chooseItemOptional(
                //                                 widget.cartItem.questions?[indexQuestion].extras ?? []
                //                                 , index,widget.cartItem.questions![indexQuestion]);
                //                           }
                //                           print('requiredQuestions ${CartCubit.get(context).requiredQuestions.length}');
                //
                //                         },
                //                         child:
                //                         // chooseCartItem[index]
                //                         ChooseCartItem(
                //                           extras: widget.cartItem.questions?[indexQuestion].extras?[index] ?? Extras(),
                //                           questions: widget.cartItem.questions?[indexQuestion] ?? Questions(),
                //                         )
                //                     );
                //                   },
                //                   separatorBuilder: (context, index) {
                //                     return dividerWidget(
                //                         bottom: 16,top: 16
                //                     );
                //                   },
                //                   itemCount: widget.cartItem.questions?[indexQuestion].extras?.length ?? 0
                //               ),
                //
                //             ],
                //           ),
                //         ) ;
                //       },
                //       itemCount: widget.cartItem.questions?.length ?? 0,
                //       separatorBuilder: (BuildContext context, int index) {
                //         return SizedBox(
                //             height: 16.h
                //         );
                //       },
                //     ),
                //   ),
                // ),


                Padding(
                  padding:  REdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Padding(
                            padding:  REdgeInsets.symmetric(
                                horizontal: 10
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){
                                    if(countNumber != 1){
                                      setState(() {
                                        countNumber -- ;
                                      });
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
                                      child: Center(child: SvgPicture.asset(AssetsManager.minus,matchTextDirection: true,colorFilter:ColorFilter.mode(
                                          countNumber == 1 ? const Color(0xffB3B3B3) :  ColorsManager.primaryColor, BlendMode.srcIn
                                      )))),
                                ),
                                Text(
                                  countNumber.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp
                                  ),
                                ),
                                InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: (){
                                      if(widget.cartItem.quantity == 0){
                                        Utils.showSnackBar(StringsManager.itemEmpty.tr(), context);
                                        return ;
                                      }
                                      if(countNumber < widget.cartItem.quantity!){
                                        setState(() {
                                          countNumber ++ ;
                                        });
                                      }else {
                                        Utils.showSnackBar('${StringsManager.noMore.tr()}${widget.cartItem.quantity!} ${StringsManager.items.tr()}',context);
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
                                        child: Center(child: SvgPicture.asset(AssetsManager.plus,matchTextDirection: true,colorFilter:const ColorFilter.mode(
                                            ColorsManager.primaryColor, BlendMode.srcIn
                                        ))))),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      state is AddItemLoadingState ? const Center(child: LoadingIndicatorWidget(isCircular: true,)) :    MainButton(
                        color: widget.cartItem.quantity == 0 || CartCubit.get(context).requiredQuestions.isNotEmpty ? ColorsManager.greyText4 : Theme.of(context).primaryColor,
                        title:
                        // cartItem.isAddedToCart! ? StringsManager.removeFromCart :
                        StringsManager.addToCart.tr(),
                        onPressed:(){

                          if(widget.cartItem.quantity == 0){
                            Utils.showSnackBar(StringsManager.itemEmpty.tr(), context);
                            return ;
                          }else if (CartCubit.get(context).requiredQuestions.isNotEmpty){
                            Utils.showSnackBar(StringsManager.required2.tr(), context);
                            return ;
                          }
                          itemsExtraClick.clear() ;
                          itemsExtraOptional.clear() ;
                          CartCubit.get(context).itemsTotalId.clear() ;
                          widget.cartItem.questions?.forEach((element) {
                            if(element.click == 'RADIO'){
                              element.extras?.forEach((element) {
                                if(element.isSelectedCHECK!){
                                  itemsExtraClick.add(element.id!);
                                  CartCubit.get(context).itemsTotalId.add(element.id!);
                                }
                              });
                            }else {
                              element.extras?.forEach((element) {
                                if(element.isSelectedOPTIONAL!){
                                  itemsExtraOptional.add(element.id!);
                                  CartCubit.get(context).itemsTotalId.add(element.id!);
                                }
                              });
                            }

                          });
                          // if(cartItem.isAddedToCart!){
                          //   CartCubit.get(context).deleteItemFromCart(productId: cartItem.id!);
                          // }else {

                          CartCubit.get(context).addItemToCart(addCartItemRequest: AddCartItemRequest(
                              productId:  widget.cartItem.id!,
                              quantity:   countNumber,
                              extrasaIds:CartCubit.get(context).itemsTotalId
                            // cartItem.questions?.map((e) => e.extras?.firstWhere((element) => element.isSelected!).id).toList() ?? []
                          ));




                          //    }
                        } ,
                        title2:  ' ${double.parse(widget.cartItem.price) * countNumber} ${StringsManager.priceOfProduct.tr()} ',
                        isOneTitle: false,
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ) ;
      },
    ) ;
  }
}
