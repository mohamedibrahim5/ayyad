import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'colors_manager.dart';
import 'top_center_half_circle_cliper_widget.dart';

showReusableDialog({required BuildContext context,required Widget widget, double? height, double? width,EdgeInsetsGeometry? padding,required String image}) {
  showDialog(
    context: context,
    builder: (_) => ReusableCustomDialog(cubitContext: context,widget: widget,height: height,width: width,padding: padding,image: image,),
  );
}

class ReusableCustomDialog extends StatelessWidget {
  const ReusableCustomDialog({super.key, required this.cubitContext,required this.widget,this.height, this.width,this.padding,required this.image});
  final BuildContext cubitContext;
  final Widget widget;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width?.w ?? double.infinity,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 24),
                child: ClipPath(
                  clipper: TopCenterHalfCircleClipper(radius: 40.r),
                  child: Container(
                    padding:padding ??  REdgeInsets.all(20) ,
                    decoration: BoxDecoration(
                      color: ColorsManager.backgroundColor,
                      borderRadius: BorderRadius.circular(20.r),
                      // shape:
                      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                      // contentPadding:padding ??  REdgeInsets.all(20),
                      // children: <Widget>[
                      //   widget,
                      // ]
                    ),
                    child: widget,
                    // backgroundColor: ColorsManager.backgroundColor,
                    //   shape:
                    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                      // contentPadding:padding ??  REdgeInsets.all(20),
                      // children: <Widget>[
                      //   widget,
                      // ]
                  ),
                ),
              ),
              Positioned(
                top: 8 , // Center the widget

                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: const BoxDecoration(
                    color: ColorsManager.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: GestureDetector(
                      // onTap: () {
                      //   Navigator.pop(cubitContext);
                      // },
                      child:
                      // Icon(Icons.close,color: ColorsManager.greyTextColor,size: 30.sp,),
                      SvgPicture.asset(
                        image,
                        matchTextDirection: true,
                        height: 30.h,
                        width: 30.w,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // Container(
        //   height: 70.h,
        //   width: 70.w,
        //   decoration: BoxDecoration(
        //     color: ColorsManager.backgroundColor,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Center(
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.pop(cubitContext);
        //       },
        //       child:Icon(Icons.close,color: ColorsManager.greyTextColor,size: 30.sp,),
        //       // SvgPicture.asset(
        //       //   'assets/icons/close.svg',
        //       //   color: ColorsManager.greyTextColor,
        //       //   height: 20.h,
        //       //   width: 20.w,
        //       // ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
