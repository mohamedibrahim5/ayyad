import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_manager.dart';

Widget dividerWidget({double? bottom,double? top }){
  return Padding(
    padding:  REdgeInsets.only(
        bottom:bottom ?? 16,
        top: top ?? 0
    ),
    child: const Divider(
      height: 1,
      
      color: ColorsManager.dividerColor,
    ),
  );
}