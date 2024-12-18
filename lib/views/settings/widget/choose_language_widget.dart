import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';

class ChooseLanguageWidget extends StatefulWidget {
  const ChooseLanguageWidget({super.key});

  @override
  State<ChooseLanguageWidget> createState() => _ChooseLanguageWidgetState();
}

class _ChooseLanguageWidgetState extends State<ChooseLanguageWidget> {
  late bool isEnglish;
  @override
  Widget build(BuildContext context) {


    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Text(
              StringsManager.chooseLanguage.tr(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            Padding(
              padding:  REdgeInsets.all(6.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(AssetsManager.sharkIconDialog)),
            ),

          ],
        ),

        SizedBox(
          height: 16.h,
        ),
        GestureDetector(
          onTap: (){
            setState(() {

              isEnglish = true ;
            });

          },
          child: Row(
            children: [

              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: isEnglish ? ColorsManager.primaryColor : ColorsManager.greyTextColor,
                    width: 1.w,
                  ),
                ),
                child: isEnglish ? Center(
                  child: Container(
                    height: 8.h,
                    width: 8.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ) : Container(),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                StringsManager.english.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              isEnglish = false ;
            });

          },
          child: Row(
            children: [

              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: !isEnglish ? ColorsManager.primaryColor : ColorsManager.greyTextColor,
                    width: 1.w,
                  ),
                ),
                child: !isEnglish ? Center(
                  child: Container(
                    height: 8.h,
                    width: 8.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ) : Container(),
              ),
              SizedBox(
                width: 12.w,
              ),
              Text(
                StringsManager.arabic.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 28.h,
        ),
        MainButton(onPressed: (){
          if(isEnglish){
            context.setLocale(const Locale('en'));
          }else{
            context.setLocale(const Locale('ar'));
          }
          sl<NavigationService>().popup();
        }, title: StringsManager.updateLanguage.tr()),
        SizedBox(
          height: 28.h,
        ),





      ],
    );
  }


  @override
  void didChangeDependencies() {
    if(context.locale.languageCode == 'en') {
      isEnglish = true;
    }else{
      isEnglish = false;
    }
    super.didChangeDependencies();
  }
}
