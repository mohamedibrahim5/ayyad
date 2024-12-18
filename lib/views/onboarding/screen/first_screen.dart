import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/string_manager.dart';
import '../widget/onboarding_widget.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key,required this.controller});
  final PageController controller ;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {


  @override
  Widget build(BuildContext context) {
    return onBoardingWidget(
          topImage: AssetsManager.firstBackground,
          dis: StringsManager.firstDis.tr(),
          title: StringsManager.firstTitle.tr(),
          context: context,
          frame: AssetsManager.firstFrame,
          onPressed:(){
            widget.controller.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
            // sl<NavigationService>().navigateTo(RoutesManager.thirdScreen);
          },
      );

  }
}