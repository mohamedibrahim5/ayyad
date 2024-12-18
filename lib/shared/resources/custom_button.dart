import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'colors_manager.dart';


class MainButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? color ;
  final double? width ;
  final bool isOneTitle ;
  final String title2 ;
  final Color? colorTitle ;
  final Color? colorBorder ;
  final BorderRadiusGeometry? borderRadius;
  const MainButton(
      {super.key,
        required this.onPressed,
        required this.title,
        this.color,
        this.colorTitle,
        this.borderRadius,
        this.width,this.isOneTitle = true,this.title2 = "",
        this.colorBorder
         });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed ,
      child: Container(
        height: 40.h,
        width:width ?? (isOneTitle ? double.infinity : null),
        decoration: BoxDecoration(
          color:color ??  Theme.of(context).primaryColor,
          borderRadius:borderRadius ??  BorderRadiusDirectional.circular(10.r),
          border:colorTitle == null ? null :  Border.all(
            color:colorBorder ??  ColorsManager.greyTextColor.withOpacity(0.5),
            width: 1
          )
        ),
        child: Padding(
          padding:  REdgeInsets.symmetric(
            horizontal:isOneTitle ?  28 : 16,
            vertical:   10
          ),
          child:isOneTitle ?
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: colorTitle ?? ColorsManager.whiteColor
              ),
            ),
          ) :
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp
                ),
              ),
              // SizedBox(
              //   width: 45.w,
              // ),
              Text(
                title2,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp
                ),
              ),
            ],
          )

        ),
      ),
    );
  }
}


class BasicButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? color ;
  final String icon ;
  const BasicButton(
      {super.key,
        required this.onPressed,
        required this.title,
        this.color,
        required this.icon
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed ,
      child: Container(
        decoration: BoxDecoration(
          color:color ??  ColorsManager.blue,
          borderRadius: BorderRadiusDirectional.circular(16.r),
        ),
        child: Padding(
          padding:  REdgeInsets.symmetric(
              vertical: 12.5
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon,colorFilter: const ColorFilter.mode(
                  ColorsManager.whiteColor, BlendMode.srcIn
              ),matchTextDirection: true),
              SizedBox(
                width: 10.sp,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16.sp
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}