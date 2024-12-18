import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/gen/assets.gen.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';
import 'package:ibnelbarh/views/settings/widget/delete_account_widget.dart';

import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/dialog_reusable.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../base_button_bar/cubit/base_screen_navigation_cubit.dart';
import '../../home/cubit/map_cubit.dart';
import '../widget/about_dialog_widget.dart';
import '../widget/choose_language_widget.dart';
import '../widget/log_out_widget.dart';
import '../widget/settings_item_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SettingsCubit,SettingsState>(
      listener: (BuildContext context, state) {

      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child: Column(
                children: [
                  ArrowBack(
                    title: StringsManager.setting.tr(),
                    onPressed: (){
                      BaseScreenNavigationCubit.get(context).reset();
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SettingsItemWidget(
                    title: StringsManager.editProfile.tr(),
                    onTap: (){
                      // sl<NavigationService>().navigateTo(RoutesManager.orderConfirmedScreen);


                      if(sl<PrefsHelper>().getToken2().isNotEmpty){
                        sl<NavigationService>().navigateTo(RoutesManager.profileScreen);
                      }else {
                        _navigateLogin();
                      }

                    },
                    icon: Assets.images.mingcuteUserEditLine.path,
                  ),
                  Padding(
                    padding:  REdgeInsets.symmetric(
                      vertical: 16
                    ),
                    child: SettingsItemWidget(
                      title: StringsManager.yourOrders.tr(),
                      onTap: (){
                        sl<NavigationService>().navigateTo(RoutesManager.orderScreen);
                      },
                      icon: AssetsManager.yourOrders2,
                    ),
                  ),

                  SettingsItemWidget(
                    title: StringsManager.changePassword.tr(),
                    onTap: (){
                      if(sl<PrefsHelper>().getToken2().isNotEmpty){
                        sl<NavigationService>().navigateTo(RoutesManager.changePasswordScreen);
                      }else {
                        _navigateLogin();
                      }
                    },
                    icon: AssetsManager.changePassword2,
                  ),

                  SizedBox(
                    height: 16.h,
                  ),

                  SettingsItemWidget(
                    title: StringsManager.language.tr(),
                    onTap: (){
                      showReusableDialog(
                        image: 'assets/images/language.svg',
                          context: context,
                          widget:  const ChooseLanguageWidget()
                      );
                    },
                    icon: AssetsManager.language,
                  ),

                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // Padding(
                  //   padding:  REdgeInsets.symmetric(
                  //       vertical:8
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Row(
                  //         children: [
                  //           SvgPicture.asset(
                  //             'assets/images/darkMode.svg',
                  //             height: 16.sp,
                  //             width: 16.sp,
                  //             colorFilter:   ColorFilter.mode(
                  //                 !ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn,
                  //             ),matchTextDirection: true ,
                  //           ),
                  //           SizedBox(
                  //             width: 8.w,
                  //           ),
                  //           Text(
                  //             StringsManager.darkMode.tr(),
                  //             style: Theme.of(context).textTheme.displaySmall!,
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 16.0.h,
                  //         width: 38.w,
                  //         child: FittedBox(
                  //           fit: BoxFit.fitWidth,
                  //           child: CupertinoSwitch(
                  //             activeColor: ColorsManager.primaryColor,
                  //             thumbColor: ColorsManager.whiteColor,
                  //             trackColor: Color(0xff585858).withOpacity(0.5),
                  //             value: isDarkMode,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 isDarkMode = value;
                  //                 if(ThemeCubit.get(context).isDark){
                  //                   ThemeCubit.get(context).toLightMode();
                  //                 }else {
                  //                   ThemeCubit.get(context).toDarkMode();
                  //                 }
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ) ,






                  Padding(
                    padding:  REdgeInsets.symmetric(
                        vertical: 16
                    ),
                    child: SettingsItemWidget(
                      delete: false,
                      title: StringsManager.manageAddress.tr(),
                      onTap: (){
                        sl<NavigationService>().navigateTo(RoutesManager.myAddressScreen);
                        // showReusableDialog(
                        //     image:AssetsManager.deleteAccount ,
                        //     context: context,
                        //     widget: const DeleteAccountWidget()
                        // );
                      },
                      icon: AssetsManager.manageAddress,
                    ),
                  ),

                  sl<PrefsHelper>().getToken2().isNotEmpty ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          SettingsItemWidget(
                            title: StringsManager.myPoints.tr(),
                            onTap: (){
                              sl<NavigationService>().navigateTo(RoutesManager.myPointScreen);
                            },
                            icon: AssetsManager.myPoints,
                          ),

                          Padding(
                            padding:  REdgeInsets.symmetric(
                              vertical: 16
                            ),
                            child: SettingsItemWidget(
                              title: StringsManager.logOut.tr(),
                              onTap: (){
                                showReusableDialog(
                                    image: AssetsManager.logOut2,
                                    padding:  REdgeInsets.symmetric(
                                        horizontal: 0
                                    ),
                                    context: context,
                                    widget:  const LogOutWidget()
                                );
                              },
                              icon: AssetsManager.logOut3,
                            ),
                          ),
                          SettingsItemWidget(
                            delete: false,
                            title: StringsManager.deleteAccount.tr(),
                            onTap: (){
                              showReusableDialog(
                                  image: AssetsManager.deleteAccount,
                                  padding:  REdgeInsets.symmetric(
                                      horizontal: 0
                                  ),
                                  context: context,
                                  widget:  const DeleteAccountWidget()
                              );
                              // showReusableDialog(
                              //     image:AssetsManager.deleteAccount ,
                              //     context: context,
                              //     widget: const DeleteAccountWidget()
                              // );
                            },
                            icon: AssetsManager.delete2,
                          ),
                        ],
                      )
                   : const SizedBox(),

                  if(sl<PrefsHelper>().getToken2().isNotEmpty)
                    SizedBox(
                      height: 16.h,
                    ),

                  SettingsItemWidget(
                    title: StringsManager.about.tr(),
                    onTap: (){
                      showReusableDialog(
                        image: 'assets/images/about.svg',
                          context: context,
                          widget:  const AboutDialogWidget()
                      );
                    },
                    icon:'assets/images/about.svg',
                  ),



                  // sl<PrefsHelper>().getToken2().isNotEmpty ? dividerWidget(
                  //   bottom: 12,
                  //   top: 0,
                  // ) : const SizedBox(),


                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }


  @override
  void initState() {
    super.initState();
    isDarkMode = ThemeCubit.get(context).isDark;
    MapCubit.get(context).getLocation();
  }

  _navigateLogin(){
    // Utils.showSnackBar('Please Login First', context);
    sl<NavigationService>().navigateTo(RoutesManager.loginScreen);
  }
}
