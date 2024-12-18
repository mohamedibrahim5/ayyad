import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/model/responses/get_profile_response.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/views/home/cubit/home_cubit.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../../../model/requests/otp_verfiy_request.dart';
import '../../../model/requests/resend_otp_request.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/enums.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/print_func.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../base_button_bar/cubit/base_screen_navigation_cubit.dart';
import '../cubit/otp_cubit.dart';
import '../widget/pin_put_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hideButton = false ;
  Duration? time ;
  bool enableResend = false ;
  String? otp ;
  @override
  initState() {
    super.initState();
  }


  @override
  dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    // final String emailAddress = arguments[Constants.emailAddress.isEmpty] ?? 'test@gmail.com';
     final String phoneNumber = arguments[Constants.phoneNumber] ?? '';
    final bool forgetPassword = arguments[Constants.checkNavigateForgetPasswordOrRegister] ?? false;
    return BlocConsumer<OtpCubit,OtpState>(
      listener: (BuildContext context, state) {
        if(state is OtpSuccessState){
          if(forgetPassword){
            sl<NavigationService>().navigateTo(RoutesManager.setNewPassword,arguments:{
              Constants.phoneNumber:phoneNumber,
              Constants.otpForgetPassword:forgetPassword,
              Constants.otpText:otp,
              'token':state.clientOtpVerifySuccessResponse.userOtpVerifyDataResponse?.access ?? ''
            } );
          }else {
            sl<PrefsHelper>().setToken2(state.clientOtpVerifySuccessResponse.userOtpVerifyDataResponse?.access ?? '');
            sl<PrefsHelper>().setData(key: Constants.guestCheck, value: false);
            HomeCubit.get(context).getProfileResponse = GetProfileResponse(
              email: state.clientOtpVerifySuccessResponse.userOtpVerifyDataResponse?.profile?.email ?? '',
              phone: state.clientOtpVerifySuccessResponse.userOtpVerifyDataResponse?.profile?.phone ?? '',
              fullName:state.clientOtpVerifySuccessResponse.userOtpVerifyDataResponse?.profile?.fullName ?? ''
            );
            sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen,
                arguments: {
                  Constants.guest:false,
                }
            );
            BlocProvider.of<BaseScreenNavigationCubit>(context).getNavBarItem(HomeNavigationBarTabs.home);
          }

          // if(!forgetPassword){
          //   sl<PrefsHelper>().setToken(state.clientOtpVerifySuccessResponse.token ?? '');
          //   sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen,
          //       arguments: {
          //         Constants.guest:false,
          //       }
          //   );
          // }
          // sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.loginScreen,
          //     arguments: {
          //       Constants.guest:false,
          //     });
        }
        else if (state is OtpErrorState ){
          Utils.showSnackBar(state.message,context );
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:  REdgeInsets.all(
                  16
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    ArrowBack(
                      title: StringsManager.verify.tr(),
                      onPressed: (){
                        sl<NavigationService>().popup();
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     GestureDetector(
                    //         onTap: (){
                    //           sl<NavigationService>().popup();
                    //         },
                    //         child: Icon(
                    //           Icons.arrow_back_ios,
                    //           color: Theme.of(context).canvasColor,
                    //           size: 24.sp,
                    //         )
                    //     ),
                    //     Text(
                    //         StringsManager.verify,
                    //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 16.sp
                    //         )
                    //     ),
                    //     GestureDetector(
                    //         onTap: (){
                    //           sl<NavigationService>().popup();
                    //         },
                    //         child: Icon(
                    //           Icons.arrow_back_ios,
                    //           color: Colors.transparent,
                    //           size: 24.sp,
                    //         )
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Center(child: Image.asset(AssetsManager.lock)),

                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding:  REdgeInsets.symmetric(
                        horizontal: 60
                      ),
                      child: Text(
                        StringsManager.verifyPhone.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding:  REdgeInsets.only(
                          top: 59,
                          bottom: 16,
                      ),
                      child: PinPutWidgetOtp(
                        onChanged: (value){
                          printFunc(printName:'${value.length}skdjsk');
                          if(value.length == 6){
                            setState(() {
                              hideButton = true;
                            });
                          }else {
                            setState(() {
                              hideButton = false ;
                            });

                          }
                        },
                        onCompleted: (value){
                          otp = value ;
                          printFunc(printName:'${value}skdjsk');
                        },
                        length: 6,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        enableResend ?
                        Row(
                          children: [
                            Text('${StringsManager.reSendCode.tr()} (',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400
                            ),),
                            SlideCountdown(
                              onDone: (){
                                setState(() {
                                  enableResend = false ;
                                });
                              },
                              padding:  REdgeInsets.symmetric(horizontal: 0),
                              separator: ":", separatorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400
                            ),
                              duration: const Duration(minutes: 5),
                              style:Theme.of(context).textTheme.bodySmall!.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400
                              ) ,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(').',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400
                            ),),
                
                          ],
                        )  :
                        Text('${StringsManager.reSendCode.tr()}. ',style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                        ),),
                       state is ResendOtpLoadingState ? const LoadingIndicatorWidget(
                         isCircular: true,
                       ) :  GestureDetector(
                          onTap: enableResend ?  (){
                            Utils.showSnackBar(StringsManager.waitForTheTimer.tr(),context);
                          }: (){
                            setState(() {
                              OtpCubit.get(context).resendOtp(resendOtpRequest: ResendOtpRequest(phone: phoneNumber));
                              enableResend = true ;
                            });
                          },
                          child: Text(StringsManager.reSend.tr(),style:enableResend  ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ) :   Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    Center(
                      child: Padding(
                        padding:  REdgeInsets.symmetric(
                          horizontal: 28
                        ),
                        child:state is OtpLoadingState ? const LoadingIndicatorWidget() : MainButton(
                          width: double.infinity,
                            color:hideButton ? null : ColorsManager.primaryColor.withOpacity(0.55) ,
                            onPressed: (){
                              if(hideButton){
                                if(forgetPassword){
                                  OtpCubit.get(context).userOtp(userOtpVerifyRequest:
                                  UserOtpVerifyRequest(
                                      phone:phoneNumber,
                                      // phoneNumber,
                                      otp: otp ?? '',
                                      action: forgetPassword ? 'reset-password' : 'register'
                                  )
                                  );
                                }else {
                                 OtpCubit.get(context).userOtp(userOtpVerifyRequest:
                                 UserOtpVerifyRequest(
                                   phone:phoneNumber,
                                   // phoneNumber,
                                   otp: otp ?? '',
                                   action: forgetPassword ? 'reset-password' : 'register'
                                 )
                                 );
                                }
                              }
                            }, title: StringsManager.send.tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );
      }
    );
  }
}
