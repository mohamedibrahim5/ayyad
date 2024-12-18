import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/string_manager.dart';
import '../widget/onboarding_widget.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key,required this.controller});
  final PageController controller ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  onBoardingWidget(
          topImage: AssetsManager.secondBackground,
          dis: StringsManager.secondDis.tr(),
          title: StringsManager.secondTitle.tr(),
          context: context,
          frame: AssetsManager.secondFrame,
          onPressed:(){
            controller.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
           // sl<NavigationService>().navigateTo(RoutesManager.thirdScreen);
          },
      ),
    );
  }
}