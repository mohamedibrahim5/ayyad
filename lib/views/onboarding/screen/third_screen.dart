import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../widget/onboarding_widget.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key,required this.controller});
  final PageController controller ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  onBoardingWidget(
          topImage: AssetsManager.thirdBackground,
          dis: StringsManager.thirdDis.tr(),
          title: StringsManager.thirdTitle.tr(),
          context: context,
          frame: AssetsManager.thirdFrame,
          onPressed:(){
            sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
            sl<PrefsHelper>().setData(key: Constants.showOnBoarding, value: false);
          },
      ),
      // Container(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(AssetsManager.thirdBackground),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   child: CustomScrollView(
      //     slivers: [
      //       SliverFillRemaining(
      //         hasScrollBody: false,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children:[
      //             Expanded(
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SafeArea(
      //                         child: Padding(
      //                           padding:  REdgeInsets.only(
      //                               top: 8,
      //                               right: 16,
      //                               left: 16
      //                           ),
      //                           child:loginIconWidget(context: context),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   const Spacer(),
      //                   onBoardingWidget(
      //                     topImage: AssetsManager.thirdBackground,
      //                     dis: StringsManager.thirdDis,
      //                       title: StringsManager.thirdTrade,
      //                       context: context,
      //                       frame: AssetsManager.thirdFrame,
      //                       onPressed:(){
      //                         sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
      //                         sl<PrefsHelper>().setData(key: Constants.showOnBoarding, value: false);
      //                       }
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
