import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/views/home/cubit/order_status_cubit.dart';
import 'package:ibnelbarh/views/splash/cubit/splash_cubit.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../socket/socket_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SocketCubit socketCubit;
  late bool showOnBoarding;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit,SplashState>(
      listener: (BuildContext context, state) {
        if(state is OrganizationSuccess){
          sl<NavigationService>().navigateReplacementTo(showOnBoarding ? RoutesManager.firstScreen : RoutesManager.baseScreen);
          OrderStatusCubit.get(context).trackOrderStatus();
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          backgroundColor:  ColorsManager.primaryColor,
          body: SafeArea(
            child: Center(
                child:
                Image.asset('assets/images/Untitled_design_17.gif',height: double.infinity,width: 500.w,)
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    showOnBoarding = sl<PrefsHelper>().checkOnBoarding();

    if(sl<PrefsHelper>().getToken2().isEmpty && sl<PrefsHelper>().getSession2().isEmpty){
      // HomeCubit.get(context).addSession();
    }else {
      socketCubit = context.read<SocketCubit>();
      socketCubit.init();
      OrderStatusCubit.get(context).listen(socketCubit);
    }


    Future.delayed(const Duration(seconds: 7), () {
      if(sl<PrefsHelper>().getOrganizationId() == 0){
        getOrganization();
      }else {
        trackOrder();
      }

    });



    super.initState();
  }
  getOrganization(){
    SplashCubit.get(context).getOrganization(
      domain: 'IbnElBahr',
    );
  }
  trackOrder(){
    sl<NavigationService>().navigateReplacementTo(showOnBoarding ? RoutesManager.firstScreen : RoutesManager.baseScreen);
    OrderStatusCubit.get(context).trackOrderStatus();
  }
}



// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   late final SocketCubit socketCubit;
//   late bool showOnBoarding;
//   // bool showLogo = false ;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SplashCubit,SplashState>(
//       listener: (BuildContext context, state) {
//         if(state is OrganizationSuccess){
//           sl<NavigationService>().navigateReplacementTo(showOnBoarding ? RoutesManager.firstScreen : RoutesManager.baseScreen);
//           OrderStatusCubit.get(context).trackOrderStatus();
//         }
//       },
//       builder: (BuildContext context, Object? state) {
//         return Scaffold(
//           backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
//           body: Image.asset('assets/images/logoGif.gif',height: double.infinity,),
//         );
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     showOnBoarding = sl<PrefsHelper>().checkOnBoarding();
//
//     if(sl<PrefsHelper>().getToken2().isEmpty && sl<PrefsHelper>().getSession2().isEmpty){
//       // HomeCubit.get(context).addSession();
//     }else {
//       socketCubit = context.read<SocketCubit>();
//       socketCubit.init();
//       OrderStatusCubit.get(context).listen(socketCubit);
//     }
//
//
//     // Future.delayed(const Duration(seconds: 2), () {
//     //   setState(() {
//     //     showLogo = true;
//     //   });
//     // });
//     Future.delayed(const Duration(seconds: 4), () {
//       if(sl<PrefsHelper>().getOrganizationId() == 0){
//         SplashCubit.get(context).getOrganization(
//           domain: 'Hwawshi Elrabe',
//         );
//       }else {
//         sl<NavigationService>().navigateReplacementTo(showOnBoarding ? RoutesManager.firstScreen : RoutesManager.baseScreen);
//         OrderStatusCubit.get(context).trackOrderStatus();
//       }
//
//     });
//
//
//
//     super.initState();
//   }
// }