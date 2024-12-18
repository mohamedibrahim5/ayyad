import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../shared/resources/colors_manager.dart';

class PinPutWidgetOtp extends StatelessWidget {
  const PinPutWidgetOtp({super.key,required this.onCompleted,required this.onChanged,this.length = 6});
  final void Function(String)? onCompleted ;
  final void Function(String)? onChanged ;
  final int length ;

  @override
  Widget build(BuildContext context) {
    return   Pinput(
      separatorBuilder: (index) => SizedBox(
        width: 16.w,
      ),
      closeKeyboardWhenCompleted: true,
      length: length,
      onCompleted: onCompleted ,
      onChanged:onChanged ,
      mainAxisAlignment: MainAxisAlignment.center,
      submittedPinTheme:PinTheme(
          textStyle:Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp
          ),
          // margin: REdgeInsets.symmetric(
          //     horizontal: 17,
          //     vertical: 11
          // ),


          // padding: REdgeInsets.symmetric(
          //   horizontal: 17,
          //   vertical: 11
          // ),
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
              color:Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(
              color:  Theme.of(context).disabledColor,
              width: 1.w
            )

          )
      ) ,
      focusedPinTheme:PinTheme(
          textStyle:Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp
          ),
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
              color:Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              border: Border.all(
                  color:  Theme.of(context).primaryColor,
                  width: 1.w
              )

          )
      ) ,
      followingPinTheme:PinTheme(
          textStyle:Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp
          ),
          width: 45.w,
          height: 45.h,
          decoration: BoxDecoration(
              color:Colors.transparent,
              border: Border.all(
                  color:  ColorsManager.greyTextColor.withOpacity(0.6),
                  width: 1.w
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
          )
      )  ,
    );
  }
}
