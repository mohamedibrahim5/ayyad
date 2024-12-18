import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/model/requests/add_cart_item_request.dart';
import 'package:ibnelbarh/model/responses/get_extra_response.dart';
import 'package:ibnelbarh/model/responses/get_question_response.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';

import '../../../model/responses/get_home_response.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/divider.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../widget/choose_cart_item.dart';


class CartItemScreen extends StatefulWidget {
  const CartItemScreen({super.key});

  @override
  State<CartItemScreen> createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  int countNumber = 1 ;
  late CartItemModel cartItem;
  late Map args;
  late int indexOfItem ;
  List<int> itemsExtraClick = [] ;
  List<int> itemsExtraOptional = [] ;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CartCubit.get(context).requiredQuestions.clear() ;
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    cartItem = args[Constants.cartItem];
    indexOfItem = args[Constants.indexOfItem] ?? 0;
    CartCubit.get(context).totalPrice = double.parse(cartItem.price ?? 0) ;
    CartCubit.get(context).totalPrice = 0 ;
    cartItem.questions?.forEach((element) {
      element.extras?.forEach((element) {
        element.isSelectedCHECK = false;
        element.isSelectedOPTIONAL = false;
      });
    });
    cartItem.questions?.forEach((element) {
      if(element.isRequired!){
        CartCubit.get(context).requiredQuestions.add(element) ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is AddItemSuccess){
           Utils.showSnackBar(StringsManager.addedToCart.tr(), context);
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stack(
                //   children: [
                //     ImageCard(imageUrl:cartItem.image!,height: 200.h,width: double.infinity,boxFit: BoxFit.fill,radius: 8,),
                //     Positioned(
                //       left: 16,
                //       top: 16,
                //       child: InkWell (
                //           splashColor: Colors.transparent,
                //           highlightColor: Colors.transparent,
                //           onTap: (){
                //             sl<NavigationService>().popup() ;
                //           },
                //           child: Padding(
                //             padding:  REdgeInsets.only(
                //               right: 16,
                //             ),
                //             child: SvgPicture.asset(
                //               AssetsManager.arrowLeft2,
                //               height: 24.sp,
                //               width: 24.sp,
                //               colorFilter: ColorFilter.mode(ColorsManager.whiteColor, BlendMode.srcIn),
                //             ),
                //           )
                //       ),
                //     ),
                //   ],
                // ),
                // Padding(
                //   padding:  REdgeInsets.symmetric(
                //     horizontal: 16
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       SizedBox(
                //         height: 14.h,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             cartItem.title ?? '',
                //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
                //                 fontWeight: FontWeight.w500,
                //                 fontSize: 16.sp
                //             ),
                //           ),
                //           if(cartItem.quantity == 0)
                //             Text(
                //               StringsManager.solidOut.tr(),
                //               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 12.sp,
                //                   color: ColorsManager.redScreen
                //               ),
                //             )
                //         ],
                //       ),
                //       Padding(
                //         padding:  REdgeInsets.only(
                //             top: 4,
                //             bottom: 24
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Expanded(
                //               child: Text(
                //                 cartItem.description ?? '',
                //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                     fontWeight: FontWeight.w400,
                //                     fontSize: 12.sp
                //                 ),
                //                 textAlign: TextAlign.start,
                //               ),
                //             ),
                //             sl<PrefsHelper>().getToken2().isNotEmpty ?
                //             Text(
                //               '(${cartItem.point ?? "0"} ${StringsManager.points.tr()})',
                //               style: Theme.of(context).textTheme.labelSmall!.copyWith(
                //                 fontSize: 12.sp,
                //               ),
                //               textAlign: TextAlign.start,
                //             ) : SizedBox()
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Expanded(
                //   child: SingleChildScrollView(
                //     child: ListView.separated(
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemBuilder: (BuildContext context, int indexQuestion) {
                //         return Padding(
                //           padding:  REdgeInsets.symmetric(
                //             horizontal: 16,
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Text(
                //                     cartItem.questions?[indexQuestion].title ?? '',
                //                     style: Theme.of(context).textTheme.bodySmall!.copyWith(
                //                         fontWeight: FontWeight.w500,
                //                         fontSize: 14.sp
                //                     ),
                //                   ),
                //
                //                     Text(
                //                         cartItem.questions![indexQuestion].isRequired! ? StringsManager.required2.tr(): StringsManager.optional.tr(),
                //                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                           fontWeight: FontWeight.w500,
                //                           fontSize: 12.sp,
                //                         color: ColorsManager.redScreen
                //                       ),
                //                     )
                //                 ],
                //               ),
                //               // SizedBox(
                //               //   height: 24.h,
                //               // ),
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
                //                       // print('indexQuestion ${cartItem.questions?[indexQuestion].extras?[index].click}');
                //                       return  GestureDetector(
                //                           onTap: (){
                //
                //                             if(cartItem.questions?[indexQuestion].click == 'RADIO'){
                //                               CartCubit.get(context).chooseItemCheck(
                //                                   cartItem.questions?[indexQuestion].extras ?? []
                //                                   , index,cartItem.questions![indexQuestion]);
                //                             }else {
                //                               CartCubit.get(context).chooseItemOptional(
                //                                   cartItem.questions?[indexQuestion].extras ?? []
                //                                   , index,cartItem.questions![indexQuestion]);
                //                             }
                //
                //                           },
                //                           child:
                //                           // chooseCartItem[index]
                //                           ChooseCartItem(
                //                             extras: cartItem.questions?[indexQuestion].extras?[index] ?? Extras(),
                //                             questions: cartItem.questions?[indexQuestion] ?? Questions(),
                //                           )
                //                       );
                //                     },
                //                     separatorBuilder: (context, index) {
                //                       return dividerWidget(
                //                           bottom: 16,top: 16
                //                       );
                //                     },
                //                     itemCount: cartItem.questions?[indexQuestion].extras?.length ?? 0
                //                 ),
                //               ),
                //
                //             ],
                //           ),
                //         ) ;
                //       },
                //       itemCount: cartItem.questions?.length ?? 0,
                //       separatorBuilder: (BuildContext context, int index) {
                //         return SizedBox(
                //             height: 0.h
                //         );
                //       },
                //     ),
                //   ),
                // ),

                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: <Widget>[

                      SliverToBoxAdapter(
                        child:     Stack(
                          children: [
                            ImageCard(imageUrl:cartItem.image!,height: 200.h,width: double.infinity,boxFit: BoxFit.fill,radius: 8,),
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
                                  width: MediaQuery.of(context).size.width - 100,
                                  child: Text(
                                    cartItem.title ?? '',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if(cartItem.quantity == 0)
                                  Text(
                                    StringsManager.solidOut.tr(),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        // color: ColorsManager.redScreen
                                    ),
                                  )

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
                                        cartItem.description ?? '',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    sl<PrefsHelper>().getToken2().isNotEmpty ?
                                    Text(
                                      '(${cartItem.point ?? "0"} ${StringsManager.points.tr()})',
                                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                          fontSize: 12.sp,
                                          color: ColorsManager.primaryColor
                                      ),
                                      textAlign: TextAlign.start,
                                    ) : const SizedBox()
                                  ],
                                ),
                              ),

                            ],
                          ),
                        )  ,
                      ),



                      // SliverToBoxAdapter(
                      //   child:  Padding(
                      //     padding:  REdgeInsets.symmetric(
                      //         horizontal: 16
                      //     ),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         SizedBox(
                      //           height: 14.h,
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               cartItem.title ?? '',
                      //               style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      //                   fontWeight: FontWeight.w500,
                      //                   fontSize: 16.sp
                      //               ),
                      //             ),
                      //             if(cartItem.quantity == 0)
                      //               Text(
                      //                 StringsManager.solidOut.tr(),
                      //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 12.sp,
                      //                     color: ColorsManager.redScreen
                      //                 ),
                      //               )
                      //           ],
                      //         ),
                      //         Padding(
                      //           padding:  REdgeInsets.only(
                      //               top: 4,
                      //               bottom: 24
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Expanded(
                      //                 child: Text(
                      //                   cartItem.description ?? '',
                      //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      //                       fontWeight: FontWeight.w400,
                      //                       fontSize: 12.sp
                      //                   ),
                      //                   textAlign: TextAlign.start,
                      //                 ),
                      //               ),
                      //               sl<PrefsHelper>().getToken2().isNotEmpty ?
                      //               Text(
                      //                 '(${cartItem.point ?? "0"} ${StringsManager.points.tr()})',
                      //                 style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      //                   fontSize: 12.sp,
                      //                 ),
                      //                 textAlign: TextAlign.start,
                      //               ) : SizedBox()
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),


                      SliverToBoxAdapter(
                        child: Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              cartItem.questions?.length ?? 0,
                                  (indexQuestion) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Question Header
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartItem.questions?[indexQuestion].title ?? '',
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        Text(
                                          cartItem.questions![indexQuestion].isRequired!
                                              ? StringsManager.required2.tr()
                                              : StringsManager.optional.tr(),
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
                                          cartItem.questions?[indexQuestion].extras?.length ?? 0,
                                              (index) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  splashColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  onTap: () {
                                                    if (cartItem.questions?[indexQuestion].click == 'RADIO') {
                                                      CartCubit.get(context).chooseItemCheck(
                                                        cartItem.questions?[indexQuestion].extras ?? [],
                                                        index,
                                                        cartItem.questions![indexQuestion],
                                                      );
                                                    } else {
                                                      CartCubit.get(context).chooseItemOptional(
                                                        cartItem.questions?[indexQuestion].extras ?? [],
                                                        index,
                                                        cartItem.questions![indexQuestion],
                                                      );
                                                    }
                                                  },
                                                  child: ChooseCartItem(
                                                    extras: cartItem.questions?[indexQuestion].extras?[index] ?? Extras(),
                                                    questions: cartItem.questions?[indexQuestion] ?? Questions(),
                                                  ),
                                                ),
                                                // Add separator if not the last item
                                                if (index < (cartItem.questions?[indexQuestion].extras?.length ?? 0) - 1)
                                                  dividerWidget(bottom: 16, top: 16),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    // Add spacing between question sections (optional)
                                    if (indexQuestion < (cartItem.questions?.length ?? 0) - 1)
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

                // SizedBox(
                //   height: 16.h,
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
                                      if(cartItem.quantity == 0){
                                        Utils.showSnackBar(StringsManager.itemEmpty.tr(), context);
                                        return ;
                                      }
                                      if(countNumber < cartItem.quantity!){
                                        setState(() {
                                          countNumber ++ ;
                                        });
                                      }else {
                                        Utils.showSnackBar('${StringsManager.noMore.tr()}${cartItem.quantity!} ${StringsManager.items.tr()}',context);
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
                        color: cartItem.quantity == 0 || CartCubit.get(context).requiredQuestions.isNotEmpty ? ColorsManager.greyText4 : Theme.of(context).primaryColor,
                        title:
                        // cartItem.isAddedToCart! ? StringsManager.removeFromCart :
                        StringsManager.addToCart.tr(),
                        onPressed:(){

                          if(cartItem.quantity == 0){
                            Utils.showSnackBar(StringsManager.itemEmpty.tr(), context);
                            return ;
                          }else if (CartCubit.get(context).requiredQuestions.isNotEmpty){
                            Utils.showSnackBar(StringsManager.required2.tr(), context);
                            return ;
                          }
                            itemsExtraClick.clear() ;
                            itemsExtraOptional.clear() ;
                            CartCubit.get(context).itemsTotalId.clear() ;
                            cartItem.questions?.forEach((element) {
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

                          // a7aa7aa7aa7a
                          Map<String, int> numberMap = Map.fromIterables(
                            CartCubit.get(context).itemsTotalId.map((num) => num.toString()), // Convert each number to a string
                            CartCubit.get(context).itemsTotalId.map((num) => countNumber),                              // Keep the numbers as values
                            // CartCubit.get(context).itemsTotalId,                              // Keep the numbers as values
                          );

                          print('numberMap $numberMap');

                          CartCubit.get(context).addItemToCart(addCartItemRequest: AddCartItemRequest(
                              productId:  cartItem.id!,
                              quantity:   countNumber,
                              extrasaIds:CartCubit.get(context).itemsTotalId,
                              quantities: numberMap
                            // quantities: CartCubit.get(context).itemsTotalId.toString().isNotEmpty ? null :
                            // numberMap

                            // cartItem.questions!.map((e) => e.extras!.firstWhere((element) => element.isSelectedCHECK!).id).toList().asMap()
                            // cartItem.questions?.map((e) => e.extras?.firstWhere((element) => element.isSelected!).id).toList() ?? []
                          ));




                      //    }
                        } ,
                      title2:cartItem.questions!.isEmpty ? '${StringsManager.priceOfProduct.tr()} ${cartItem.price}' :  '${StringsManager.priceOfProduct.tr()} ${CartCubit.get(context).totalPrice * countNumber}',
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

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: ColorsManager.backgroundColor,
      child: widget,
    );
  }

  @override
  double get maxExtent => 20.0;

  // when scroll up, the minExtent will be 0
  @override
  double get minExtent => 20.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}