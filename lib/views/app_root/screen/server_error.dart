import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';

import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';

class ServerErrorScreen extends StatelessWidget {
  const ServerErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       body: GestureDetector(
         onTap: (){
           sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen);
         },
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Center(child: Lottie.asset('assets/lottie/Animation - 1721219093848.json',width: 150.w,height: 200.h)),
             Padding(
               padding:  REdgeInsets.only(
                   top: 38,
                   bottom: 8
               ),
               child: Text('Sorry The Server Is Out ',style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                   fontSize: 16.sp,
                   fontWeight: FontWeight.w600
               )
               ),
             ),

             Text('Press To Try Again',style:Theme.of(context).textTheme.displaySmall!.copyWith(
                 fontSize: 14.sp,
                 fontWeight: FontWeight.w400
             )
             ),
           ],
         ),
       ),
    );
  }
}
