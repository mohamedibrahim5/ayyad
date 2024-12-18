import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/constant.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/dialog_reusable.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/prefs_helper.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/base_button_bar/cubit/base_screen_navigation_cubit.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';
import 'package:ibnelbarh/views/cart/widget/cart_dialog_delete.dart';
import 'package:ibnelbarh/views/cart/widget/cart_empty_widget.dart';
import 'package:ibnelbarh/views/cart/widget/cart_item_widget.dart';

import '../../../shared/resources/assets_manager.dart';
import 'cart_item_update_empty_question.dart';
import 'cart_item_update_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {
        if(state is PatchItemSuccess){
          CartCubit.get(context).totalPrice = double.parse(state.item.totalPrice ?? '0');
          CartCubit.get(context).getCartModel!.totalPrice = CartCubit.get(context).totalPrice.toString();
           // CartCubit.get(context).getCart();
           CartCubit.get(context).getCartModel!.items!.clear();
          CartCubit.get(context).getCartModel!.items!.addAll(state.item.items!);
        }else if (state is DeleteItemSuccess){
          // CartCubit.get(context).totalPrice =  state.addDeleteCartItemResponse.total!.toDouble();
          CartCubit.get(context).getCartModel!.items = state.addDeleteCartItemResponse.items;
          CartCubit.get(context).totalPrice = double.parse(state.addDeleteCartItemResponse.totalPrice ?? '0');

          // CartCubit.get(context).getCartModel!.totalAmount = CartCubit.get(context).totalPrice;
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child:sl<PrefsHelper>().getSession2().isEmpty && sl<PrefsHelper>().getToken2().isEmpty ? const CartEmptyWidget() :CartCubit.get(context).getCartModel != null ?
              CartCubit.get(context).getCartModel!.items!.isNotEmpty ?
              Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ArrowBack(
                          title: StringsManager.cart.tr(),
                          onPressed: (){
                            BaseScreenNavigationCubit.get(context).reset();
                            // sl<NavigationService>().popup() ;
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return  CartItemWidget(
                                  editFunction: (){
                                    if(CartCubit.get(context).getCartModel!.items![index].product!.questions!.isNotEmpty){
                                      Navigator.push(context, MaterialPageRoute(builder:(context){
                                        return CartItemUpdateScreen(
                                          cartItem: CartCubit.get(context).getCartModel!.items![index],
                                        );
                                      }));
                                    }else {

                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context){
                                            return  SizedBox(
                                              height: 0.5.sh,
                                              child: CartItemUpdateEmptyQuestionScreen(
                                                cartItem: CartCubit.get(context).getCartModel!.items![index],
                                              ),
                                            );
                                          }
                                      );
                                    }

                                    // sl<NavigationService>().navigateTo(RoutesManager.cartItemUpdateScreen,arguments: {
                                    //   Constants.cartItemUpdate:CartCubit.get(context).getCartModel?.items?[index],
                                    //   Constants.indexOfItem : index
                                    // });
                                  },
                                  items: CartCubit.get(context).getCartModel!.items![index],
                                  delete: (){
                                    showReusableDialog(
                                        image: AssetsManager.deleteAccount,
                                        padding:  REdgeInsets.symmetric(
                                            horizontal: 0
                                        ),
                                        context: context,
                                        widget:  CartDialogDelete(
                                          cartId: CartCubit.get(context).getCartModel?.items?[index].id ?? 0,
                                        )
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16.h,
                                );
                              },
                              itemCount: CartCubit.get(context).getCartModel?.items?.length ?? 0
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding:  REdgeInsets.symmetric(
                        horizontal: 24
                    ),
                    child: MainButton(
                      isOneTitle: false,
                      title2: '${StringsManager.totalPrice.tr()}: ${CartCubit.get(context).totalPrice} ${StringsManager.priceOfProduct.tr()}',
                      title: StringsManager.checkOut.tr(),
                      onPressed:(){

                        sl<NavigationService>().navigateTo(RoutesManager.checkOutScreen,arguments:{
                          Constants.cartModel:CartCubit.get(context).getCartModel,
                        });
                      } ,
                    ),
                  ),
                ],
              ) : const CartEmptyWidget(): const Center(child:  LoadingIndicatorWidget(),),
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
      CartCubit.get(context).getCartModel = null ;
      CartCubit.get(context).getCart();
      CartCubit.get(context).totalPrice = 0;
    }
  }
}
