import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/views/home/widget/product_empty.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../cart/screen/cart_item_empty_questtion.dart';
import '../cubit/home_cubit.dart';

class PopularWidget extends StatefulWidget {
  const PopularWidget({super.key});
  // final HomeModel homeModel;

  @override
  State<PopularWidget> createState() => _PopularWidgetState();
}

class _PopularWidgetState extends State<PopularWidget> {
  ScrollController scrollControllerNewestProduct = ScrollController();
  ScrollController scrollControllerBestSellerProduct = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (BuildContext context, state) {  },
      buildWhen: (previous, current) {
        return current is GetProductSuccessNewestState || current is GetProductSuccessBestSellerState;
      },
      builder: (BuildContext context, Object? state) {
        return
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeCubit.get(context).productNewest != null ?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeCubit.get(context).productNewest!.isEmpty  ?  ProductEmpty(
                  title: StringsManager.products.tr(),
                ) :
                HomeCubit.get(context).productNewest!.isEmpty ? const SizedBox() :
                Padding(
                  padding:  REdgeInsets.only(
                      bottom: 8,
                      // top: 12
                  ),
                  child: Text(
                    StringsManager.topMeals.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10.sp
                    )
                  ),
                ),

                HomeCubit.get(context).productNewest!.isEmpty ? const SizedBox() :
                SizedBox(
                  height: 184.h,
                  child: ListView.separated(
                    controller: scrollControllerNewestProduct,
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context,index) {
                          if (HomeCubit.get(context).productNewest!.length -1 == index && HomeCubit.get(context).loadingNewest == false && HomeCubit.get(context).productNewest!.length > 6) {
                            return const Center(child: LoadingIndicatorWidget(
                              isCircular: true,
                            ));
                          }
                        return GestureDetector(
                          onTap: (){
                            if(HomeCubit.get(context).productNewest![index].questions!.isNotEmpty){
                              sl<NavigationService>().navigateTo(RoutesManager.cartItemScreen,arguments: {
                                Constants.cartItemHome:true,
                                Constants.cartItem:HomeCubit.get(context).productNewest![index],
                                Constants.indexOfItem : index
                              });
                            }else {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context){
                                  return  SizedBox(
                                    height: 0.5.sh,
                                    child: CartItemEmptyQuesttion(
                                      cartItem: HomeCubit.get(context).productNewest![index],
                                      indexOfItem: index,
                                    ),
                                  );
                                }
                              );
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorsManager.whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsManager.blackColorShadow.withOpacity(0.07),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ]

                            ),
                            child: Padding(
                              padding:  REdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageCard(imageUrl:HomeCubit.get(context).productNewest![index].image!,width: 128.w,height: 80.h,boxFit: BoxFit.cover,),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 95.w,
                                        child: Text(
                                          HomeCubit.get(context).productNewest![index].title!,
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),

                                          Text(
                                      "${StringsManager.priceOfProduct.tr()}${HomeCubit.get(context).productNewest![index].price!}",
                                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                              color: ColorsManager.primaryColor,
                                            ),
                                          ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  SizedBox(
                                    width: 128.w,
                                    height: 40.h,
                                    child: Text(
                                      HomeCubit.get(context).productNewest![index].description!,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color:const Color(0xffBABABA) ,
                                          overflow: TextOverflow.ellipsis
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index) => SizedBox(
                        width: 12.w,
                      ),


                      // itemBuilder: (context,index) {
                      //   if (HomeCubit.get(context).productNewest!.length -1 == index && HomeCubit.get(context).loadingNewest == false && HomeCubit.get(context).productNewest!.length > 6) {
                      //     return const Center(child: LoadingIndicatorWidget(
                      //       isCircular: true,
                      //     ));
                      //   }
                      //   return GestureDetector(
                      //     onTap: (){
                      //       sl<NavigationService>().navigateTo(RoutesManager.cartItemScreen,arguments: {
                      //         Constants.cartItemHome:true,
                      //         Constants.cartItem:HomeCubit.get(context).productNewest![index],
                      //         Constants.indexOfItem : index
                      //       });
                      //     },
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         ImageCard(imageUrl:HomeCubit.get(context).productNewest![index].image!,width: 95.w,height: 95.h,boxFit: BoxFit.cover,),
                      //         // SizedBox(
                      //         //   height: 12.h,
                      //         // ),
                      //         SizedBox(
                      //           width: 94.w,
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 HomeCubit.get(context).productNewest![index].title!,
                      //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 12.sp,
                      //                     overflow: TextOverflow.ellipsis
                      //                 ),
                      //                 maxLines: 1,
                      //                 textAlign: TextAlign.center,
                      //               ),
                      //               SizedBox(
                      //                 height: 1.h,
                      //               ),
                      //               Text(
                      //                 "${StringsManager.priceOfProduct.tr()}${HomeCubit.get(context).productNewest![index].price ?? 0}",
                      //                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      //                     fontWeight: FontWeight.w500,
                      //                     fontSize: 12.sp,
                      //                     overflow: TextOverflow.ellipsis
                      //                 ),
                      //                 maxLines: 1,
                      //                 textAlign: TextAlign.center,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      // },
                      // separatorBuilder: (context,index) => SizedBox(
                      //   width: 16.w,
                      // ),



                      itemCount:HomeCubit.get(context).productNewest?.length ?? 0
                  ),
                ),
              ],
            ):const SizedBox(),

            HomeCubit.get(context).productBestSeller != null ?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeCubit.get(context).productBestSeller!.isEmpty ? const SizedBox() :
                Padding(
                  padding:  REdgeInsets.only(
                      top:12,
                      bottom: 8
                  ),
                  child: Text(
                    StringsManager.bestSellers.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 10.sp
                    ),
                  ),
                ),

                // HomeCubit.get(context).productBestSeller!.isEmpty ? const SizedBox() :
                // SizedBox(
                //   height: 150.h,
                //   child: ListView.separated(
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context,index) {
                //         if (HomeCubit.get(context).productBestSeller!.length -1 == index && HomeCubit.get(context).loadingBestSeller == false && HomeCubit.get(context).productBestSeller!.length > 6) {
                //           return const Center(child: LoadingIndicatorWidget(
                //             isCircular: true,
                //           ));
                //         }
                //         return GestureDetector(
                //           onTap: (){
                //             sl<NavigationService>().navigateTo(RoutesManager.cartItemScreen,arguments: {
                //               Constants.cartItemHome:true,
                //               Constants.cartItem: HomeCubit.get(context).productBestSeller![index]
                //             });
                //           },
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               ImageCard(imageUrl: HomeCubit.get(context).productBestSeller![index].image!,width: 95.w,height: 95.h,boxFit: BoxFit.cover,),
                //               // Image.asset(AssetsManager.popularImage,height:113.h ,width: 89.w,matchTextDirection: true,),
                //               // SizedBox(
                //               //   height: 12.h,
                //               // ),
                //               SizedBox(
                //                 width: 94.w,
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       HomeCubit.get(context).productBestSeller![index].title!,
                //                       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                //                           fontSize: 12.sp,
                //                           fontWeight: FontWeight.w500,
                //                           overflow: TextOverflow.ellipsis
                //                       ),
                //                       maxLines: 1,
                //                     ),
                //                     SizedBox(
                //                       height: 1.h,
                //                     ),
                //                     Text(
                //                       '${StringsManager.priceOfProduct.tr()}${ HomeCubit.get(context).productBestSeller![index].price ?? 0}',
                //                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //                           fontWeight: FontWeight.w500,
                //                           fontSize: 12.sp,
                //                           overflow: TextOverflow.ellipsis
                //                       ),
                //                       maxLines: 1,
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //       separatorBuilder: (context,index) => SizedBox(
                //         width: 14.w,
                //       ),
                //       itemCount:   HomeCubit.get(context).productBestSeller?.length ?? 0
                //   ),
                // ),

                HomeCubit.get(context).productBestSeller!.isEmpty ? const SizedBox() :
                SizedBox(
                  height: 184.h,
                  child: ListView.separated(
                    controller: scrollControllerBestSellerProduct,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) {
                        if (HomeCubit.get(context).productBestSeller!.length -1 == index && HomeCubit.get(context).loadingBestSeller == false && HomeCubit.get(context).productBestSeller!.length > 6) {
                          return const Center(child: LoadingIndicatorWidget(
                            isCircular: true,
                          ));
                        }
                        return GestureDetector(
                          onTap: (){
                            if(HomeCubit.get(context).productBestSeller![index].questions!.isNotEmpty) {
                              sl<NavigationService>().navigateTo(RoutesManager.cartItemScreen,arguments: {
                                Constants.cartItemHome:true,
                                Constants.cartItem: HomeCubit.get(context).productBestSeller![index]
                              });
                            }else {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context){
                                    return  SizedBox(
                                      height: 0.5.sh,
                                      child: CartItemEmptyQuesttion(
                                        cartItem: HomeCubit.get(context).productBestSeller![index],
                                        indexOfItem: index,
                                      ),
                                    );
                                  }
                              );
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorsManager.whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsManager.blackColorShadow.withOpacity(0.07),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 1), // changes position of shadow
                                  ),
                                ]

                            ),
                            child: Padding(
                              padding:  REdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ImageCard(imageUrl:HomeCubit.get(context).productBestSeller![index].image!,width: 128.w,height: 80.h,boxFit: BoxFit.cover,),

                                  // Image.asset(AssetsManager.popularImage,height:113.h ,width: 89.w,matchTextDirection: true,),
                                  SizedBox(
                                    height: 8.h,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 95.w,
                                        child: Text(
                                          HomeCubit.get(context).productBestSeller![index].title!,
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                          maxLines: 1,
                                        ),
                                      ),
                                      Text(
                                        "${StringsManager.priceOfProduct.tr()}${HomeCubit.get(context).productBestSeller![index].price ?? 0}",
                                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                          color: ColorsManager.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  SizedBox(
                                    width: 128.w,
                                    height: 40.h,
                                    child: Text(
                                      HomeCubit.get(context).productBestSeller![index].description!,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color:const Color(0xffBABABA) ,
                                          overflow: TextOverflow.ellipsis
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index) => SizedBox(
                        width: 14.w,
                      ),
                      itemCount:  HomeCubit.get(context).productBestSeller?.length ?? 0
                  ),
                ),


              ],
            ):
            const SizedBox()

          ],
        ) ;
      },
    );
  }

  @override
  void initState() {
    HomeCubit.get(context).pageNewest = 1;
    HomeCubit.get(context).pageBestSeller = 1;
    HomeCubit.get(context).loadingBestSeller = false;
    HomeCubit.get(context).loadingNewest = false;
    // HomeCubit.get(context).getHomeData();
    super.initState();
    _fetch(true);
    _fetchBestSeller(true);

    scrollControllerNewestProduct.addListener(() {
      if (scrollControllerNewestProduct.position.pixels == scrollControllerNewestProduct.position.maxScrollExtent) {
        if(HomeCubit.get(context).loadingNewest){
          return ;
        }
        HomeCubit.get(context).pageNewest ++ ;
        _fetch(false);

      }
    });

    scrollControllerBestSellerProduct.addListener(() {
      if (scrollControllerBestSellerProduct.position.pixels == scrollControllerBestSellerProduct.position.maxScrollExtent) {
        if(HomeCubit.get(context).loadingBestSeller){
          return ;
        }
        HomeCubit.get(context).pageBestSeller ++ ;
        _fetchBestSeller(false);

      }
    });


  }


  @override
  void dispose() {
    scrollControllerNewestProduct.dispose();
    scrollControllerBestSellerProduct.dispose();
    super.dispose();
  }

  void _checkIfAllItemsAreVisible() {

    if(!mounted){

      return ;
    }
    if(HomeCubit.get(context).loadingNewest){
      return ;
    }
    if(scrollControllerNewestProduct.hasClients){
      if(scrollControllerNewestProduct.position.maxScrollExtent <= scrollControllerNewestProduct.position.viewportDimension){
        // HomeCubit.get(context).pageNewest ++ ;
        _fetch(false);
      }
    }
  }
  _fetch(firstTime) async {
    await Future.delayed(const Duration(seconds: 0));
    if(!mounted){
      return ;
    }

    await HomeCubit.get(context).getProductNewest(page: HomeCubit.get(context).pageNewest,firstTime:firstTime);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfAllItemsAreVisible();
    });
  }

  void _checkIfAllItemsAreVisibleBestSeller() {

    if(!mounted){

      return ;
    }
    if(HomeCubit.get(context).loadingBestSeller){
      return ;
    }
    if(scrollControllerBestSellerProduct.hasClients){
      if(scrollControllerBestSellerProduct.position.maxScrollExtent <= scrollControllerBestSellerProduct.position.viewportDimension){
        // HomeCubit.get(context).pageNewest ++ ;
        _fetchBestSeller(false);
      }
    }
  }
  _fetchBestSeller(firstTime) async {
    await Future.delayed(const Duration(seconds: 0));
    if(!mounted){
      return ;
    }

    await HomeCubit.get(context).getProductBestSeller(page: HomeCubit.get(context).pageBestSeller,firstTime:firstTime);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfAllItemsAreVisibleBestSeller();
    });
  }


}
