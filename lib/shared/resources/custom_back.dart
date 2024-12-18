import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({super.key,required this.onPressed,required this.title,this.onPressedSearch,this.widget});
  final Function() onPressed;
  final String title ;
  final Function()? onPressedSearch;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell (
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onPressed,
            child: Padding(
              padding:  REdgeInsets.only(
                right:context.locale.languageCode == 'en' ?  16 : 0,
                left: context.locale.languageCode == 'en' ?  0 : 16
              ),
              child: SvgPicture.asset(
                AssetsManager.arrowLeft2,
                height: 24.sp,
                width: 24.sp,
                colorFilter: ColorFilter.mode(Theme.of(context).canvasColor, BlendMode.srcIn),
                matchTextDirection: true,
              ),
            )
        ),
        Text(
            title,
            style: Theme.of(context).textTheme.bodySmall
        ),
        onPressedSearch != null ?
        GestureDetector(
            onTap: onPressedSearch,
            child: Padding(
              padding:  REdgeInsets.only(
                left: 16,
              ),
              child: Icon(
                Icons.search,
                color: Theme.of(context).canvasColor,
                size: 24.sp,
              ),
            )
        ):
        widget ??
            GestureDetector(
            onTap: (){
            },
            child: Padding(
              padding:  REdgeInsets.only(
                left: 16,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
                size: 24.sp,
              ),
            )
        ),
      ],
    );
  }
}
