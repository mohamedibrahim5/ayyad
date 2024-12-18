import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/constant.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/prefs_helper.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/onboarding/screen/first_screen.dart';
import 'package:ibnelbarh/views/onboarding/screen/second_screen.dart';
import 'package:ibnelbarh/views/onboarding/screen/third_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/resources/assets_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0 ;
  final PageController _controller = PageController();
  List<String> images = [
    AssetsManager.firstBackground,
    AssetsManager.secondBackground,
    AssetsManager.thirdBackground,
  ];
  List<String> title = [
    StringsManager.firstTitle.tr(),
    StringsManager.secondTitle.tr(),
    StringsManager.thirdTitle.tr(),
  ];
  List<String> dis = [
    StringsManager.firstDis.tr(),
    StringsManager.secondDis.tr(),
    StringsManager.thirdDis.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height:index == 0 ? 70.h : 90.h,
              ),
              SizedBox(
               height: 350.h,
                child: PageView(
                  controller: _controller,
                  children:
                  List.generate(3, (index) => Padding(
                    padding:  REdgeInsets.symmetric(
                        horizontal: 44
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(images[index],height: 200.h,),
                        //  Center(child: SvgPicture.asset(image,matchTextDirection: true,)),
                        SizedBox(
                          height: 48.h,
                        ),
                        Text(title[index],style: Theme.of(context).textTheme.bodyLarge!,),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(dis[index],style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),

                        // SvgPicture.asset(frame,matchTextDirection: true),

                      ],
                    ),
                  )),
                  // <Widget>[




                    // FirstScreen(
                    //   controller: _controller,
                    // ),
                    // SecondScreen(
                    //   controller: _controller,
                    // ),
                    // ThirdScreen(
                    //     controller: _controller
                    // ),
                  // ],
                ),
              ),
              if(index==0)
                SizedBox(
                  height: 12.h,
                ),
              if(index==0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        context.setLocale(const Locale('en'));
                      },
                      child: Text(StringsManager.english.tr(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:context.locale.languageCode == 'en' ?  Theme.of(context).primaryColor:Theme.of(context).primaryColor.withOpacity(0.74),
                      ),textAlign: TextAlign.center,),
                    ),
                    SizedBox(
                      width: 38.w,
                    ),
                    InkWell(
                      onTap: (){
                        context.setLocale(const Locale('ar'));
                      },
                      child: Text(StringsManager.arabic.tr(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:context.locale.languageCode == 'ar' ?  Theme.of(context).primaryColor:Theme.of(context).primaryColor.withOpacity(0.74),
                      ),textAlign: TextAlign.center,),
                    ),
                  ],
                ),

              SizedBox(
                height: 48.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                      controller:_controller ,  // PageController
                      count:  3,
                      effect:  ExpandingDotsEffect(
                        dotHeight: 6,
                        dotColor: const Color(0xffF54748).withOpacity(0.4),
                          activeDotColor: Theme.of(context).primaryColor,
                          // dotHeight: 6,
                          dotWidth: 7,
                      ),  // your preferred effect
                      onDotClicked: (index){
                      }
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Padding(
                    padding: REdgeInsets.only(
                      right: 44,
                      left: 44
                    ),
                    child: MainButton(
                      title: index== 2 ? StringsManager.getStarted2.tr() : StringsManager.next.tr(),
                      onPressed:(){
                        if(index == 0){
                          _controller.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                        }else if(index == 1) {
                          _controller.animateToPage(
                              2, duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut
                          );
                        }else {
                          sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
                          sl<PrefsHelper>().setData(key: Constants.showOnBoarding, value: false);
                        }
                      } ,
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 150.h,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        index = _controller.page!.round();
      });
    });
  }
}