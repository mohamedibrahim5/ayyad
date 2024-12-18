import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/requests/patch_cart_item_request.dart';
import '../../../model/responses/get_cart_model.dart';
import '../../../model/responses/get_extra_response.dart';
import '../../../model/responses/get_question_response.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/dialog_reusable.dart';
import '../../../shared/resources/divider.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/utils.dart';
import '../cubit/cart_cubit.dart';
import '../widget/cart_dialog_delete.dart';
import '../widget/choose_cart_item.dart';


class CartItemUpdateScreen extends StatefulWidget {
  const CartItemUpdateScreen({super.key,required this.cartItem});
  final Items cartItem;

  @override
  State<CartItemUpdateScreen> createState() => _CartItemUpdateScreenState();
}

class _CartItemUpdateScreenState extends State<CartItemUpdateScreen> {
  int countNumber = 1 ;
  List<int> itemsExtraClick = [] ;
  List<int> itemsExtraOptional = [] ;
  late int countNumberCheckUpdate ;
   List<int> itemsTotalIdUpdateCart = [] ;
   Items? cartItem2;
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    CartCubit.get(context).requiredQuestionsUpdateCart.clear() ;
    countNumber = widget.cartItem.quantity ?? 1 ;
    CartCubit.get(context).totalPriceCart = double.parse(widget.cartItem.price ?? '0') / countNumber ;
    widget.cartItem.extras?.forEach((elementItem) {
       itemsTotalIdUpdateCart.add(elementItem.id!);
      if(elementItem.click == 'RADIO') {
        widget.cartItem.product?.questions?.forEach((element) {
          element.extras?.forEach((element) {
            if(element.id == elementItem.id){
              element.isSelectedCHECK = true ;
            }
          });
        });
      }else {
        widget.cartItem.product?.questions?.forEach((element) {
          element.extras?.forEach((element) {
            if(element.id == elementItem.id){
              element.isSelectedOPTIONAL = true ;
            }
          });
        });
      }
    });
    // widget.cartItem.product!.questions?.forEach((element) {
    //   if(element.isRequired! && element.click != 'RADIO'){
    //     CartCubit.get(context).requiredQuestionsUpdateCart.add(element) ;
    //   }
    // });
    cartItem2 = widget.cartItem.copyWith() ;
    countNumberCheckUpdate = countNumber ;
  }



  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
  //   cartItem = args[Constants.cartItemUpdate];
  //
  //   countNumber = cartItem.quantity ?? 1 ;
  //   CartCubit.get(context).totalPriceCart = cartItem.price!.toDouble() / countNumber ;
  //   // CartCubit.get(context).totalPrice = widget.cartItem.totalAmount!.toDouble() / countNumber ;
  //
  //   // itemsTotalIdUpdateCart.clear() ;
  //   cartItem.extras?.forEach((elementItem) {
  //     itemsTotalIdUpdateCart.add(elementItem.id!);
  //     if(elementItem.click == 'RADIO') {
  //       cartItem.product?.questions?.forEach((element) {
  //         element.extras?.forEach((element) {
  //           if(element.id == elementItem.id){
  //             element.isSelectedCHECK = true ;
  //           }
  //         });
  //       });
  //     }else {
  //       cartItem.product?.questions?.forEach((element) {
  //         element.extras?.forEach((element) {
  //           if(element.id == elementItem.id){
  //             element.isSelectedOPTIONAL = true ;
  //           }
  //         });
  //       });
  //     }
  //   });
  //   // Create a copy of the cartItem to ensure it is passed by value
  //   // cartItem = widget.cartItem.copyWith();
  //
  //   cartItem2 = cartItem.copyWith() ;
  //   //
  //   // countNumber = widget.cartItem.quantity ?? 1 ;
  //   // print('countNumber$countNumber');
  //   //
  //   //
  //   // CartCubit.get(context).totalPrice = widget.cartItem.totalAmount!.toDouble() / countNumber ;
  //   // countNumberCheckUpdate = countNumber ;
  //
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is PatchItemSuccess){
          CartCubit.get(context).getCartModel = null ;
          CartCubit.get(context).getCart();
          Utils.showSnackBar(StringsManager.addedToCart.tr(),context);
          sl<NavigationService>().popup() ;
        }
        if(state is DeleteItemSuccess){
          CartCubit.get(context).getCartModel = null ;
          CartCubit.get(context).getCart();
          sl<NavigationService>().popup();
          // CartCubit.get(context).getCartModel!.items?.removeWhere((element) => element.id == widget.cartItem.id);
        }
      },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[

                      SliverToBoxAdapter(
                        child:    Stack(
                          children: [
                            ImageCard(imageUrl:cartItem2!.product?.image!,height: 200.h,width: double.infinity,boxFit: BoxFit.fill,radius: 8,),
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
                                    child: SvgPicture.asset(
                                      AssetsManager.arrowLeft2,
                                      height: 24.sp,
                                      width: 24.sp,
                                      colorFilter: const ColorFilter.mode(ColorsManager.whiteColor, BlendMode.srcIn),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),



                      // // a7aa7a
                      //   SliverPersistentHeader(
                      //     pinned: true,
                      //     delegate: PersistentHeader(
                      //       widget: Container(
                      //         color: ColorsManager.backgroundColor,
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Padding(
                      //               padding:  REdgeInsets.symmetric(
                      //                 horizontal: 16
                      //               ),
                      //               child: Text(
                      //                 cartItem.title ?? '',
                      //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      //                   fontWeight: FontWeight.w500,
                      //                   fontSize: 16.sp,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),


                      SliverAppBar(
                        excludeHeaderSemantics: true,
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(-20),
                            child:   Padding(
                              padding:  REdgeInsets.symmetric(
                                  horizontal: 16
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 50,
                                    child: Text(
                                      cartItem2!.product?.title ?? '',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),
                        floating: false,
                        pinned: true,
                        backgroundColor: ColorsManager.backgroundColor,

                        // title: Text(cartItem.title ?? ''),
                        // flexibleSpace: FlexibleSpaceBar(
                        //   background:
                        //   Text(
                        //     cartItem.title ?? '',
                        //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 16.sp,
                        //     ),
                        //   ),
                        // ),
                      ),


                      // SliverAppBar(
                      //   excludeHeaderSemantics: true,
                      //   bottom: PreferredSize(
                      //       preferredSize: Size.fromHeight(-10),
                      //       child:   Padding(
                      //         padding:  REdgeInsets.symmetric(
                      //             horizontal: 16
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Expanded(
                      //               child: Text(
                      //                 cartItem2!.product?.title ?? '',
                      //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      //                   fontWeight: FontWeight.w500,
                      //                   fontSize: 16.sp,
                      //                 ),
                      //               ),
                      //             ),
                      //
                      //           ],
                      //         ),
                      //       )
                      //   ),
                      //   floating: false,
                      //   pinned: true,
                      //   backgroundColor: ColorsManager.backgroundColor,
                      //
                      //   // title: Text(cartItem.title ?? ''),
                      //   // flexibleSpace: FlexibleSpaceBar(
                      //   //   background:
                      //   //   Text(
                      //   //     cartItem.title ?? '',
                      //   //     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      //   //       fontWeight: FontWeight.w500,
                      //   //       fontSize: 16.sp,
                      //   //     ),
                      //   //   ),
                      //   // ),
                      // ),

                      SliverToBoxAdapter(
                        child:  Padding(
                          padding:  REdgeInsets.symmetric(
                              horizontal: 16
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Expanded(
                              //       child: Text(
                              //         cartItem.title ?? '',
                              //         style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 16.sp
                              //         ),
                              //       ),
                              //     ),
                              //     if(cartItem.quantity == 0)
                              //       Text(
                              //         StringsManager.solidOut.tr(),
                              //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              //             fontWeight: FontWeight.w500,
                              //             fontSize: 12.sp,
                              //             color: ColorsManager.redScreen
                              //         ),
                              //       )
                              //   ],
                              // ),
                              Padding(
                                padding:  REdgeInsets.only(
                                  top: 4,
                                  bottom: 24,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        cartItem2!.product?.description ?? '',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )  ,
                      ),



                      SliverToBoxAdapter(
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              cartItem2!.product?.questions?.length ?? 0,
                                  (indexQuestion) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Question Header
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartItem2!.product?.questions?[indexQuestion].title ?? '',
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          cartItem2!.product!.questions![indexQuestion].isRequired! ? StringsManager.required2.tr(): StringsManager.optional.tr(),

                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.sp,
                                            color: ColorsManager.redScreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),

                                    // Extras Section
                                    Padding(
                                      padding: REdgeInsets.symmetric(vertical: 16),
                                      child: Column(
                                        children: List.generate(
                                           cartItem2!.product?.questions?[indexQuestion].extras?.length ?? 0,
                                              (index) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  splashColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () {
                                                    if(cartItem2!.product?.questions?[indexQuestion].click == 'RADIO'){
                                                      CartCubit.get(context).chooseItemCheck2(
                                                          cartItem2!.product?.questions?[indexQuestion].extras ?? []
                                                          , index);
                                                    }else {
                                                      CartCubit.get(context).chooseItemOptional2(
                                                          cartItem2!.product?.questions?[indexQuestion].extras ?? []
                                                          , index,cartItem2!.product!.questions![indexQuestion]);
                                                    }
                                                  },
                                                  child: ChooseCartItem(
                                                    extras: cartItem2!.product?.questions?[indexQuestion].extras?[index] ?? Extras(),
                                                    questions: cartItem2!.product?.questions?[indexQuestion] ?? Questions(),
                                                  ),
                                                ),
                                                // Add separator if not the last item
                                                if (index < (   cartItem2!.product?.questions?[indexQuestion].extras?.length ?? 0) - 1)
                                                  dividerWidget(bottom: 16, top: 16),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    // Add spacing between question sections (optional)
                                    if (indexQuestion < ( cartItem2!.product?.questions?.length ?? 0) - 1)
                                      const SizedBox(height: 16),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                    ],
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
                //                    cartItem2!.product?.questions?[indexQuestion].title ?? '',
                //                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                //                         fontWeight: FontWeight.w500,
                //                         fontSize: 14.sp
                //                     ),
                //                   ),
                //                   Text(
                //                     cartItem2!.product!.questions![indexQuestion].isRequired! ? StringsManager.required2.tr(): StringsManager.optional.tr(),
                //                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                         fontWeight: FontWeight.w500,
                //                         fontSize: 12.sp,
                //                         color: ColorsManager.redScreen
                //                     ),
                //                   )
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 8.h,
                //               ),
                //               Padding(
                //                 padding:  REdgeInsets.symmetric(
                //                   vertical: 16
                //                 ),
                //                 child: ListView.separated(
                //                     shrinkWrap: true,
                //                     physics: const NeverScrollableScrollPhysics(),
                //                     itemBuilder: (context, index) {
                //                       return  GestureDetector(
                //                           onTap: (){
                //                             // if(widget.cartItem.product!.questions?[indexQuestion].click == 'RADIO'){
                //                             //   CartCubit.get(context).chooseItemCheck(
                //                             //       widget.cartItem.product!.questions?[indexQuestion].extras ?? []
                //                             //       , index,widget.cartItem.product!.questions![indexQuestion]);
                //                             // }else {
                //                             //   CartCubit.get(context).chooseItemOptional(
                //                             //       widget.cartItem.product!.questions?[indexQuestion].extras ?? []
                //                             //       , index,widget.cartItem.product!.questions![indexQuestion]);
                //                             // }
                //                             //
                //                             //
                //                             //   CartCubit.get(context).chooseItemCheck2(
                //                             //       cartItem2!.product?.questions?[indexQuestion].extras ?? []
                //                             //       , index);
                //
                //
                //
                //                             if(cartItem2!.product?.questions?[indexQuestion].click == 'RADIO'){
                //                               CartCubit.get(context).chooseItemCheck2(
                //                                   cartItem2!.product?.questions?[indexQuestion].extras ?? []
                //                                   , index);
                //                             }else {
                //                               CartCubit.get(context).chooseItemOptional2(
                //                                   cartItem2!.product?.questions?[indexQuestion].extras ?? []
                //                                   , index,cartItem2!.product!.questions![indexQuestion]);
                //                             }
                //
                //                           },
                //                           child:
                //                           // chooseCartItem[index]
                //                           ChooseCartItem(
                //                             extras: cartItem2!.product?.questions?[indexQuestion].extras?[index] ?? Extras(),
                //                             questions: cartItem2!.product?.questions?[indexQuestion] ?? Questions(),
                //                           )
                //                       );
                //                     },
                //                     separatorBuilder: (context, index) {
                //                       return dividerWidget(
                //                           bottom: 16,top: 16
                //                       );
                //                     },
                //                     itemCount: cartItem2!.product?.questions?[indexQuestion].extras?.length ?? 0
                //                 ),
                //               ),
                //
                //             ],
                //           ),
                //         ) ;
                //       },
                //       itemCount: cartItem2!.product?.questions?.length ?? 0,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                GestureDetector(
                                  onTap: (){

                                    if(countNumber == 1){
                                      showReusableDialog(
                                          image: AssetsManager.deleteAccount,
                                          padding:  REdgeInsets.symmetric(
                                              horizontal: 0
                                          ),
                                          context: context,
                                          widget:  CartDialogDelete(
                                            cartId:cartItem2!.id ?? 0,
                                            updateCart: true,
                                          )
                                      );
                                    }
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
                                      child: Center(child: SvgPicture.asset(countNumber == 1 ? AssetsManager.delete :AssetsManager.minus,matchTextDirection: true,colorFilter:const ColorFilter.mode(
                                          // countNumber == 1 ? Color(0xffB3B3B3) :
                                          ColorsManager.primaryColor,
                                          BlendMode.srcIn
                                      )))),
                                ),
                                Text(
                                  countNumber.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.sp
                                  ),
                                ),
                                GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        if(countNumber < cartItem2!.product!.quantity!){
                                          countNumber ++ ;
                                        }else {
                                          Utils.showSnackBar('${StringsManager.noMore.tr()}${cartItem2!.product!.quantity!} ${StringsManager.items.tr()}',context);
                                        }
                                      });

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
                          ),
                        ),
                      ),
                      state is AddItemLoadingState ? const Center(child: LoadingIndicatorWidget(isCircular: true,)) :    MainButton(
                        color: CartCubit.get(context).requiredQuestionsUpdateCart.isNotEmpty ? ColorsManager.greyText4 : Theme.of(context).primaryColor,
                        title:
                        // cartItem.isAddedToCart! ? StringsManager.removeFromCart :
                        StringsManager.updateCart.tr(),
                        onPressed:(){
                           if (CartCubit.get(context).requiredQuestionsUpdateCart.isNotEmpty){
                          Utils.showSnackBar(StringsManager.required2.tr(), context);
                          return ;
                          }

                          itemsExtraClick.clear() ;
                          itemsExtraOptional.clear() ;
                          CartCubit.get(context).itemsTotalIdUpdateCart.clear() ;
                          cartItem2!.product?.questions?.forEach((element) {
                            if(element.click == 'RADIO'){
                              element.extras?.forEach((element) {
                                if(element.isSelectedCHECK!){
                                  itemsExtraClick.add(element.id!);
                                  CartCubit.get(context).itemsTotalIdUpdateCart.add(element.id!);
                                }
                              });
                            }else {
                              element.extras?.forEach((element) {
                                if(element.isSelectedOPTIONAL!){
                                  itemsExtraOptional.add(element.id!);
                                  CartCubit.get(context).itemsTotalIdUpdateCart.add(element.id!);
                                }
                              });
                            }

                          });
                           Function eq = const ListEquality().equals;
                           if((countNumberCheckUpdate != countNumber) || (eq(CartCubit.get(context).itemsTotalIdUpdateCart, itemsTotalIdUpdateCart) == false)){
                             Map<String, int> numberMap = Map.fromIterables(
                               CartCubit.get(context).itemsTotalIdUpdateCart.map((num) => num.toString()), // Convert each number to a string
                               CartCubit.get(context).itemsTotalIdUpdateCart.map((num) => countNumber),                              // Keep the numbers as values
                               // CartCubit.get(context).itemsTotalId,                              // Keep the numbers as values
                             );
                             print('numberMap$numberMap');
                             CartCubit.get(context).patchCartItem(addCartItemRequest: PatchCartItemRequest(
                                 productId:  cartItem2!.id!,
                                 quantity:   countNumber,
                                 extrasaIds:CartCubit.get(context).itemsTotalIdUpdateCart,
                                 quantities: numberMap
                               // cartItem.questions?.map((e) => e.extras?.firstWhere((element) => element.isSelected!).id).toList() ?? []
                             ));
                           }else {
                             Utils.showSnackBar(StringsManager.noChange.tr(),context);
                           }
                        } ,
                        title2: '${StringsManager.priceOfProduct.tr()} ${CartCubit.get(context).totalPriceCart * countNumber}',
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
