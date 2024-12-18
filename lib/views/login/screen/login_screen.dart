
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:ibnelbarh/shared/resources/prefs_helper.dart';
import 'package:ibnelbarh/shared/resources/text_above_textfield.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';

import '../../../model/requests/login_request.dart';
import '../../../model/responses/get_profile_response.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/enums.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/logo_reusable.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/phone.field.dart';
import '../../../shared/resources/print_func.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../../shared/resources/validation.dart';
import '../../base_button_bar/cubit/base_screen_navigation_cubit.dart';
import '../../home/cubit/home_cubit.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _passwordController ;
  late TextEditingController _phoneController ;
  Country? phoneNumber ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorTextPhone = '';
  String errorTextPassword = '';
  late FocusNode _phoneFocusNode;
  late FocusNode _passwordFocusNode;
  late Map args;
  late bool didFinish ;
  bool selectPhone = false ;







  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    phoneNumber = Constants.selectedCountry;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    didFinish = args["loginFinish"] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (BuildContext context, state) {
          printFunc(printName: state.toString());
          if(state is LoginSuccessState){
            if(state.loginSuccessResponse.isVerified ?? true) {
              sl<PrefsHelper>().setToken2(state.loginSuccessResponse.data!.access ?? '');
              sl<PrefsHelper>().setData(key: Constants.guestCheck, value: false);
              HomeCubit.get(context).getProfileResponse = GetProfileResponse(
                email: state.loginSuccessResponse.email,
                phone: state.loginSuccessResponse.phone,
                fullName: state.loginSuccessResponse.fullName,
              );
              sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen,
                  arguments: {
                    Constants.guest:false,
                  }
              );
              BlocProvider.of<BaseScreenNavigationCubit>(context).getNavBarItem(HomeNavigationBarTabs.home);
            }else {
              Utils.showSnackBar(state.loginSuccessResponse.message ?? '',context);
              sl<NavigationService>().navigateTo(RoutesManager.otpScreen,arguments:{
                Constants.phoneNumber:phoneNumber!.dialCode + _phoneController.text,
                Constants.checkNavigateForgetPasswordOrRegister:false
              });
            }
          }else if (state is LoginErrorState){
            setState(() {
              // Utils.showSnackBar(state.loginErrorResponse.message, context);

              if(state.loginErrorResponse.isVerified == false){
                _navigateOtp();
              }

              if(state.loginErrorResponse.phone != null){

                // _phoneFocusNode.requestFocus();
                 errorTextPhone = state.loginErrorResponse.phone!;
                // print('phone1${errorTextPhone}');
                // formKey.currentState!.validate();
                Utils.showSnackBar(errorTextPhone, context);
                // errorTextPhone = '';
              }else {
                _passwordFocusNode.requestFocus();
                errorTextPassword = state.loginErrorResponse.password ?? state.loginErrorResponse.message ?? '';
                formKey.currentState!.validate();
                errorTextPassword = '';
              }
            });

            // Utils.showSnackBar(state.message);
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            body: Form(
              key: formKey,
              child: SafeArea(
                child: Padding(
                  padding:  REdgeInsets.all(
                      16
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        !didFinish ?
                        ArrowBack(
                          title: StringsManager.login.tr(),
                          onPressed: (){
                            sl<NavigationService>().popup() ;
                          },
                        ) :
                        Center(
                          child: Text(
                              StringsManager.login.tr(),
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp
                              )
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        const LogoReusable(),
                        SizedBox(
                          height: 24.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.phone.tr(),
                        ),
                    
                        PhoneField(
                          onCountryChanged: (value){
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          country: phoneNumber ,
                          hintText: StringsManager.pleaseEnterPhone.tr(),
                          validation:selectPhone ,
                          focusNode: _phoneFocusNode,
                          controller: _phoneController,
                          label: "",
                          placeholder: "e.g. 915981847",
                          validator: (value){
                            if(value == null){
                              return StringsManager.required.tr();
                            }else if (_phoneController.text.isEmpty){
                              return StringsManager.required.tr();
                            }
                            return null ;
                          },
                          action: TextInputAction.next,
                        ),
                    
                    
                        SizedBox(
                          height: 16.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.password.tr(),
                        ),
                        CustomFormField(
                          focusNode: _passwordFocusNode,
                          hint: StringsManager.pleaseEnterPassword.tr(),
                          //  label: StringsManager.password,
                          controller: _passwordController,
                          filled: true,
                          keyboard: TextInputType.visiblePassword,
                          action: TextInputAction.done,
                          isPassword: true,
                          validator:(value){
                            return CustomValidation.nameValidation(value,errorTextPassword);
                          },
                          // CustomValidation.passwordValidation,
                          inputFormatters: [
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              if (newValue.text.length > 20) {
                                return oldValue;
                              }
                              return newValue;
                            }),
                          ],
                        ),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:  REdgeInsets.only(
                                  top: 8,
                                  bottom: 75
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder:(context){
                                  //   return const CartItemScreen();
                                  // }));
                                  sl<NavigationService>().navigateTo(RoutesManager.forgetPassword);
                                },
                                child: Text(
                                  StringsManager.forgetPassword.tr(),
                                  style:Theme.of(context).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                    
                        Padding(
                          padding:  REdgeInsets.only(
                              bottom: 6,
                              left: 44,
                              right: 44
                    
                          ),
                          child:state is LoginLoadingState ? const LoadingIndicatorWidget()  : MainButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                if( _phoneController.text.isEmpty){
                                  setState(() {
                                    selectPhone = true ;
                                    return ;
                                  });
                                }else {
                                  setState(() {
                                    selectPhone = false ;
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    LoginCubit.get(context).login(loginRequest: LoginRequest(
                                        phone: phoneNumber!.dialCode + _phoneController.text,
                                        // '+1${2819374192}',
                                        password: _passwordController.text));
                    
                                  });
                                }
                                printFunc(printName: _phoneController.text);
                              }
                    
                                //
                                // sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen,
                                //     arguments: {
                                //       Constants.guest:false,
                                //     }
                                // );
                            },
                            title: StringsManager.login.tr(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              StringsManager.noAccount.tr(),
                              style:Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                sl<NavigationService>().navigateTo(RoutesManager.registerScreen);
                              },
                              child: Text(
                                StringsManager.signUp.tr(),
                                style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp
                                ),
                              ),
                            )
                    
                          ],
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  _navigateOtp() {
    sl<NavigationService>().navigateTo(RoutesManager.otpScreen, arguments: {
      Constants.phoneNumber: phoneNumber!.dialCode + _phoneController.text,
      Constants.emailAddress: "_emailAddressController.text",
      Constants.checkNavigateForgetPasswordOrRegister: false
    });
  }


}
