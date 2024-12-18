import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget onBoardingWidget({
  required String title,
  required BuildContext context,
  required Function() onPressed,
  required String frame,
  required String dis,
  required String topImage,
}){
  return Padding(
    padding:  REdgeInsets.symmetric(
      horizontal: 44
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(topImage,height: 200.h,),
      //  Center(child: SvgPicture.asset(image,matchTextDirection: true,)),
        SizedBox(
          height: 48.h,
        ),
        Text(title,style: Theme.of(context).textTheme.bodyLarge!,),
        SizedBox(
          height: 16.h,
        ),
        Text(dis,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),

        // SvgPicture.asset(frame,matchTextDirection: true),

      ],
    ),
  );
}