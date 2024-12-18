import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../base_button_bar/cubit/base_screen_navigation_cubit.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     InkWell(
        //         splashColor: Colors.transparent,
        //         highlightColor: Colors.transparent,
        //         onTap: (){
        //           BaseScreenNavigationCubit.get(context).reset();
        //         },
        //         child: Padding(
        //           padding:  REdgeInsets.only(
        //               right: 16
        //           ),
        //           child: Icon(
        //             Icons.arrow_back_ios,
        //             color: Theme.of(context).canvasColor,
        //             size: 24.sp,
        //           ),
        //         )
        //     ),
        //
        //     Text(
        //         StringsManager.cart,
        //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //             fontWeight: FontWeight.w600,
        //             fontSize: 16.sp
        //         )
        //     ),
        //     InkWell(
        //         splashColor: Colors.transparent,
        //         highlightColor: Colors.transparent,
        //         onTap: (){
        //           // BaseScreenNavigationCubit.get(context).reset();
        //         },
        //         child: Padding(
        //           padding:  REdgeInsets.only(
        //               right: 16
        //           ),
        //           child: Icon(
        //             Icons.arrow_back_ios,
        //             color: Colors.transparent,
        //             size: 24.sp,
        //           ),
        //         )
        //     ),
        //   ],
        // ),
        ArrowBack(
          title: StringsManager.cart.tr(),
          onPressed: (){
            BaseScreenNavigationCubit.get(context).reset();
            // sl<NavigationService>().popup() ;
          },
        ),
        SizedBox(
          height: 24.h,
        ),
        const Spacer(),
        Center(child: Image.asset(!ThemeCubit.get(context).isDark ?  AssetsManager.emptyCart:AssetsManager.emptyCartDark)),
        Center(
          child: Padding(
            padding:  REdgeInsets.only(
              top: 38,
              bottom: 8
            ),
            child: Text(StringsManager.cartEmpty.tr(),style:Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600
             )
            ),
          ),
        ),

        Center(
          child: Text(StringsManager.cartEmpty2.tr(),style:Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w400
          )
          ),
        ),
        const Spacer(),

      ],
    );
  }
}
