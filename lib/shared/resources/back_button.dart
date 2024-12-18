import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';

import 'assets_manager.dart';
import 'navigation_service.dart';

class BackButtonReusable extends StatelessWidget {
  const BackButtonReusable({super.key,required this.title});
  final String title ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  REdgeInsets.only(
        bottom: 24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: (){
                sl<NavigationService>().popup();
              },
              child:  SvgPicture.asset(AssetsManager.arrowLeft,matchTextDirection: true,)
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(title,style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}

EdgeInsetsGeometry paddingDefaultScreen(){
  return REdgeInsets.only(
    top: 29,
    right: 24,
    left: 24,
  );
}