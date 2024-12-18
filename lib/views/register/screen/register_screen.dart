import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:ibnelbarh/shared/resources/text_above_textfield.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/formatter.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/logo_reusable.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/phone.field.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../../shared/resources/utils.dart';
import '../../../shared/resources/validation.dart';
import '../cubit/register_cubit.dart';
import '../../../model/requests/register_request.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailAddressController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _confirmPasswordController;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _emailFocusNode;
  late FocusNode _phoneFocusNode;
  String errorTextEmail = '';
  String errorTextPhone = '';
  String errorTextName = '';
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]*$');
  Country? phoneNumber ;
  bool selectPhone = false ;



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (BuildContext context, state) {
          if (state is RegisterErrorState) {
            testValidation(state.userRegisterErrorResponse.phone,
                state.userRegisterErrorResponse.email);
            setState(() {
              errorTextEmail = state.userRegisterErrorResponse.email ?? '';
              errorTextPhone = state.userRegisterErrorResponse.phone ?? '';
              if(state.userRegisterErrorResponse.phone != null){
                Utils.showSnackBar(state.userRegisterErrorResponse.phone ?? '', context);
              }
              if(state.userRegisterErrorResponse.isVerified == false){
                _navigateOtp();
              }
            });
            formKey.currentState!.validate();
             errorTextEmail = '';
             errorTextPhone = '';
          } else if (state is RegisterSuccessState) {
            if (state.userRegisterSuccessResponse.isVerified ?? true) {
              _navigateOtp();
            } else {
              testValidation(state.userRegisterSuccessResponse.phone,
                  state.userRegisterSuccessResponse.email);
              _navigateOtp();
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: SafeArea(
                child: Padding(
                  padding: REdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ArrowBack(
                          title: StringsManager.signUp.tr(),
                          onPressed: (){
                            sl<NavigationService>().popup() ;
                          },
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                       const LogoReusable(),
                        SizedBox(
                          height: 24.h,
                        ),

                        TextAboveTextField(
                          title: StringsManager.fullName.tr(),
                        ),

                        CustomFormField(
                          hint: StringsManager.enterFullName.tr(),
                          //  label: StringsManager.fullName,
                          controller: _fullNameController,
                          inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                          filled: true,
                          keyboard: TextInputType.text,
                          action: TextInputAction.next,
                          validator: (value){
                            return CustomValidation.nameValidation(value,errorTextName);
                          },
                        ),

                        SizedBox(
                          height: 16.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.emailAddress.tr(),
                        ),

                        CustomFormField(
                          focusNode: _emailFocusNode,
                          hint: StringsManager.enterEmail.tr(),
                          //   label: StringsManager.emailAddress,
                          controller: _emailAddressController,
                          filled: true,
                          keyboard: TextInputType.emailAddress,
                          action: TextInputAction.next,
                          validator: (value){
                            return CustomValidation.emailValidation(value,errorTextEmail);
                          },
                        ),
                        SizedBox(
                          height: 16.h,
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
                          hint: StringsManager.enterPassword2.tr(),
                          controller: _passwordController,
                          filled: true,
                          keyboard: TextInputType.visiblePassword,
                          action: TextInputAction.next,
                          isPassword: true,
                          validator: CustomValidation.passwordValidation,
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
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
                          validator:
                          CustomValidation.confirmPasswordValidation,
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  if (newValue.text.length > 20) {
                                    return oldValue;
                                  }
                                  return newValue;
                                }),
                          ],
                        ),


                        // PhoneField(
                        //   focusNode: phoneNode,
                        //   controller: _phoneController,
                        //   onChange: (value) {
                        //     phoneNumber = value ;
                        //   },
                        //   label: "",
                        //   placeholder: "e.g. 915981847",
                        //   validator: CustomValidation.phoneValidator,
                        //   action: TextInputAction.done,
                        // ),

                        SizedBox(
                          height: 48.h,
                        ),
                        Center(
                          child: Padding(
                            padding: REdgeInsets.symmetric(horizontal: 28),
                            child: state is RegisterLoadingState
                                ? const LoadingIndicatorWidget()
                                : MainButton(
                                    onPressed: () {
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
                                            RegisterCubit.get(context).register(
                                                userRegisterRequest: UserRegisterRequest(
                                                    fullName:
                                                    _fullNameController.text,
                                                    email: _emailAddressController
                                                        .text,
                                                    phone: phoneNumber!.dialCode + _phoneController.text,
                                                    //     '+1${_phoneController.text}',
                                                    password:
                                                    _passwordController.text));

                                          });
                                        }
                                      }




                                    },
                                    title: StringsManager.signUp.tr(),
                                  ),
                          ),
                        ),

                        Padding(
                          padding: REdgeInsets.only(
                            top: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Text(
                                StringsManager.alreadyHaveAccount.tr(),
                                style:Theme.of(context).textTheme.displaySmall!.copyWith(
                                    fontSize: 14.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  sl<NavigationService>()
                                      .navigateTo(
                                          RoutesManager.loginScreen);
                                },
                                child: Text(
                                  StringsManager.login.tr(),
                                  style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _navigateOtp() {
    sl<NavigationService>().navigateTo(RoutesManager.otpScreen, arguments: {
      Constants.phoneNumber: phoneNumber!.dialCode + _phoneController.text,
      Constants.emailAddress: _emailAddressController.text,
      Constants.checkNavigateForgetPasswordOrRegister: false
    });
  }

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    phoneNumber = Constants.selectedCountry;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
  }

  testValidation(String? phone, String? email) {
    if (phone != null) {
      // Utils.showSnackBar(phone ?? '');
      _phoneFocusNode.requestFocus();
    } else if (email != null) {
      // Utils.showSnackBar(email ?? '');
      _emailFocusNode.requestFocus();
    }
  }
}
