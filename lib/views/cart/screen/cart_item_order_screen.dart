

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/model/responses/get_extra_response.dart';
import 'package:ibnelbarh/model/responses/get_order_response.dart';
import 'package:ibnelbarh/model/responses/get_question_response.dart';

import '../../../shared/resources/constant.dart';
import '../../../shared/resources/divider.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/service_locator.dart';
import '../cubit/cart_cubit.dart';
import '../widget/choose_cart_item.dart';


class CartItemOrderScreen extends StatefulWidget {
  const CartItemOrderScreen({super.key});

  @override
  State<CartItemOrderScreen> createState() => _CartItemUpdateScreenState();
}

class _CartItemUpdateScreenState extends State<CartItemOrderScreen> {
  late Items cartItem;
  late Map args;
  late int indexOfItem ;
  List<int> itemsExtraClick = [] ;
  List<int> itemsExtraOptional = [] ;
  late int countNumberCheckUpdate ;
  List<int> itemsTotalId = [] ;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    cartItem = args[Constants.cartItemOrder];
    indexOfItem = args[Constants.indexOfItemOrder] ?? 0;

    itemsTotalId.clear() ;
    cartItem.extras?.forEach((elementItem) {
      itemsTotalId.add(elementItem.id!);
      if(elementItem.click == 'CHECK') {
        cartItem.product?.questions?.forEach((element) {
          element.extras?.forEach((element) {
            if(element.id == elementItem.id){
              element.isSelectedCHECK = true ;
            }
          });
        });
      }else {
        cartItem.product?.questions?.forEach((element) {
          element.extras?.forEach((element) {
            if(element.id == elementItem.id){
              element.isSelectedOPTIONAL = true ;
            }
          });
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {

      },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                sl<NavigationService>().popup() ;
                              },
                              child: Padding(
                                padding:  REdgeInsets.only(
                                  right:context.locale.languageCode == 'en' ?  16 : 0,
                                  left: context.locale.languageCode == 'en' ?  0 : 16
                                  // right: 16,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Theme.of(context).canvasColor,
                                  size: 24.sp,
                                ),
                              )
                          ),
                          ImageCard(imageUrl:cartItem.product?.image!,height: 76.h,width: 131.w),
                          // Image.asset(AssetsManager.sandwichImage,height: 76.h,width: 131.w,matchTextDirection: true,),
                          GestureDetector(
                              onTap: (){
                              },
                              child: Padding(
                                padding:  REdgeInsets.only(
                                  left: 16,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.transparent,
                                  size: 24.sp,
                                ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        cartItem.product?.title ?? '',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp
                        ),
                      ),
                      Padding(
                        padding:  REdgeInsets.only(
                            top: 4,
                            bottom: 24
                        ),
                        child: Text(
                          cartItem.product?.description ?? '',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int indexQuestion) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.product?.questions?[indexQuestion].title ?? '',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return  GestureDetector(
                                        onTap: (){
                                          // if(cartItem.product?.questions?[indexQuestion].click == 'CHECK'){
                                          //   CartCubit.get(context).chooseItemCheck(
                                          //       cartItem.product?.questions?[indexQuestion].extras ?? []
                                          //       , index);
                                          // }else {
                                          //   CartCubit.get(context).chooseItemOptional(
                                          //       cartItem.product?.questions?[indexQuestion].extras ?? []
                                          //       , index);
                                          // }

                                        },
                                        child:
                                        // chooseCartItem[index]
                                        ChooseCartItem(
                                          extras: cartItem.product?.questions?[indexQuestion].extras?[index] ?? Extras(),
                                          questions: cartItem.product?.questions?[indexQuestion] ?? Questions(),
                                        )
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return dividerWidget(
                                        bottom: 16,top: 16
                                    );
                                  },
                                  itemCount: cartItem.product?.questions?[indexQuestion].extras?.length ?? 0
                              ),

                            ],
                          ) ;
                        },
                        itemCount: cartItem.product?.questions?.length ?? 0,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                              height: 16.h
                          );
                        },
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ) ;
      },
    ) ;
  }
}
