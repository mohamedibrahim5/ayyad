import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/utils.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../cubit/base_screen_navigation_cubit.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}


class _BaseScreenState extends State<BaseScreen> with  SingleTickerProviderStateMixin {


  // _navigateLogin(){
  //   Utils.showSnackBar('Please Login First', context);
  //   sl<NavigationService>().navigateTo(RoutesManager.loginScreen);
  // }

  bool exitApp = false;
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
     bool guest = arguments[Constants.guest] ?? true;
     guest = sl<PrefsHelper>().guestCheck();
    if(guest){
      sl<PrefsHelper>().setToken2('');
    }
       return BlocBuilder<ThemeCubit,ThemeModeChanged>(
         builder: (BuildContext context, state) {
           return BlocConsumer<BaseScreenNavigationCubit,BaseScreenNavigationState>(
             listener: (BuildContext context, state) {  },
             builder: (BuildContext context, Object? state) {
               return PopScope(

                 onPopInvokedWithResult: (didPop, result) async {
                   // print('${!didPop &&
                   //     BaseScreenNavigationCubit.get(context).currentIndex ==
                   //         0} ${!didPop}  ${BaseScreenNavigationCubit.get(context).currentIndex} ');
                   if (!didPop &&
                       BaseScreenNavigationCubit.get(context).currentIndex !=
                           0) {
                     BaseScreenNavigationCubit.get(context).reset();
                   } else if (!didPop &&
                       BaseScreenNavigationCubit.get(context).currentIndex ==
                           0) {

                     if(exitApp){
                       SystemNavigator.pop();
                     }
                     setState(() {
                       exitApp = true;
                     });
                     Utils.showSnackBar(StringsManager.doubleTapToBack.tr(), context);

                     Future.delayed(const Duration(seconds: 3), () {
                       setState(() {
                         exitApp = false;
                       });
                     });



                     // final bool? shouldPop = await  showDialog(context: context, builder: (context) => AlertDialog(
                     //   shape: const RoundedRectangleBorder(
                     //       borderRadius: BorderRadius.all(Radius.circular(8))),
                     //   title: Text("Exit App",
                     //       style: TextStyle(
                     //         color: Theme.of(context).primaryColor,
                     //       )),
                     //   content: Text("Are You Sure To Exit App ? ",
                     //       style: const TextStyle(
                     //         color: ColorsManager.primaryColor,
                     //       )),
                     //   actions: <Widget>[
                     //     MainButton(
                     //       color: ColorsManager.blue,
                     //       title: "No Thank You",
                     //       width: 130.w,
                     //       onPressed: () {
                     //         Navigator.of(context).pop(false);
                     //       },
                     //     ),
                     //
                     //     MainButton(
                     //       color: ColorsManager.red,
                     //       title: "Yes Please",
                     //       width: 130.w,
                     //       onPressed: () {
                     //         Navigator.of(context).pop(true);
                     //       },
                     //     ),
                     //   ],
                     // ),);
                     // if (shouldPop ?? false) {
                     //   SystemNavigator.pop();
                     // }
                   }

                 },
                 // onPopInvoked: (didPop) async{
                 //
                 // },

                 // onPopInvoked: (didPop) {
                 //   if (!didPop) {
                 //     BaseScreenNavigationCubit.get(context).reset();
                 //   }
                 // },
                 canPop: false,
                 //  BaseScreenNavigationCubit.get(context).currentIndex == 0,



                 // condition: BaseScreenNavigationCubit.get(context).currentIndex ==0 ,
                 // onConditionFail: () {
                 //   BaseScreenNavigationCubit.get(context).reset();
                 // },
                 // onFirstBackPress: (context) {
                 //   print('ClientBaseScreenNavigationCubit.get(context).currentIndex ==0 ${BaseScreenNavigationCubit.get(context).currentIndex}');
                 //   getDoubleBackSnackBar();
                 //
                 // },
                 child: Localizations.override(
                   locale: context.locale,
                   context: context,
                   child: Scaffold(
                     resizeToAvoidBottomInset: false,
                     body: BaseScreenNavigationCubit.get(context).bottomScreens(
                         guest
                     )[BaseScreenNavigationCubit.get(context).currentIndex],
                     bottomNavigationBar:
                     Container(
                       height: 64.h,
                       decoration: BoxDecoration(
                         border: Border.all(color:
                         !ThemeCubit.get(context).isDark ?  ColorsManager.bottomNavigationColor:ColorsManager.bottomNavigationColorDark,
                             width: 1),
                         borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(20.r),
                             topRight: Radius.circular(20.r)),
                         color:!ThemeCubit.get(context).isDark ? ColorsManager.whiteColor:ColorsManager.backgroundColorDarkMode,
                       ),
                       child: TabBar(
                         labelColor: ColorsManager.primaryColor,
                         unselectedLabelColor: const Color(0xff667085),
                         indicatorSize:  TabBarIndicatorSize.tab,
                         indicatorPadding: EdgeInsets.symmetric(horizontal: 35.w),
                         onTap: (index) {
                           BaseScreenNavigationCubit.get(context).changeBottom(index);
                         },
                         controller: BaseScreenNavigationCubit.get(context).tabController,
                         indicator: TopIndicator(),
                         indicatorWeight: 3,
                         tabs: <Widget>[
                           Column(
                             key: const PageStorageKey('home'),
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               SvgPicture.asset(
                                 BaseScreenNavigationCubit.get(context).currentIndex == 0
                                     ? AssetsManager.home
                                     : AssetsManager.home,
                                 colorFilter: ColorFilter.mode(
                                     navIconColor(
                                         iconIndex: 0,
                                         currentIndex:BaseScreenNavigationCubit.get(context).tabController!.index ), BlendMode.srcIn
                                 )
                                 ,matchTextDirection: true,
                                 height: 20.h,
                                 width: 20.w,
                               ),
                               SizedBox(
                                 height: 2.h,
                               ),
                               Text(
                                 StringsManager.home.tr(),
                                 style: TextStyle(
                                   fontSize: 10.sp,
                                   fontWeight: FontWeight.w500,
                                 ),
                               )
                             ],
                           ),
                           // Tab(
                           //   icon: SvgPicture.asset(
                           //     BaseScreenNavigationCubit.get(context).currentIndex == 0
                           //         ? AssetsManager.home
                           //         : AssetsManager.home,
                           //           colorFilter: ColorFilter.mode(
                           //               navIconColor(
                           //                   iconIndex: 0,
                           //                   currentIndex:BaseScreenNavigationCubit.get(context).tabController!.index ), BlendMode.srcIn
                           //                           )
                           //     ,matchTextDirection: true,
                           //     height: 20.h,
                           //     width: 20.w,
                           //   ),
                           //   child: Text(
                           //     StringsManager.home,
                           //     style: TextStyle(
                           //       fontSize: 10.sp,
                           //       fontWeight: FontWeight.w500,
                           //     ),
                           //   ),
                           // ),
                           Column(
                             key: const PageStorageKey('cart'),
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               SvgPicture.asset(
                                 BaseScreenNavigationCubit.get(context).currentIndex == 1
                                     ? AssetsManager.cart
                                     : AssetsManager.cart,
                                 colorFilter: ColorFilter.mode(
                                     navIconColor(
                                         iconIndex: 1,
                                         currentIndex:BaseScreenNavigationCubit.get(context).tabController!.index ), BlendMode.srcIn
                                 )
                                 ,matchTextDirection: true,
                                 height: 20.h,
                                 width: 20.w,
                               ),
                               SizedBox(
                                 height: 2.h,
                               ),
                               Text(
                                 StringsManager.cart.tr(),
                                 style: TextStyle(
                                   fontSize: 10.sp,
                                   fontWeight: FontWeight.w500,
                                 ),
                               )
                             ],
                           ),
                           // Tab(
                           //   icon: SvgPicture.asset(
                           //     BaseScreenNavigationCubit.get(context).currentIndex == 1
                           //         ? AssetsManager.cart
                           //         : AssetsManager.cart,
                           //     colorFilter: ColorFilter.mode(
                           //         navIconColor(
                           //             iconIndex: 1,
                           //             currentIndex:BaseScreenNavigationCubit.get(context).tabController!.index ), BlendMode.srcIn
                           //     )
                           //     ,matchTextDirection: true,
                           //     height: 20.h,
                           //     width: 20.w,
                           //   ),
                           //   child: Text(
                           //     StringsManager.cart,
                           //     style: TextStyle(
                           //       fontSize: 10.sp,
                           //       fontWeight: FontWeight.w500,
                           //     ),
                           //   ),
                           // ),
                           Column(
                             key: const PageStorageKey('settings'),
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               SvgPicture.asset(
                                 BaseScreenNavigationCubit.get(context).currentIndex == 2
                                     ? AssetsManager.setting
                                     : AssetsManager.setting,
                                 colorFilter: ColorFilter.mode(
                                     navIconColor(
                                         iconIndex: 2,
                                         currentIndex:BaseScreenNavigationCubit.get(context).tabController!.index ), BlendMode.srcIn
                                 )
                                 ,matchTextDirection: true,
                                 width: 20.w,
                                 height: 20.h,
                               ),
                               SizedBox(
                                 height: 2.h,
                               ),
                               Text(
                                 StringsManager.setting.tr(),
                                 style: TextStyle(
                                   fontSize: 10.sp,
                                   fontWeight: FontWeight.w500,
                                 ),
                               )
                             ],
                           ),
                           // Tab(
                           //   icon: SvgPicture.asset(
                           //     BaseScreenNavigationCubit.get(context).currentIndex == 2
                           //         ? AssetsManager.setting
                           //         : AssetsManager.setting,
                           //     colorFilter: ColorFilter.mode(
                           //         navIconColor(
                           //             iconIndex: 2,
                           //             currentIndex:BaseScreenNavigationCubit.get(context).tabController!.index ), BlendMode.srcIn
                           //     )
                           //     ,matchTextDirection: true,
                           //     width: 20.w,
                           //     height: 20.h,
                           //   ),
                           //   child: Text(
                           //     StringsManager.setting,
                           //     style: TextStyle(
                           //       fontSize: 10.sp,
                           //       fontWeight: FontWeight.w500,
                           //     ),
                           //   ),
                           // ),
                         ],
                       ),
                     ),
                     // Container(
                     //   decoration: BoxDecoration(
                     //     color: ColorsManager.whiteColor,
                     //     border: Border.all(
                     //         color: ColorsManager.bottomNavigationColor,
                     //         width: 1
                     //     ),
                     //     borderRadius: BorderRadius.only(
                     //       topLeft: Radius.circular(20.r),
                     //       topRight: Radius.circular(20.r),
                     //     ),
                     //   ),
                     //   child: BlocBuilder<BaseScreenNavigationCubit,
                     //       BaseScreenNavigationState>(
                     //     builder: (context, navigationState) {
                     //       if (navigationState is BaseScreenNavigationInitial) {
                     //         return ClipRRect(
                     //           borderRadius: BorderRadius.only(
                     //             topLeft: Radius.circular(20.r),
                     //             topRight: Radius.circular(20.r),
                     //           ),
                     //           child: BottomNavigationBar(
                     //             selectedLabelStyle:Theme.of(context).textTheme.bodyLarge!.copyWith(
                     //               fontSize: 10.sp,
                     //               fontWeight: FontWeight.w500,
                     //             ) ,
                     //             unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                     //                 fontSize: 10.sp
                     //             ),
                     //             backgroundColor: ColorsManager.whiteColor,
                     //             selectedFontSize: 10.sp,
                     //             unselectedFontSize: 10.sp,
                     //             currentIndex: navigationState.index,
                     //             type: BottomNavigationBarType.fixed,
                     //             selectedItemColor: ColorsManager.primaryColor,
                     //             unselectedItemColor: ColorsManager.blackColor,
                     //             // showSelectedLabels: false,
                     //             // showUnselectedLabels: false,
                     //             items: [
                     //               BottomNavigationBarItem(
                     //                   icon: Padding(
                     //                     // padding: const EdgeInsets.only(right: 60),
                     //                     padding: const EdgeInsets.only(right: 0),
                     //                     child: SvgPicture.asset(
                     //                       AssetsManager.home,
                     //                       colorFilter: ColorFilter.mode(
                     //                           navIconColor(
                     //                               iconIndex: 0,
                     //                               currentIndex: navigationState.index), BlendMode.srcIn
                     //                       ),matchTextDirection: true,
                     //                     ),
                     //                   ),
                     //                   label: StringsManager.home
                     //               ),
                     //               BottomNavigationBarItem(
                     //                   icon: SvgPicture.asset(
                     //                     AssetsManager.cart,
                     //                     colorFilter: ColorFilter.mode(
                     //                         navIconColor(
                     //                             iconIndex: 1,
                     //                             currentIndex: navigationState.index), BlendMode.srcIn
                     //                     ),matchTextDirection: true,
                     //                   ),
                     //                   label: StringsManager.cart
                     //
                     //               ),
                     //               BottomNavigationBarItem(
                     //                   icon:  Padding(
                     //                     // padding: const EdgeInsets.only(left: 60),
                     //                     padding: const EdgeInsets.only(left: 0),
                     //                     child: SvgPicture.asset(
                     //                       AssetsManager.setting,
                     //                       colorFilter: ColorFilter.mode(
                     //                           navIconColor(
                     //                               iconIndex: 2,
                     //                               currentIndex: navigationState.index), BlendMode.srcIn
                     //                       ),matchTextDirection: true,
                     //                     ),
                     //                   ),
                     //                   label: StringsManager.setting
                     //               ),
                     //             ],
                     //             onTap: (index) {
                     //               if (index == 0) {
                     //                 BlocProvider.of<BaseScreenNavigationCubit>(
                     //                     context)
                     //                     .getNavBarItem(HomeNavigationBarTabs.home);
                     //               } else if (index == 1 ) {
                     //               //  if(sl<PrefsHelper>().getToken2().isNotEmpty){
                     //                   BlocProvider.of<BaseScreenNavigationCubit>(
                     //                       context)
                     //                       .getNavBarItem(
                     //                       HomeNavigationBarTabs.cart);
                     //                 // }else {
                     //                 //   _navigateLogin();
                     //                 // }
                     //
                     //               }
                     //               else if (index == 2) {
                     //               //  if(sl<PrefsHelper>().getToken2().isNotEmpty){
                     //                   BlocProvider.of<BaseScreenNavigationCubit>(
                     //                       context)
                     //                       .getNavBarItem(
                     //                       HomeNavigationBarTabs.settings);
                     //                 // }else {
                     //                 //   _navigateLogin();
                     //                 // }
                     //               }
                     //             },
                     //
                     //             // selectedFontSize: 8.sp,
                     //           ),
                     //         );
                     //       } else {
                     //         // undefined error
                     //         return const SizedBox();
                     //       }
                     //     },
                     //   ),
                     // ),
                   ),
                 ),
               ) ;
             },
           );
         },
       ) ;
  }
  Color navIconColor({required int iconIndex, required int currentIndex}) {
    return !ThemeCubit.get(context).isDark ?   currentIndex == iconIndex
        ? ColorsManager.primaryColor
        : ColorsManager.blackColor :
    currentIndex == iconIndex ? ColorsManager.primaryColor : ColorsManager.blackColor2DarkMode ;
  }

  @override
  void initState() {
    BaseScreenNavigationCubit.get(context).tabController = TabController(length: 3, vsync: this);
    BaseScreenNavigationCubit.get(context).currentIndex = 0;

    super.initState();
  }



}

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint paint = Paint()
      ..color = ColorsManager.primaryColor
      ..strokeWidth = 3
      ..isAntiAlias = true;

    canvas.drawLine(offset, Offset((cfg.size!.width) + offset.dx, 0), paint);
  }
}
