import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/custom_back.dart';
import '../../../shared/resources/formatter.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/navigation_service.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_above_textfield.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../../shared/resources/utils.dart';
import '../../../shared/resources/validation.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../home/cubit/home_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _fullNameController ;
  late TextEditingController _emailController ;
  late TextEditingController _phoneController ;
  String errorTextEmail = '';
  String errorTextName = '';
  String errorTextPhone = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name ;
  late String email ;
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]*$');


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeCubit,HomeState>(
      listener: (BuildContext context, state) {
        if(state is HomeUpdateProfile){
          Utils.showSnackBar(StringsManager.profileUpdated.tr(),context);
          name = HomeCubit.get(context).getProfileResponse?.fullName??'';
          email = HomeCubit.get(context).getProfileResponse?.email??'';
        }
        if(state is HomeGetProfile){
          name = HomeCubit.get(context).getProfileResponse?.fullName??'';
          email = HomeCubit.get(context).getProfileResponse?.email??'';
          _fullNameController = TextEditingController(text: HomeCubit.get(context).getProfileResponse?.fullName);
          _emailController = TextEditingController(text: HomeCubit.get(context).getProfileResponse?.email);
          _phoneController = TextEditingController(text: HomeCubit.get(context).getProfileResponse?.phone?.split('+1').last);
        }
      },
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                  padding:  REdgeInsets.all(
                      16
                  ),
                  //   child:
                  // ConstrainedBox(
                  //   constraints: BoxConstraints(
                  //     minHeight: MediaQuery.of(context).size.height - 100.h,
                  //   ),
                  // constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  // child: IntrinsicHeight(
                  child:state is HomeGetProfile || state is HomeUpdateProfile || state is HomeLoadingUpdateState ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ArrowBack(
                        onPressed: (){
                          sl<NavigationService>().popup();
                        },
                        title: StringsManager.editProfile.tr(),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      TextAboveTextField(
                        title: StringsManager.fullName.tr(),
                      ),
                      CustomFormField(
                        isPassword: true,
                        obscureText: false,
                        suffixIcon: UnconstrainedBox(
                          child:  Icon(Icons.edit_outlined,color:!ThemeCubit.get(context).isDark ? ColorsManager.greyText :ColorsManager.blackColor2DarkMode,size: 16.sp,),
                        ),
                        hint: StringsManager.enterFullName.tr(),
                        //  label: StringsManager.fullName,
                        controller: _fullNameController,
                        inputFormatters: CustomTextInputFormatter.nameFormFieldFormatter2,
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

                      GestureDetector(
                        onTap: (){
                          Utils.showSnackBar(StringsManager.notChangeEmail.tr(),context);
                        },
                        child: CustomFormField(
                          enabled: false,
                          // isPassword: true,
                          obscureText: false,
                          // suffixIcon: UnconstrainedBox(
                          //   child:  Icon(Icons.edit_outlined,color:!ThemeCubit.get(context).isDark ? ColorsManager.greyText.withOpacity(0.5) :ColorsManager.blackColor2DarkMode.withOpacity(0.5) ,size: 16.sp,),
                          // ),
                          hint: StringsManager.enterEmail.tr(),
                          //   label: StringsManager.emailAddress,
                          controller: _emailController,
                          filled: true,
                          keyboard: TextInputType.emailAddress,
                          action: TextInputAction.done,
                          validator: (value){
                            return CustomValidation.emailValidation(value,errorTextEmail);
                          },
                        ),
                      ),

                      SizedBox(
                        height: 16.h,
                      ),
                      TextAboveTextField(
                        title: StringsManager.phone.tr(),
                      ),
                      GestureDetector(
                        onTap: (){
                          Utils.showSnackBar(StringsManager.notChangePhone.tr(),context);
                        },
                        child: CustomFormField(
                          enabled: false,
                          // isPassword: true,
                          obscureText: false,
                          // suffixIcon: UnconstrainedBox(
                          //   child:  GestureDetector(
                          //       onTap: (){
                          //         Utils.showSnackBar('sorry you Cannot Edit your Phone',context);
                          //       },
                          //       child: Icon(Icons.edit_outlined,color:!ThemeCubit.get(context).isDark ? ColorsManager.greyText :ColorsManager.blackColor2DarkMode ,size: 16.sp,)),
                          // ),
                          addPrefix: true,
                          hint: StringsManager.pleaseEnterPhone.tr(),
                          //      label: StringsManager.phone,
                          controller: _phoneController,
                          filled: true,
                          keyboard: TextInputType.phone,
                          action: TextInputAction.next,
                          validator: (value){
                            return CustomValidation.phoneValidation(value,errorTextPhone);
                          },
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  if (newValue.text.length > 10) {
                                    return oldValue;
                                  }
                                  return newValue;
                                }),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),


                      const Spacer(),
                      Padding(
                        padding: REdgeInsets.only(
                          //   top: 175,
                            left: 28,
                            right: 28
                        ),
                        child: Center(
                          child:state is HomeLoadingUpdateState ? const LoadingIndicatorWidget(): MainButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                if(_fullNameController.text != name || _emailController.text != email){
                                  HomeCubit.get(context).patchProfile(
                                    fullName: _fullNameController.text,
                                    email: _emailController.text,
                                  );
                                }else {
                                  Utils.showSnackBar(StringsManager.noChanges.tr(),context);
                                }
                              }


                            },
                            title: StringsManager.saveText.tr(),
                          ),
                        ),
                      ),
                      const Spacer(),



                    ],
                  ):
                  const Center(child:  LoadingIndicatorWidget(),)
                // ),
                //  ),
              ),
            ),
          ),
        ) ;
      },
    );
  }

  @override
  void initState() {
    HomeCubit.get(context).getProfile();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }
}
