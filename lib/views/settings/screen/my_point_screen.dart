import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';

import '../../../shared/resources/constant.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../home/cubit/home_cubit.dart';

class MyPointScreen extends StatefulWidget {
  const MyPointScreen({super.key});

  @override
  State<MyPointScreen> createState() => _MyPointScreenState();
}

class _MyPointScreenState extends State<MyPointScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child:state is HomeGetProfile || state is HomeUpdateProfile || state is HomeLoadingUpdateState ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ArrowBack(
                    onPressed: (){
                      sl<NavigationService>().popup();
                    },
                    title: StringsManager.myPoints.tr(),
                  ),
                  Padding(
                    padding:  REdgeInsets.symmetric(
                        vertical: 24
                    ),
                    child: Image.asset(!ThemeCubit.get(context).isDark ? AssetsManager.myPoints2:AssetsManager.myPointDark,matchTextDirection: true,),
                  ),
                  Text(
                    StringsManager.referAndEarn.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    StringsManager.referAndEarnDesc.tr(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsManager.greyTextScreen3,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              StringsManager.myPoints.tr(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              '${HomeCubit.get(context).getProfileResponse?.points ?? 0} PTS',
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp
                              ),
                            ),
                          ],
                        ),

                        Container(
                          height: 60.h,
                          width: 1.w,
                          color: ColorsManager.greyTextScreen3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              StringsManager.cashBack.tr(),
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              ' ${HomeCubit.get(context).getProfileResponse?.cashback ?? 0}${StringsManager.priceOfProduct.tr()}',
                              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),





                ],
              ): const Center(child:  LoadingIndicatorWidget(),),
              // ),
              //  ),
            ),
          ),
        );
      },
    ) ;
  }

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getProfile();
  }
}