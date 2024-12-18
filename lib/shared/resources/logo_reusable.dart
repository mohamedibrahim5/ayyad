import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'assets_manager.dart';

class LogoReusable extends StatelessWidget {
  const LogoReusable({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Image.asset(AssetsManager.logo,height: 85.h,width: 85.w,));

  }
}
