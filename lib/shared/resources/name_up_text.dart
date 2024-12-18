import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget nameUpTextFormField({
  required String title,
  required BuildContext context,
  double? bottom
}){
  return Padding(
    padding:  REdgeInsets.only(
      bottom:bottom ??  8
    ),
    child: Text(title,style: Theme.of(context).textTheme.bodySmall!.copyWith(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400
    ),),
  );
}