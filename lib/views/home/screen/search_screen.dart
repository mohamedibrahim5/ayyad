import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/image_card.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../cart/screen/cart_item_empty_questtion.dart';
import '../cubit/home_cubit.dart';
import '../widget/search_empty_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController ;
  late FocusNode _searchFocusNode;
   final ScrollController _scrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeState>(
      listener: (BuildContext context, state) {
      },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
            body:
            SafeArea(
              child: Padding(
                padding:  REdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: 36.h,
                      child: CustomFormField(
                        focusNode: _searchFocusNode,
                        onChanged: (value) {
                          if(value.isNotEmpty){
                            HomeCubit.get(context).productSearch = null;
                            HomeCubit.get(context).getSearchProduct(categoryTitle: HomeCubit.get(context).categoryTitle,page: HomeCubit.get(context).pageSearch,searchTitle: value,firstTime: true);
                          }else {
                            setState(() {
                              HomeCubit.get(context).productSearch = [];
                            });

                            // HomeCubit.get(context).cartItemModel = [];
                            // HomeCubit.get(context).getHomeCategoryData(categoryTitle: HomeCubit.get(context).categoryTitle,search: '');
                          }

                        },
                        addPrefix: true,
                        prefixIcon: UnconstrainedBox(
                          child: SvgPicture.asset(
                            AssetsManager.search,height:16.h ,width: 16.w,matchTextDirection: true,
                          ),
                        ),
                        hint: StringsManager.search.tr(),
                        //   label: StringsManager.phone,
                        controller: _searchController,
                        filled: true,
                        keyboard: TextInputType.name,
                        action: TextInputAction.search,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Expanded(
                      child:  HomeCubit.get(context).productSearch == null ? const LoadingIndicatorWidget():
                      HomeCubit.get(context).productSearch!.isEmpty ?
                      const SearchEmptyWidget() :
                      GridView.builder(
                      key: const PageStorageKey<String>('pageTwo'),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1.0, // Adjust the aspect ratio as needed
                      ),
                      itemBuilder: (context,index){
                        if (HomeCubit.get(context).productSearch!.length -1 == index && HomeCubit.get(context).loadingSearch == false && HomeCubit.get(context).productSearch!.length > 6) {
                          return const Center(child: LoadingIndicatorWidget(
                            isCircular: true,
                          ));
                        }
                        return GestureDetector(
                          onTap: () {
                            // widget.cartItemModel[index].isAddedToCart = CartCubit.get(context).isAddedToCart[index];
                            if(HomeCubit.get(context).productSearch![index].questions!.isNotEmpty){
                              sl<NavigationService>().navigateTo(RoutesManager.cartItemScreen, arguments: {
                                Constants.cartItemHome: true,
                                Constants.cartItem: HomeCubit.get(context).productSearch![index],
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
                                        cartItem: HomeCubit.get(context).productSearch![index],
                                        indexOfItem: index,
                                      ),
                                    );
                                  }
                              );
                            }


                          },
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
                            child: Padding(
                              padding: REdgeInsets.only(
                                //  top: widget.cartItemModel[index].quantity == 0 ? 0 : 16,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color:HomeCubit.get(context).productSearch![index].quantity != 0 ? Colors.transparent : ColorsManager.bottomNavigationColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: REdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          child: Text(
                                            StringsManager.solidOut.tr(),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color:HomeCubit.get(context).productSearch![index].quantity != 0 ? Colors.transparent : ColorsManager.greyTextScreen,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // if (widget.cartItemModel[index].quantity == 0)
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Center(
                                        child: ImageCard(
                                          imageUrl: HomeCubit.get(context).productSearch![index].image!,
                                          height: 62.h,
                                          width: 104.w,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Padding(
                                        padding: REdgeInsets.symmetric(horizontal: 22),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                HomeCubit.get(context).productSearch![index].title!,
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Text(
                                              ' ${HomeCubit.get(context).productSearch![index].price ?? 0}${StringsManager.priceOfProduct.tr()}',
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  overflow: TextOverflow.ellipsis
                                              ),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Padding(
                                      padding: REdgeInsets.symmetric(horizontal: 22),
                                      child: Text(
                                        HomeCubit.get(context).productSearch![index].description!,
                                        style: Theme.of(context).textTheme.displaySmall!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: REdgeInsets.symmetric(horizontal: 22),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children: [
                                  //       Text(
                                  //         '${StringsManager.priceOfProduct.tr()}${widget.cartItemModel[index].price!}',
                                  //         style: Theme.of(context).textTheme.displaySmall!,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 16.h,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: HomeCubit.get(context).productSearch!.length,
                      controller:_scrollController2 ,

                    ),
                    ),

                  ],
                ),
              ),
            )
        ) ;
      },
    );
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    HomeCubit.get(context).productSearch = [] ;
    // HomeCubit.get(context).categoryTitle = '';
    // HomeCubit.get(context).cartItemModelSearch = [];
    _searchFocusNode = FocusNode();
    _searchFocusNode.requestFocus();
    HomeCubit.get(context).pageSearch = 1;
    // _fetch(true);

    _scrollController2.addListener(() {
      if (_scrollController2.position.pixels == _scrollController2.position.maxScrollExtent && !HomeCubit.get(context).loadingSearch) {
        HomeCubit.get(context).pageSearch++;
        _fetch(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController2.dispose();
    super.dispose();
  }
  _fetch(bool firstTime) async {
    await Future.delayed(const Duration(seconds: 0));
    if (!mounted) {
      return;
    }


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await HomeCubit.get(context).getSearchProduct(
          searchTitle: _searchController.text,
          page: HomeCubit.get(context).pageSearch,
          firstTime: firstTime,
          categoryTitle: HomeCubit.get(context).categoryTitle);
    });
  }

}
