

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/model/requests/reset_pass_request.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/text_above_textfield.dart';
import 'package:ibnelbarh/shared/resources/text_form_field_reusable.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/shared/resources/validation.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _oldPasswordController ;
  late TextEditingController _passwordController ;
  late TextEditingController _confirmPasswordController ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool upperCase = false;
  bool minNumber = false;
  bool eightChar = false;
  String errorTextPassword = '';
  late FocusNode _passwordFocusNode;


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SettingsCubit,SettingsState>(
      listener: (BuildContext context, state) {
        if(state is SettingsErrorChangePassword){
          setState(() {
              _passwordFocusNode.requestFocus();
              errorTextPassword = state.message ;
              formKey.currentState!.validate();
              errorTextPassword = '';
          });
        }else if (state is ChangePasswordSuccess ){
          sl<NavigationService>().popup();
          Utils.showSnackBar(state.changePasswordSuccess.message ?? '',context);
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
                    // ArrowBack(
                    //   title: StringsManager.changePassword,
                    //   onPressed: (){
                    //     sl<NavigationService>().popup();
                    //   },
                    // ),
                    // SizedBox(
                    //   height: 40.h,
                    // ),

                    ArrowBack(
                      title: StringsManager.changePassword.tr(),
                      onPressed: (){
                        sl<NavigationService>().popup();
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    //LogoReusable()
                    // SizedBox(
                    //   height: 24.h,
                    // ),



                    TextAboveTextField(
                      title: StringsManager.oldPassword.tr(),
                    ),
                    CustomFormField(
                      focusNode: _passwordFocusNode,
                      hint: StringsManager.enterOldPassword.tr(),
                      //   label: StringsManager.password,
                      controller: _oldPasswordController,
                      filled: true,
                      keyboard: TextInputType.visiblePassword,
                      action: TextInputAction.next,
                      isPassword: true,
                      validator:(value){
                        return CustomValidation.passwordValidation(value,error: errorTextPassword);
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
                      title: StringsManager.newPassword.tr(),
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
                      title: StringsManager.confirmNewPasswordText.tr(),
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

                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 16.w,
                    //       height: 16.h,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: eightChar ? ColorsManager.greyTextScreen : ColorsManager.greyTextScreen2,
                    //       ),
                    //       child: Center(
                    //         child: SvgPicture.asset(AssetsManager.check,matchTextDirection: true,),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 4.w,
                    //     ),
                    //     Text(
                    //       StringsManager.condition1,
                    //       style:eightChar ?  Theme.of(context).textTheme.displaySmall!.copyWith(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 12.sp
                    //       ): Theme.of(context).textTheme.displayMedium,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 16.w,
                    //       height: 16.h,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: upperCase ? ColorsManager.greyTextScreen : ColorsManager.greyTextScreen2,
                    //       ),
                    //       child: Center(
                    //         child: SvgPicture.asset(AssetsManager.check,matchTextDirection: true,),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 4.w,
                    //     ),
                    //     Text(
                    //       StringsManager.condition2,
                    //       style:upperCase ?  Theme.of(context).textTheme.displaySmall!.copyWith(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 12.sp
                    //       ): Theme.of(context).textTheme.displayMedium,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 4.h,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 16.w,
                    //       height: 16.h,
                    //       decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: minNumber ? ColorsManager.greyTextScreen : ColorsManager.greyTextScreen2,
                    //       ),
                    //       child: Center(
                    //         child:SvgPicture.asset(AssetsManager.check,matchTextDirection: true,),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 4.w,
                    //     ),
                    //     Text(
                    //       StringsManager.condition3,
                    //       style:minNumber ?  Theme.of(context).textTheme.displaySmall!.copyWith(
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 12.sp
                    //       ): Theme.of(context).textTheme.displayMedium,
                    //     ),
                    //   ],
                    // ),

                    Padding(
                      padding: REdgeInsets.only(
                          // top: 75,
                          left: 28,
                          right: 28
                      ),
                      child: Center(
                        child:state is SettingsChangePassword ? const LoadingIndicatorWidget(): MainButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              if(_oldPasswordController.text == _passwordController.text){
                                Utils.showSnackBar(StringsManager.passwordMatch.tr(),context);
                                return;
                              }
                              SettingsCubit.get(context).changePassword(resetPasswordRequest: ChangePasswordRequest(
                                  oldPassword: _oldPasswordController.text,
                                  newPassword: _passwordController.text,
                              ));
                            }
                          },
                          title: StringsManager.saveText.tr(),
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
    );
  }

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _oldPasswordController.dispose();
    _passwordFocusNode.dispose();
  }

}
