import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/model/requests/create_address_request.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/map_cubit.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../cart/widget/choose_address_widget.dart';
import '../../settings/cubit/settings_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/order_status_cubit.dart';
import '../widget/banner_carousel.dart';
import '../widget/categorie_item.dart';
import '../widget/header_message_widget.dart';
import '../widget/new_non_popular.dart';
import '../widget/popular_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.guest});
  final bool guest;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late TextEditingController _searchController;
  late ScrollController scrollController;
  List<bool> allIndexOfChooseItem = [];
  late ScrollController _scrollController ;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderMessageWidget(
                    guest: widget.guest,
                  ),
                  // add search her if you want
                  // HomeCubit.get(context).isChecked[0]
                  //     ? HeaderMessageWidget(
                  //   guest: widget.guest,
                  // )
                  //     : GestureDetector(
                  //   onTap: () {
                  //     sl<NavigationService>()
                  //         .navigateTo(RoutesManager.searchScreen);
                  //   },
                  //   child: SizedBox(
                  //     height: 36.h,
                  //     child: CustomFormField(
                  //       enabled: false,
                  //       addPrefix: true,
                  //       prefixIcon: UnconstrainedBox(
                  //         child: SvgPicture.asset(
                  //           AssetsManager.search,
                  //           height: 16.h,
                  //           width: 16.w,
                  //           matchTextDirection: true,
                  //         ),
                  //       ),
                  //       hint: StringsManager.search.tr(),
                  //       controller: _searchController,
                  //       filled: true,
                  //       keyboard: TextInputType.name,
                  //       action: TextInputAction.search,
                  //     ),
                  //   ),
                  // ),

                  BlocConsumer<SettingsCubit,SettingsState>(
                    listener: (BuildContext context, state) {
                      if(state is PatchAddressSuccess){
                        SettingsCubit.get(context).homeAddressModelResponse = state.createAddressModelResponse;
                        // sl<NavigationService>().popup();
                      }
                    },
                    builder: (BuildContext context, Object? state) {
                      return SettingsCubit.get(context).getAllAddressModelResponse != null?
                      SettingsCubit.get(context).getAllAddressModelResponse!.isEmpty ?
                      const SizedBox() :
                      Padding(
                        padding:  REdgeInsets.only(
                            top: 4
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsManager.location,
                              height: 14.sp,
                              width: 14.sp,
                              colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn),

                            ),
                            Text(
                              StringsManager.deliveryTo.tr(),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorsManager.greyTextScreen4
                                // color: ColorsManager.greyTextScreen4
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: (){
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.r)),
                                    ),
                                    backgroundColor:ThemeCubit.get(context).isDark ? ColorsManager.backgroundColorDarkMode :  ColorsManager.whiteColor,
                                    context: context, builder: (BuildContext context) {
                                  return  StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                    return Padding(
                                      padding:  REdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: (){
                                                    sl<NavigationService>().popup();
                                                  },
                                                  child: SvgPicture.asset(AssetsManager.close,height: 24.h,width: 24.w,
                                                    colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Text(
                                            StringsManager.chooseAddress.tr(),
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 24.h,
                                          ),
                                          state is SettingsLoadingPatchAddress ? const LoadingIndicatorWidget() :  SizedBox(
                                            height:SettingsCubit.get(context).getAllAddressModelResponse!.length > 3 ? 200.h: SettingsCubit.get(context).getAllAddressModelResponse!.length * 60.h,
                                            child: ListView.separated(
                                              itemBuilder:(context,index){

                                                return GestureDetector(
                                                  onTap: ()async{
                                                    setState(() {
                                                      SettingsCubit.get(context).patchAddress(createAddressRequest: CreateAddressRequest(
                                                          isMain: true
                                                      ), id: SettingsCubit.get(context).getAllAddressModelResponse![index].id!);

                                                      for (var element in SettingsCubit.get(context).getAllAddressModelResponse!) {
                                                        element.isMain = false;
                                                      }
                                                      SettingsCubit.get(context).getAllAddressModelResponse![index].isMain = true;
                                                    });
                                                  },
                                                  child: ChooseAddressWidget(
                                                    isHome: true,
                                                    addNewAddressRequest: SettingsCubit.get(context).getAllAddressModelResponse![index],
                                                    isSelected: SettingsCubit.get(context).getAllAddressModelResponse![index].isMain ?? false,

                                                    // isSelected: allIndexOfChooseItem[index],
                                                  ),
                                                );
                                              },itemCount: SettingsCubit.get(context).getAllAddressModelResponse!.length  ,
                                              separatorBuilder: (context,index){
                                                return SizedBox(
                                                  height: 12.h,
                                                );
                                              },),
                                          ),
                                          SizedBox(
                                            height: 40.h,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: (){
                                                    sl<NavigationService>().popup();
                                                    sl<NavigationService>().navigateTo(RoutesManager.googleMap);
                                                  },
                                                  child: Text(
                                                    StringsManager.addNewAddress.tr(),
                                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w600,
                                                        color: ColorsManager.primaryColor
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                }
                                );
                              },
                              child: Row(
                                children: [
                                  Text(SettingsCubit.get(context).homeAddressModelResponse?.label ?? '',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      // color: ColorsManager.greyTextScreen4
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  SvgPicture.asset(AssetsManager.arrowDownIcon,width: 16.w,height: 16.h,
                                    colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn)
                                    ,)


                                ],
                              ),
                            ),






                            // SizedBox(
                            //   height: 5.h,
                            // ),

                          ],
                        ),
                      ) :
                      const SizedBox();
                    },
                  ),




                  BlocConsumer<OrderStatusCubit,OrderStatusState>(
                    listener: (BuildContext context, state) {  },
                    builder: (BuildContext context, Object? state) {
                      return OrderStatusCubit.orderStatus.isEmpty ? const SizedBox() : Padding(
                        padding:  REdgeInsets.symmetric(
                            vertical: 16
                        ),
                        child: GestureDetector(
                          onTap: (){
                            sl<NavigationService>().navigateTo(RoutesManager.orderStatusScreen);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border:!ThemeCubit.get(context).isDark ? null : Border.all(
                                    color: ColorsManager.bottomNavigationColorDark,
                                    width: 1.w),
                                color:!ThemeCubit.get(context).isDark ? ColorsManager.whiteColor:ColorsManager.backgroundColorDarkMode,
                                borderRadius: BorderRadius.circular(16.0.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsManager.blackColor.withOpacity(0.15),
                                    spreadRadius: 0,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2), // changes position of shadow
                                  ),
                                ]
                            ),
                            child: Padding(
                              padding:  REdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // 12345
                                      Image.asset(AssetsManager.deliveryOrder,height:50.h ,width: 50.w,),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.orderPlaced ? StringsManager.orderPlaced.tr() :OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.preparingOrder ?   StringsManager.preparingOrder.tr():OrderStatusCubit.get(context).orderStatusEnum == OrderStatus.outForDelivery ? StringsManager.onTheWay.tr(): '',
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              OrderStatusCubit.get(context).trackOrderModelResponse!.data!.message ?? '',
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color:ThemeCubit.get(context).isDark ? null : ColorsManager.blackColor4
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      SvgPicture.asset(AssetsManager.arrowRight2,width: 16.w,height: 16.h,colorFilter: ColorFilter.mode(
                                          !ThemeCubit.get(context).isDark ? ColorsManager.blackColor:ColorsManager.blackColor2DarkMode, BlendMode.srcIn),)



                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FAProgressBar(
                                          progressColor: ColorsManager.primaryColor,
                                          backgroundColor: ColorsManager.bottombarcolor,
                                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                          //    animatedDuration: const Duration(milliseconds: 1000),
                                          size: 5,
                                          currentValue: OrderStatusCubit.get(context).currentValue1,
                                          // displayText: '%',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Expanded(
                                        child: FAProgressBar(
                                          progressColor: ColorsManager.primaryColor,
                                          backgroundColor: ColorsManager.bottombarcolor,
                                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                          //     animatedDuration: const Duration(milliseconds: 1000),
                                          size: 5,
                                          currentValue: OrderStatusCubit.get(context).currentValue2,
                                          // displayText: '%',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Expanded(
                                        child: FAProgressBar(
                                          progressColor: ColorsManager.primaryColor,
                                          backgroundColor: ColorsManager.bottombarcolor,
                                          borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                          //    animatedDuration: const Duration(milliseconds: 1000),
                                          size: 5,
                                          currentValue: OrderStatusCubit.get(context).currentValue3,
                                          // displayText: '%',
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),

                          ),
                        ),
                      );
                    },
                  ),

                  Expanded(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                         // if(Constants.addNewAddressRequestBox.values.isNotEmpty)
                        // if(HomeCubit.get(context).isChecked[0])
                        //   BlocConsumer<SettingsCubit,SettingsState>(
                        //     listener: (BuildContext context, state) {
                        //       if(state is PatchAddressSuccess){
                        //         SettingsCubit.get(context).homeAddressModelResponse = state.createAddressModelResponse;
                        //         // sl<NavigationService>().popup();
                        //       }
                        //     },
                        //     builder: (BuildContext context, Object? state) {
                        //       return SettingsCubit.get(context).getAllAddressModelResponse != null?
                        //       SliverToBoxAdapter(
                        //         child: SettingsCubit.get(context).getAllAddressModelResponse!.isEmpty ?
                        //         const SizedBox() :
                        //         Padding(
                        //           padding:  REdgeInsets.only(
                        //             top: 4
                        //           ),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               SvgPicture.asset(
                        //                 AssetsManager.location,
                        //                 height: 14.sp,
                        //                 width: 14.sp,
                        //                 colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn),
                        //
                        //               ),
                        //               Text(
                        //                 StringsManager.deliveryTo.tr(),
                        //                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        //                   fontSize: 12.sp,
                        //                   fontWeight: FontWeight.w400,
                        //                     color: ColorsManager.greyTextScreen4
                        //                   // color: ColorsManager.greyTextScreen4
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 8.w,
                        //               ),
                        //               InkWell(
                        //                 splashColor: Colors.transparent,
                        //                 highlightColor: Colors.transparent,
                        //                 onTap: (){
                        //                   showModalBottomSheet(
                        //                       shape: RoundedRectangleBorder(
                        //                         borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.r)),
                        //                       ),
                        //                       backgroundColor:ThemeCubit.get(context).isDark ? ColorsManager.backgroundColorDarkMode :  ColorsManager.whiteColor,
                        //                       context: context, builder: (BuildContext context) {
                        //                     return  StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                        //                       return Padding(
                        //                         padding:  REdgeInsets.all(16.0),
                        //                         child: Column(
                        //                           mainAxisSize: MainAxisSize.min,
                        //                           mainAxisAlignment: MainAxisAlignment.start,
                        //                           crossAxisAlignment: CrossAxisAlignment.start,
                        //                           children: [
                        //                             Row(
                        //                               mainAxisAlignment: MainAxisAlignment.end,
                        //                               children: [
                        //                                 GestureDetector(
                        //                                     onTap: (){
                        //                                       sl<NavigationService>().popup();
                        //                                     },
                        //                                     child: SvgPicture.asset(AssetsManager.close,height: 24.h,width: 24.w,
                        //                                       colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn),
                        //                                     )),
                        //                               ],
                        //                             ),
                        //                             SizedBox(
                        //                               height: 8.h,
                        //                             ),
                        //                             Text(
                        //                               StringsManager.chooseAddress.tr(),
                        //                               style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        //                                 fontSize: 14.sp,
                        //                                 fontWeight: FontWeight.w600,
                        //                               ),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 24.h,
                        //                             ),
                        //                             state is SettingsLoadingPatchAddress ? const LoadingIndicatorWidget() :  SizedBox(
                        //                               height:SettingsCubit.get(context).getAllAddressModelResponse!.length > 3 ? 200.h: SettingsCubit.get(context).getAllAddressModelResponse!.length * 60.h,
                        //                               child: ListView.separated(
                        //                                 itemBuilder:(context,index){
                        //
                        //                                   return GestureDetector(
                        //                                     onTap: ()async{
                        //                                       setState(() {
                        //                                         SettingsCubit.get(context).patchAddress(createAddressRequest: CreateAddressRequest(
                        //                                             isMain: true
                        //                                         ), id: SettingsCubit.get(context).getAllAddressModelResponse![index].id!);
                        //
                        //                                         SettingsCubit.get(context).getAllAddressModelResponse!.forEach((element) {
                        //                                           element.isMain = false;
                        //                                         });
                        //                                         SettingsCubit.get(context).getAllAddressModelResponse![index].isMain = true;
                        //                                       });
                        //                                     },
                        //                                     child: ChooseAddressWidget(
                        //                                       isHome: true,
                        //                                       addNewAddressRequest: SettingsCubit.get(context).getAllAddressModelResponse![index],
                        //                                       isSelected: SettingsCubit.get(context).getAllAddressModelResponse![index].isMain ?? false,
                        //
                        //                                       // isSelected: allIndexOfChooseItem[index],
                        //                                     ),
                        //                                   );
                        //                                 },itemCount: SettingsCubit.get(context).getAllAddressModelResponse!.length  ,
                        //                                 separatorBuilder: (context,index){
                        //                                   return SizedBox(
                        //                                     height: 12.h,
                        //                                   );
                        //                                 },),
                        //                             ),
                        //                             SizedBox(
                        //                               height: 40.h,
                        //                             ),
                        //                             Row(
                        //                               mainAxisAlignment: MainAxisAlignment.center,
                        //                               children: [
                        //                                 GestureDetector(
                        //                                     onTap: (){
                        //                                       sl<NavigationService>().popup();
                        //                                       sl<NavigationService>().navigateTo(RoutesManager.googleMap);
                        //                                     },
                        //                                     child: Text(
                        //                                       StringsManager.addNewAddress.tr(),
                        //                                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        //                                           fontSize: 14.sp,
                        //                                           fontWeight: FontWeight.w600,
                        //                                           color: ColorsManager.primaryColor
                        //                                       ),
                        //                                     )
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       );
                        //                     });
                        //                   }
                        //                   );
                        //                 },
                        //                 child: Row(
                        //                   children: [
                        //                     Text(SettingsCubit.get(context).homeAddressModelResponse?.label ?? '',
                        //                       style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        //                         fontSize: 10.sp,
                        //                         fontWeight: FontWeight.w500,
                        //                         // color: ColorsManager.greyTextScreen4
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       width: 3.w,
                        //                     ),
                        //                     SvgPicture.asset(AssetsManager.arrowDownIcon,width: 16.w,height: 16.h,
                        //                       colorFilter: ColorFilter.mode(!ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn)
                        //                       ,)
                        //
                        //
                        //                   ],
                        //                 ),
                        //               ),
                        //
                        //
                        //
                        //
                        //
                        //
                        //               // SizedBox(
                        //               //   height: 5.h,
                        //               // ),
                        //
                        //             ],
                        //           ),
                        //         ),
                        //       ) :
                        //       const SliverToBoxAdapter(
                        //         child: LoadingIndicatorWidget(),
                        //       );
                        //     },
                        //   ),



                        SliverToBoxAdapter(
                          child: HomeCubit.get(context).adsModel == null
                              ? const Center(child: LoadingIndicatorWidget())
                              : Padding(
                            padding: REdgeInsets.symmetric(vertical: 16),
                            child:HomeCubit.get(context).adsModel!.isEmpty ? const SizedBox() : Directionality(
                              textDirection: TextDirection.ltr,
                                child: const CustomBannerCarousel()),
                          ),
                        ),


                        SliverToBoxAdapter(
                          child: Padding(
                            padding: REdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              StringsManager.categories.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!.copyWith(
                                fontSize: 10.sp
                              ),
                            ),
                          ),
                        ),



                      SliverToBoxAdapter(
                        child:SizedBox(
                          height: 120.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                              return SizedBox(
                                child: CategoryItem(
                                  index: index,
                                  image: HomeCubit.get(context).categoriesImage[index],
                                  // selected: HomeCubit.get(context)
                                  //     .isChecked[index],
                                  onTap: () async {
                                    HomeCubit.get(context).categoryTitle = HomeCubit.get(context).categoriesTitle[index];
                                    // if(HomeCubit.get(context).categoryTitle == 'Popular'){
                                    //   setState(() {
                                    //   });
                                    //   HomeCubit.get(context).pageNewest = 1;
                                    //   HomeCubit.get(context).pageBestSeller = 1;
                                    //   HomeCubit.get(context).loadingBestSeller = false;
                                    //   HomeCubit.get(context).loadingNewest = false;
                                    // }
                                    // else {
                                    HomeCubit.get(context).pageNonPopular = 1;
                                    HomeCubit.get(context).loadingNonPopular = false;
                                    _scrollController = ScrollController();

                                    // await HomeCubit.get(context).getNonPopularProduct(
                                    //     page: HomeCubit.get(context).pageNonPopular,
                                    //     firstTime: true,
                                    //     categoryTitle: HomeCubit.get(context).categoryTitle);

                                    Navigator.push(context, MaterialPageRoute(builder:(context){
                                      return const NewNonPopular();
                                    }));

                                    // }
                                  },
                                  title: HomeCubit.get(context)
                                      .categoriesTitle[index],
                                ),
                              ) ;
                              },
                              separatorBuilder: (context,index){
                              return SizedBox(
                                width: 4.w,
                              );
                              },
                              itemCount: HomeCubit.get(context)
                                  .categoriesTitle
                                  .length,
                          ),
                        ) ,
                      ),


                      // SliverGrid(
                      //   key: const PageStorageKey<String>('pageTwo'),
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     mainAxisExtent: 100.h,
                      //     crossAxisCount: 3, // Number of columns
                      //     mainAxisSpacing: 12.0,
                      //     crossAxisSpacing: 8.0,
                      //     // childAspectRatio: 1.2, // Adjust the aspect ratio as needed
                      //   ),
                      //   delegate: SliverChildBuilderDelegate(
                      //         (context, index) {
                      //       return SizedBox(
                      //         child: CategorieItem(
                      //           index: index,
                      //           image: HomeCubit.get(context).categoriesImage[index],
                      //           // selected: HomeCubit.get(context)
                      //           //     .isChecked[index],
                      //           onTap: () async {
                      //             HomeCubit.get(context).categoryTitle = HomeCubit.get(context).categoriesTitle[index];
                      //             // if(HomeCubit.get(context).categoryTitle == 'Popular'){
                      //             //   setState(() {
                      //             //   });
                      //             //   HomeCubit.get(context).pageNewest = 1;
                      //             //   HomeCubit.get(context).pageBestSeller = 1;
                      //             //   HomeCubit.get(context).loadingBestSeller = false;
                      //             //   HomeCubit.get(context).loadingNewest = false;
                      //             // }
                      //             // else {
                      //             HomeCubit.get(context).pageNonPopular = 1;
                      //             HomeCubit.get(context).loadingNonPopular = false;
                      //             _scrollController = ScrollController();
                      //
                      //             // await HomeCubit.get(context).getNonPopularProduct(
                      //             //     page: HomeCubit.get(context).pageNonPopular,
                      //             //     firstTime: true,
                      //             //     categoryTitle: HomeCubit.get(context).categoryTitle);
                      //
                      //             Navigator.push(context, MaterialPageRoute(builder:(context){
                      //               return const NewNonPopular();
                      //             }));
                      //
                      //             // }
                      //           },
                      //           title: HomeCubit.get(context)
                      //               .categoriesTitle[index],
                      //         ),
                      //       ) ;
                      //     },
                      //     childCount:  HomeCubit.get(context)
                      //       .categoriesTitle
                      //       .length,
                      //   ),
                      // ),



















                        // SliverPersistentHeader(
                        //   pinned: true,
                        //   delegate: PersistentHeader(
                        //     widget: PageStorage(
                        //       bucket: pageBucket,
                        //       child: Container(
                        //         color: Colors.transparent,
                        //         height: 100.h,
                        //         child:
                        //             HomeCubit.get(context).categories == null ?  const SizedBox() :
                        //       //  state is HomeLoadingState ? const SizedBox() :
                        //         ListView.separated(
                        //             cacheExtent: 9999,
                        //             physics: HomeCubit.get(context)
                        //                 .categoriesTitle
                        //                 .length <=
                        //                 2
                        //                 ? const NeverScrollableScrollPhysics()
                        //                 : null,
                        //             addAutomaticKeepAlives: true,
                        //             key: const PageStorageKey<String>(
                        //                 'pageOne'),
                        //             controller: scrollController,
                        //             scrollDirection: Axis.horizontal,
                        //             itemBuilder: (context, index) {
                        //               return CategorieItem(
                        //                 index: index,
                        //                 image: HomeCubit.get(context).categoriesImage[index],
                        //                 // selected: HomeCubit.get(context)
                        //                 //     .isChecked[index],
                        //                 onTap: () async {
                        //                   HomeCubit.get(context).categoryTitle = HomeCubit.get(context).categoriesTitle[index];
                        //                       // if(HomeCubit.get(context).categoryTitle == 'Popular'){
                        //                       //   setState(() {
                        //                       //   });
                        //                       //   HomeCubit.get(context).pageNewest = 1;
                        //                       //   HomeCubit.get(context).pageBestSeller = 1;
                        //                       //   HomeCubit.get(context).loadingBestSeller = false;
                        //                       //   HomeCubit.get(context).loadingNewest = false;
                        //                       // }
                        //                       // else {
                        //                         HomeCubit.get(context).pageNonPopular = 1;
                        //                         HomeCubit.get(context).loadingNonPopular = false;
                        //                         _scrollController = ScrollController();
                        //
                        //                         // await HomeCubit.get(context).getNonPopularProduct(
                        //                         //     page: HomeCubit.get(context).pageNonPopular,
                        //                         //     firstTime: true,
                        //                         //     categoryTitle: HomeCubit.get(context).categoryTitle);
                        //
                        //                         Navigator.push(context, MaterialPageRoute(builder:(context){
                        //                           return const NewNonPopular();
                        //                         }));
                        //
                        //                       // }
                        //                 },
                        //                 title: HomeCubit.get(context)
                        //                     .categoriesTitle[index],
                        //               );
                        //             },
                        //             separatorBuilder: (context, index) =>
                        //                 SizedBox(
                        //                   width: 15.w,
                        //                 ),
                        //             itemCount: HomeCubit.get(context)
                        //                 .categoriesTitle
                        //                 .length),
                        //       ),
                        //     ),
                        //   ),
                        // ),

                      const SliverToBoxAdapter(
                          child: PopularWidget(),
                        )
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
    super.initState();
    MapCubit.get(context).getLocation();
    _scrollController = ScrollController() ;
      // _searchController = TextEditingController();
      scrollController = ScrollController();
    // if(sl<PrefsHelper>().getToken2().isEmpty && sl<PrefsHelper>().getSession2().isEmpty){
    //   HomeCubit.get(context).addSession();
    // }
      HomeCubit.get(context).getAds();
      HomeCubit.get(context).getCategory();
       SettingsCubit.get(context).getAllAddressHome();
       if(!widget.guest){
         HomeCubit.get(context).getProfile();
       }

  } // @override

  @override
  void dispose() {
    // _searchController.dispose();
    super.dispose();
  }




}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;

  PersistentHeader({required this.widget});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color:!ThemeCubit.get(context).isDark ? ColorsManager.backgroundColor:ColorsManager.backgroundColorDarkMode,
      width: double.infinity,
      height: 70.0,
      child: Center(child: widget),
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
final pageBucket = PageStorageBucket();