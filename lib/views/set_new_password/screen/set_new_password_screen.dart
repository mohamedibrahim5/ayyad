import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/text_above_textfield.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';

import '../../../model/requests/reset_pass_request.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/logo_reusable.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../../shared/resources/validation.dart';
import '../cubit/set_new_password_screen_cubit.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  late TextEditingController _passwordController ;
  late TextEditingController _confirmPasswordController ;
  late String token ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool upperCase = false;
  bool minNumber = false;
  bool eightChar = false;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    // final String emailAddress = arguments[Constants.emailAddress.isEmpty] ?? 'test@gmail.com';
    final String phoneNumber = arguments[Constants.phoneNumber] ?? '';
    final String otpText = arguments[Constants.otpText] ?? '';
     token = arguments['token'] ?? '' ;
    return  BlocProvider(
        create: (context) => sl<SetNewPasswordCubit>(),
        child: BlocConsumer<SetNewPasswordCubit,SetNewPasswordState>(
          listener: (BuildContext context, state) {
            if(state is ResetPasswordSuccessState){
              // sl<PrefsHelper>().setToken2(state.resetPasswordSuccessResponse.token ?? '');
              // sl<PrefsHelper>().setData(key: Constants.guestCheck, value: false);
              // HomeCubit.get(context).getProfileResponse = GetProfileResponse(
              //   fullName: state.resetPasswordSuccessResponse.fullName,
              //   phone: state.resetPasswordSuccessResponse.phone,
              //   email: state.resetPasswordSuccessResponse.email,
              // );
              sl<NavigationService>().navigateReplacementTo(RoutesManager.loginScreen);
              Utils.showSnackBar(state.resetPasswordSuccessResponse.message ?? '',context);
              // sl<NavigationService>().popup();
              // sl<NavigationService>().navigateReplacementTo(RoutesManager.loginScreen,);
              // sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen,
              //     arguments: {
              //       Constants.guest:false,
              //     });
            }else if (state is ResetPasswordErrorState) {
              Utils.showSnackBar(state.message,context);
            }
          },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              body: Form(
                key: formKey,
                child: SafeArea(
                  child: Padding(
                    padding:  REdgeInsets.all(
                        16
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ArrowBack(
                          title: StringsManager.resetPassword.tr(),
                          onPressed: (){
                            sl<NavigationService>().popup();
                          },
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                       const LogoReusable(),
                        SizedBox(
                          height: 24.h,
                        ),

                        // SizedBox(
                        //   height: 40.h,
                        // ),
                        TextAboveTextField(
                          title: StringsManager.password.tr(),
                        ),
                        CustomFormField(
                          hint: StringsManager.enterNewPassword.tr(),
                          //   label: StringsManager.password,
                          controller: _passwordController,
                          filled: true,
                          keyboard: TextInputType.visiblePassword,
                          action: TextInputAction.next,
                          isPassword: true,
                          validator: CustomValidation.passwordValidation,
                          onChanged: (value){
                            if(value.length >= 8) {
                              setState(() {
                                eightChar = true;
                              });
                            }
                            else{
                              setState(() {
                                eightChar = false;
                              });
                            }
                            if(value.contains(RegExp(r'[A-Z]'))){
                              setState(() {
                                upperCase = true;
                              });
                            }
                            else{
                              setState(() {
                                upperCase = false;
                              });
                            }
                            if(value.contains(RegExp(r'[0-9]'))){
                              setState(() {
                                minNumber = true;
                              });
                            }
                            else{
                              setState(() {
                                minNumber = false;
                              });
                            }
                          },
                          inputFormatters: [
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              if (newValue.text.length > 20) {
                                return oldValue;
                              }
                              return newValue;
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.confirmPassword.tr(),
                        ),
                        CustomFormField(
                          hint: StringsManager.confirmNewPassword.tr(),
                          //   label: StringsManager.confirmPassword,
                          controller: _confirmPasswordController,
                          filled: true,
                          keyboard: TextInputType.visiblePassword,
                          action: TextInputAction.done,
                          isPassword: true,
                          validator: CustomValidation.confirmPasswordValidation,
                          inputFormatters: [
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              if (newValue.text.length > 20) {
                                return oldValue;
                              }
                              return newValue;
                            }),
                          ],
                        ),


                        const Spacer(),
                        Padding(
                          padding: REdgeInsets.only(
                              // top: 75,
                              left: 28,
                              right: 28
                          ),
                          child: Center(
                            child:state is ResetPasswordLoadingState ? const LoadingIndicatorWidget()  : MainButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  _resetPassword(context: context,phone: phoneNumber,otp: otpText);
                                }
                              },
                              title: StringsManager.done.tr(),
                            ),
                          ),
                        ),
                        const Spacer(),

                      ],
                    ),
                  ),
                ),
              ),
            ) ;
          },
        )
    );
  }

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  void _resetPassword({required BuildContext context,phone,otp}) {

    final resetPasswordRequest = ResetPasswordRequest(
        phone:phone ,
        otp: otp,
        password: _passwordController.text
    );
    SetNewPasswordCubit.get(context).resetPassword(resetPasswordRequest: resetPasswordRequest,token: token);
  }

}
