import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:ibnelbarh/views/cart/cubit/cart_cubit.dart';

import '../../../shared/resources/assets_manager.dart';
import '../../../shared/resources/colors_manager.dart';
import '../../../shared/resources/drop_down_reusable.dart';
import '../../../shared/resources/formatter.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/phone.field.dart';
import '../../../shared/resources/string_manager.dart';
import '../../../shared/resources/text_above_textfield.dart';
import '../../../shared/resources/text_form_field_reusable.dart';
import '../../../shared/resources/validation.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';

class FullNumberNumberCheckoutWidget extends StatelessWidget {
  const FullNumberNumberCheckoutWidget({super.key,required this.notesController,required this.onCountryChanged,required this.isDelivery,required this.timePerson,required this.selectTimeColor,required this.datePerson,required this.dateController,required this.selectDateColor,required this.onTapTime,required this.onTapDate,required this.onChange,required this.selectName,required this.fullNameController,required this.selectPhone,required this.errorTextName,required this.errorTextPhone, required this.phoneFocusNode, required this.phoneController,required this.state,required this.selectBranchColor,required this.selectBranch,required this.timeController,required this.phoneNumber});
  final bool selectName ;
  final TextEditingController fullNameController ;
  final String errorTextName ;
  final bool selectPhone;
  final String errorTextPhone ;
  final FocusNode phoneFocusNode;
  final TextEditingController phoneController;
  final Object state;
  final bool selectBranchColor ;
  final String? selectBranch;
  final  Function(String?) onChange ;
  final Function()? onTapDate;
  final Function()? onTapTime;
  final  bool selectDateColor;
  final TextEditingController dateController ;
  final DateTime? datePerson;
  final bool selectTimeColor;
  final DateTime? timePerson;
  final TextEditingController timeController;
  final bool isDelivery ;
  final Country? phoneNumber ;
  final Function(Country)? onCountryChanged ;
  final TextEditingController notesController ;

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: double.infinity,
      decoration:!ThemeCubit.get(context).isDark ?
      BoxDecoration(
          color: ColorsManager.backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.blackColorShadow.withOpacity(0.12),
              spreadRadius: 0,
              blurRadius: 8.r,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]
      ):null,
      child: Padding(
        padding:  REdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextAboveTextField(
              title: StringsManager.fullName.tr(),
            ),
            SizedBox(
              height: selectName ? 66.h : 44.h,
              child: CustomFormField(
                top:0,
                hint: StringsManager.enterFullName.tr(),
                //  label: StringsManager.fullName,
                controller: fullNameController,
                filled: true,
                keyboard: TextInputType.text,
                action: TextInputAction.next,
                inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                validator: (value){
                  return CustomValidation.nameValidation(value,errorTextName);
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            TextAboveTextField(
              title: StringsManager.phone.tr(),
            ),

            PhoneField(
              onCountryChanged: onCountryChanged,
              country: phoneNumber ,
              hintText: StringsManager.pleaseEnterPhone.tr(),
              validation:selectPhone ,
              focusNode: phoneFocusNode,
              controller: phoneController,
              label: "",
              placeholder: "e.g. 915981847",
              validator: (value){
                if(value == null){
                  return StringsManager.required.tr();
                }else if (phoneController.text.isEmpty){
                  return StringsManager.required.tr();
                }
                return null ;
              },
              action: TextInputAction.next,
            ),


            // SizedBox(
            //   height:selectPhone ? 64.h : 44.h,
            //   child: CustomFormField(
            //     top: 0,
            //     focusNode: phoneFocusNode,
            //     addPrefix: true,
            //     hint: StringsManager.pleaseEnterPhone.tr(),
            //     //   label: StringsManager.phone,
            //     controller: phoneController,
            //     filled: true,
            //     keyboard: TextInputType.phone,
            //     action: TextInputAction.done,
            //     validator: (value){
            //       return CustomValidation.phoneValidation(value,errorTextPhone);
            //     },
            //     inputFormatters: [
            //       TextInputFormatter.withFunction((oldValue, newValue) {
            //         if (newValue.text.length > 10) {
            //           return oldValue;
            //         }
            //         return newValue;
            //       }),
            //       FilteringTextInputFormatter.digitsOnly,
            //     ],
            //   ),
            // ),



            if(!isDelivery)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  TextAboveTextField(
                    title: StringsManager.branch.tr(),
                  ),
                  state is GetBranchesLoadingState ? const LoadingIndicatorWidget() :
                  Container(
                    height: 44.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border:  Border.all(
                            width: 1.w, color:selectBranchColor ? ColorsManager.primaryColor :  ColorsManager.greyTextScreen3
                        )

                    ),
                    child: DropDownButtonReusable(
                      onChanged:onChange ,
                      hintText: StringsManager.selectBranch.tr(),
                      items:CartCubit.get(context).allBranches.map((e) => e.name ?? '').toList(),
                      selectedValue: selectBranch,
                    ),
                  ),


                  SizedBox(
                    height: 16.h,
                  ),
                  TextAboveTextField(
                    title: StringsManager.selectPickUpDate.tr(),
                  ),

                  GestureDetector(
                    onTap:  onTapDate,
                    child: SizedBox(
                      height:selectDateColor ? 66.h : 44.h,
                      child: CustomFormField(
                        top: 0,
                        obscureText: false,
                        isPassword: true,
                        suffixIcon:UnconstrainedBox(
                            child:  SvgPicture.asset(AssetsManager.date,matchTextDirection: true,)
                        ) ,
                        onTap:  () => onTapDate,
                        enabled: false,
                        hint: datePerson == null ? 'mm/dd/yyyy' :
                        //      "${datePerson}",
                        "${datePerson?.toLocal()}".split(' ')[0],
                        //  label: StringsManager.fullName,
                        controller: dateController,
                        filled: true,
                        keyboard: TextInputType.text,
                        action: TextInputAction.done,
                        validator: (value){
                          return CustomValidation.nameValidation(value,errorTextName);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),

                  TextAboveTextField(
                    title: StringsManager.selectPickUpTime.tr(),
                  ),

                  GestureDetector(
                    onTap:  onTapTime ,
                    child: SizedBox(
                      height:selectTimeColor ? 66.h : 44.h,
                      child: CustomFormField(
                        top: 0,
                        obscureText: false,
                        isPassword: true,
                        suffixIcon:UnconstrainedBox(
                            child:   SvgPicture.asset(AssetsManager.time,matchTextDirection: true,)
                        ) ,
                        onTap:  () => onTapTime,
                        enabled: false,
                        hint:
                        timePerson == null ? '--:--  --' :
                        "${timePerson?.hour}:${timePerson?.minute}",
                        // selectedDate == null ? 'mm/dd/yyyy' :
                        // "${selectedDate?.toLocal()}".split(' ')[0],
                        //  label: StringsManager.fullName,
                        controller: timeController,
                        filled: true,
                        keyboard: TextInputType.text,
                        action: TextInputAction.done,
                        validator: (value){
                          return CustomValidation.nameValidation(value,errorTextName);
                        },
                      ),
                    ),
                  ),
                ],
              ),

            if(isDelivery)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  TextAboveTextField(
                    title: StringsManager.notes.tr(),
                  ),
                  SizedBox(
                    height:  44.h,
                    child: CustomFormField(
                      top:0,
                      hint: StringsManager.notes.tr(),
                      //  label: StringsManager.fullName,
                      controller: notesController,
                      filled: true,
                      keyboard: TextInputType.text,
                      action: TextInputAction.next,
                      // inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                      validator: (value){
                        return null ;
                      },
                    ),
                  ),
                ],
              )



          ],
        ),
      ),
    );
  }
}
