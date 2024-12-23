import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/requests/patch_cart_item_request.dart';
import '../../../model/responses/get_cart_model.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/dialog_reusable.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/utils.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../cubit/cart_cubit.dart';
import '../widget/cart_dialog_delete.dart';


class CartItemUpdateEmptyQuestionScreen extends StatefulWidget {
  const CartItemUpdateEmptyQuestionScreen({super.key,required this.cartItem});
  final Items cartItem;

  @override
  State<CartItemUpdateEmptyQuestionScreen> createState() => _CartItemUpdateEmptyQuestionScreenState();
}

class _CartItemUpdateEmptyQuestionScreenState extends State<CartItemUpdateEmptyQuestionScreen> {
  int countNumber = 1 ;
  List<int> itemsExtraClick = [] ;
  List<int> itemsExtraOptional = [] ;
  late int countNumberCheckUpdate ;
  List<int> itemsTotalIdUpdateCart = [] ;
  Items? cartItem2;


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




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is PatchItemSuccess){
          CartCubit.get(context).getCartModel = null ;
          CartCubit.get(context).getCart();
          Utils.showSnackBar(StringsManager.addedToCart.tr(),context);
          // sl<NavigationService>().popup() ;
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
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 194.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color:!ThemeCubit.get(context).isDark ?  ColorsManager.blackColor7.withOpacity(0.91):ColorsManager.blackColor7Dark,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(25.r),
                                    bottomLeft: Radius.circular(25.r)
                                )
                            ),
                          ),
                          ImageCard(imageUrl:cartItem2!.product?.image!,height: 124.h,width: 193.w,boxFit: BoxFit.cover,),
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
                                      right:context.locale.languageCode == 'en' ?  16 : 0,
                                      left: context.locale.languageCode == 'en' ?  0 : 16
                                    // right: 16,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorsManager.blackColor.withOpacity(0.5),
                                        shape: BoxShape.circle
                                    ),
                                    child: SvgPicture.asset(
                                      AssetsManager.close,
                                      height: 24.sp,
                                      width: 24.sp,
                                      colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn),
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
                            Text(
                              cartItem2!.product?.title ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Padding(
                              padding:  REdgeInsets.only(
                                  top: 4,
                                  bottom: 24
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartItem2!.product?.description ?? '',
                                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                          fontSize: 12.sp
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  // sl<PrefsHelper>().getToken2().isNotEmpty ?
                                  // Text(
                                  //   cartItem2!.product?.point ?? '',
                                  //   style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  //       fontSize: 12.sp
                                  //   ),
                                  //   textAlign: TextAlign.start,
                                  // ) : SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),



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
                                          ColorsManager.primaryColor, BlendMode.srcIn
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
                            sl<NavigationService>().popup() ;
                            Map<String, int> numberMap = Map.fromIterables(
                              CartCubit.get(context).itemsTotalIdUpdateCart.map((num) => num.toString()), // Convert each number to a string
                              CartCubit.get(context).itemsTotalIdUpdateCart.map((num) => countNumber),                              // Keep the numbers as values
                              // CartCubit.get(context).itemsTotalId,                              // Keep the numbers as values
                            );
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
                        title2: '       ${CartCubit.get(context).totalPriceCart * countNumber} ${StringsManager.priceOfProduct.tr()} ',
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
