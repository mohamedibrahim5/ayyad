import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/text_above_textfield.dart';

import '../../../model/requests/forgot_pass_request.dart';
import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/phone.field.dart';
import '../../../shared/resources/routes_manager.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/utils.dart';
import '../cubit/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _phoneController ;
  // PhoneNumber? phoneNumber ;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorTextPhone = '';
  late FocusNode _phoneFocusNode;
  bool selectPhone = false ;
  Country? phoneNumber ;


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (context) => sl<ForgetPasswordCubit>(),
        child: BlocConsumer<ForgetPasswordCubit,ForgetPasswordState>(
          listener: (BuildContext context, state) {
            if(state is ForgotPassSuccessState){
              sl<NavigationService>().navigateReplacementTo(RoutesManager.otpScreen,arguments:{
                Constants.phoneNumber:'${phoneNumber!.dialCode}${_phoneController.text}',
                Constants.checkNavigateForgetPasswordOrRegister:state.forgotPassSuccessResponse.data!.isActive == null ? true :state.forgotPassSuccessResponse.data!.isActive! ? true : false,

              });
            }else if (state is ForgotPassErrorState){
              // sl<NavigationService>().navigateReplacementTo(RoutesManager.otpScreen,arguments:{
              //   Constants.phoneNumber:'+1${_phoneController.text}',
              //   Constants.checkNavigateForgetPasswordOrRegister:true,
              // });
              setState(() {
                if(state.message.isNotEmpty){
                  _phoneFocusNode.requestFocus();
                  errorTextPhone = state.message;
                  formKey.currentState!.validate();
                  errorTextPhone = '';
                  Utils.showSnackBar(state.message,context);
                }
              });
            }
          },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              body: Form(
                key: formKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  REdgeInsets.all(
                              16
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ArrowBack(
                                title: StringsManager.forgetPassword2.tr(),
                                onPressed: (){
                                  sl<NavigationService>().popup();
                                },
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                             Center(child: Image.asset(AssetsManager.lock)),
                              SizedBox(
                                height: 24.h,
                              ),
                              Padding(
                                padding:  REdgeInsets.symmetric(
                                  horizontal: 28
                                ),
                                child: Text(
                                  StringsManager.enterPhoneOrEmail.tr(),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w400,
                                    fontSize: 14.sp
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              SizedBox(
                                height: 32.h,
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
                                height: 75.h,
                              ),

                              Padding(
                                padding:  REdgeInsets.only(
                                    left: 28,
                                    right: 28

                                ),
                                child:state is ForgotPassLoadingState ? const LoadingIndicatorWidget()  : MainButton(
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
                                          _forgotPassword(contextBuild: context);

                                        });
                                      }
                                    }


                                    // if(formKey.currentState!.validate()){
                                    //   _forgotPassword(contextBuild: context);
                                    // }
                                  },
                                  title: StringsManager.send.tr(),
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
            ) ;
          },
        )
    );
  }

  @override
  void initState() {
    _phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();
    phoneNumber = Constants.selectedCountry;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
  }

   _forgotPassword({required BuildContext contextBuild}) {
    _closeKeyboard(contextBuild);
    final forgotPassRequest = ForgotPassRequest(
      phone:
      '${phoneNumber!.dialCode}${_phoneController.text}',
    );
    ForgetPasswordCubit.get(contextBuild).forgotPassword(forgotPassRequest: forgotPassRequest);
  }

  void _closeKeyboard(contextBuild) => FocusScope.of(contextBuild).unfocus();
}
