import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/model/responses/get_extra_response.dart';
import 'package:ibnelbarh/model/responses/get_question_response.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';

import '../../../shared/resources/constant.dart';
import '../../../shared/resources/string_manager.dart';
import '../cubit/cart_cubit.dart';

class ChooseCartItem extends StatefulWidget {
   const ChooseCartItem({super.key,required this.extras,required this.questions});
  final Extras extras ;
  final Questions questions ;

  @override
  State<ChooseCartItem> createState() => _ChooseCartItemState();
}

class _ChooseCartItemState extends State<ChooseCartItem> {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.questions.click == 'RADIO' ?
                Container(
                  height: 18.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.extras.isSelectedCHECK! ? ColorsManager.primaryColor:ColorsManager.greyTextScreen,
                        width: 1.w
                    ),
                    color:Colors.transparent,
                    shape:widget.questions.click == 'RADIO' ?  BoxShape.circle:BoxShape.rectangle,
                  ),
                  child:  Center(
                    child: Container(
                      height: 9.h,
                      width: 9.w,
                      decoration:widget.questions.click == 'RADIO' ?  BoxDecoration(
                        color:widget.extras.isSelectedCHECK! ? ColorsManager.primaryColor :  Colors.transparent,
                        shape: BoxShape.circle,
                      ):null,
                      child: widget.questions.click == 'RADIO' ? null : Icon(Icons.check,color: widget.extras.isSelectedOPTIONAL! ? ColorsManager.primaryColor :  Colors.transparent,size: 9.sp,)
                    ),
                  ),
                ) :
                Container(
                  height: 18.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.extras.isSelectedOPTIONAL! ? ColorsManager.primaryColor:ColorsManager.greyTextScreen,
                        width: 1.w
                    ),
                    color:Colors.transparent,
                    shape:widget.questions.click == 'RADIO' ?  BoxShape.circle:BoxShape.rectangle,
                  ),
                  child:  Center(
                    child: Container(
                        height: 9.h,
                        width: 9.w,
                        decoration:widget.questions.click != 'RADIO' ?  BoxDecoration(
                          color:widget.extras.isSelectedCHECK! ? ColorsManager.primaryColor :  Colors.transparent,
                          shape: BoxShape.circle,
                        ):null,
                        child: widget.questions.click == 'RADIO' ? null : Icon(Icons.check,color: widget.extras.isSelectedOPTIONAL! ? ColorsManager.primaryColor :  Colors.transparent,size: 9.sp,)
                    ),
                  ),
                ) ,
                SizedBox(width: 6.w,),
                Text(widget.extras.title ?? '',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp
                ),)
              ],
            ),
            Text(widget.extras.price != null ? '(${StringsManager.priceOfProduct.tr()}${widget.extras.price})' :  '',style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
            ),)
          ],
        ) ;
      },
    );
  }
}
