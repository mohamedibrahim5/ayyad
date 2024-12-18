import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({super.key,required this.errorTextDiscount,required this.promoCodeController,required this.promoCodeFocusNode,required this.deliveryFees,});
  final String errorTextDiscount ;
  final TextEditingController promoCodeController ;
  final FocusNode promoCodeFocusNode ;
   final double deliveryFees ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit,CartState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return Padding(
          padding:  REdgeInsets.symmetric(
              vertical: 16
          ),
          child: Container(
            width: double.infinity,
            decoration:!ThemeCubit.get(context).isDark ?
            BoxDecoration(
                color: ColorsManager.backgroundColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.blackColorShadow.withOpacity(0.12),
                    spreadRadius: 0,
                    blurRadius: 8.r,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]
            ):null,
            child: Padding(
              padding:  REdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AssetsManager.addPromoCode2),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        StringsManager.saveOnYourOrder.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: 44.h,
                    child: CustomFormField(
                      enabled: deliveryFees == 0 ? true : false,
                      top: 0,
                      focusNode: promoCodeFocusNode,
                      validator:(value){
                        return null ;
                      },
                      addPrefix: true,
                      prefixIcon: UnconstrainedBox(
                        child: SvgPicture.asset(
                          AssetsManager.addPromoCode,height:16.h ,width: 16.w,matchTextDirection: true,
                        ),
                      ),
                      hint: StringsManager.addPromoCode.tr(),
                      //   label: StringsManager.phone,
                      controller: promoCodeController,
                      filled: true,
                      keyboard: TextInputType.name,
                      action: TextInputAction.done,
                      isPassword: true,
                      obscureText: false,
                      suffixIcon:state is AddCoupanLoadingState ? const SizedBox(
                        width: 2,
                        height: 2,
                        child: LoadingIndicatorWidget(
                          isCircular: false,
                        ),
                      ) : UnconstrainedBox(
                        child:   GestureDetector(
                          onTap: () async {
                            if(deliveryFees == 0 ){
                              if(promoCodeController.text.isNotEmpty){
                                FocusManager.instance.primaryFocus?.unfocus();
                                await  CartCubit.get(context).addCoupon(coupon: promoCodeController.text);
                              }
                            }else {
                              promoCodeController.clear();
                             await CartCubit.get(context).removeCoupon();
                            }

                          },
                          child: Padding(
                            padding:  REdgeInsets.only(
                                right: 0
                            ),
                            child: Container(
                              height: 44.h,
                              decoration: BoxDecoration(
                                  color:deliveryFees == 0 ? ColorsManager.primaryColor:ColorsManager.greyText,
                                  borderRadius:BorderRadius.only(
                                    topRight: Radius.circular(10.r),
                                    bottomRight: Radius.circular(10.r),
                                  )
                              ),
                              child: Padding(
                                padding:  REdgeInsets.symmetric(
                                    horizontal: 27
                                ),
                                child: Center(
                                  child: Text(
                                    StringsManager.apply.tr(),
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if(deliveryFees !=0)
                    SizedBox(
                      height: 4.h,
                    ),
                  if(deliveryFees !=0)
                    GestureDetector(
                      onTap: () async {
                        promoCodeController.clear();
                        await CartCubit.get(context).removeCoupon();
                      },
                      child: Text(
                        StringsManager.removePromoCode.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: ColorsManager.primaryColor
                        ),
                      ),
                    ),



                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }
}
