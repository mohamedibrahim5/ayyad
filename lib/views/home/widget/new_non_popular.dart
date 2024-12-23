import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/views/home/widget/product_empty.dart';

import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../cart/screen/cart_item_empty_questtion.dart';
import '../cubit/home_cubit.dart';

class NewNonPopular extends StatefulWidget {
  const NewNonPopular({super.key,});


  @override
  State<NewNonPopular> createState() => _NewNonPopularState();
}

class _NewNonPopularState extends State<NewNonPopular> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
            body: SafeArea(child:
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding:  REdgeInsets.symmetric(
                          horizontal: 16
                      ),
                      child: ArrowBack(
                        title: HomeCubit.get(context).categoryTitle,
                        onPressed: (){
                          // BaseScreenNavigationCubit.get(context).reset();
                          sl<NavigationService>().popup() ;
                        },
                        onPressedSearch: (){
                          sl<NavigationService>().navigateTo(RoutesManager.searchScreen);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
                HomeCubit.get(context).productNonPopular == null ? const Expanded(child: LoadingIndicatorWidget()):
                HomeCubit.get(context).productNonPopular!.isEmpty ? Expanded(
                  child: ProductEmpty(
                    title: HomeCubit.get(context).categoryTitle,
                  ),
                ) :
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return  SizedBox(
                        height: 16.h,
                      );
                    },
                    controller: scrollController,
                    itemBuilder: (context,index){
                      if (HomeCubit.get(context).productNonPopular!.length -1 == index && HomeCubit.get(context).loadingNonPopular == false && HomeCubit.get(context).productNonPopular!.length > 6) {
                        return const Center(child: LoadingIndicatorWidget(
                          isCircular: true,
                        ));
                      }
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          // cartItemModel[index].isAddedToCart = CartCubit.get(context).isAddedToCart[index];
                          if(HomeCubit.get(context).productNonPopular![index].questions!.isNotEmpty){
                            sl<NavigationService>().navigateTo(RoutesManager.cartItemScreen, arguments: {
                              Constants.cartItemHome: true,
                              Constants.cartItem: HomeCubit.get(context).productNonPopular![index],
                              Constants.indexOfItem: index
                            });
                          }else {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context){
                                  return  SizedBox(
                                    height: 0.5.sh,
                                    child: CartItemEmptyQuesttion(
                                      cartItem: HomeCubit.get(context).productNonPopular![index],
                                      indexOfItem: index,
                                    ),
                                  );
                                }
                            );
                          }

                        },
                        child: Padding(
                          padding:  REdgeInsets.symmetric(
                            horizontal: 16
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:!ThemeCubit.get(context).isDark ? ColorsManager.borderColor2: ColorsManager.bottomNavigationColorDark,
                                width: 1,
                              ),
                              color:!ThemeCubit.get(context).isDark ? ColorsManager.backgroundColor:ColorsManager.backgroundColorDarkMode,
                              borderRadius: BorderRadius.circular(18.r),
                              boxShadow: [
                                BoxShadow(
                                  color:!ThemeCubit.get(context).isDark ? ColorsManager.blackColorShadow.withOpacity(0.12):ColorsManager.blackColorShadow.withOpacity(0.12),
                                  spreadRadius: 0,
                                  blurRadius:!ThemeCubit.get(context).isDark ?  8:12,
                                  offset:!ThemeCubit.get(context).isDark ? const Offset(0, 1):const Offset(0, 6), // changes position of shadow
                                ),
                              ],
                            ),
                            child:Padding(
                              padding:  REdgeInsets.symmetric(
                                  horizontal: 16
                              ),
                              child: Padding(
                                padding:  REdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            HomeCubit.get(context).productNonPopular![index].title!,
                                            style: Theme.of(context).textTheme.bodySmall!,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            HomeCubit.get(context).productNonPopular![index].description!,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${HomeCubit.get(context).productNonPopular![index].price ?? '0'}${StringsManager.priceOfProduct.tr()}',
                                                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                  color:HomeCubit.get(context).productNonPopular![index].oldPrice == null || HomeCubit.get(context).productNonPopular![index].oldPrice?.toDouble() == 0 ? null : HomeCubit.get(context).productNonPopular![index].price!.toDouble() == HomeCubit.get(context).productNonPopular![index].oldPrice?.toDouble()  ? null : ColorsManager.primaryColor,
                                                ),
                                              ),
                                              if( HomeCubit.get(context).productNonPopular![index].oldPrice != null && HomeCubit.get(context).productNonPopular![index].oldPrice?.toDouble() != 0)
                                                if(HomeCubit.get(context).productNonPopular![index].price!.toDouble() != HomeCubit.get(context).productNonPopular![index].oldPrice?.toDouble())
                                                  Padding(
                                                    padding:  REdgeInsets.symmetric(
                                                        horizontal: 8
                                                    ),
                                                    child: Text(
                                                      '${HomeCubit.get(context).productNonPopular![index].oldPrice ?? '0'}${StringsManager.priceOfProduct.tr()}',
                                                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                        decoration: TextDecoration.lineThrough,
                                                        color: const Color(0xffA3A3A3),
                                                      ),
                                                    ),
                                                  )

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 60.w,
                                    // ),
                                    Padding(
                                      padding:  REdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: ImageCard(imageUrl: HomeCubit.get(context).productNonPopular![index].image!,height: 76.h,width: 76.w),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount:HomeCubit.get(context).productNonPopular!.length ,
                  ),
                )
              ],
            ))
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).productNonPopular = null ;
    HomeCubit.get(context).pageNonPopular = 1;
    HomeCubit.get(context).loadingNonPopular = false;
    _fetch(true);

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !HomeCubit.get(context).loadingNonPopular) {
        HomeCubit.get(context).pageNonPopular++;
        _fetch(false);
      }
    });
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _fetch(bool firstTime) async {
    await Future.delayed(const Duration(seconds: 0));
    if (!mounted) {
      return;
    }


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await HomeCubit.get(context).getNonPopularProduct(
          page: HomeCubit.get(context).pageNonPopular,
          firstTime: firstTime,
          categoryTitle: HomeCubit.get(context).categoryTitle);
    });
  }
}
