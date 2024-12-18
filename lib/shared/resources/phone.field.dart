// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'colors_manager.dart';
import 'constant.dart';

class PhoneField extends StatefulWidget {
  TextEditingController? controller;
  String? placeholder;
  String label;
  String? Function(PhoneNumber?)? validator;
  final TextInputAction action;
  final FocusNode? focusNode;
  final  Function(Country)? onCountryChanged;
  bool validation ;
  final String hintText ;
  final Country? country ;
  PhoneField({
    super.key,
    this.controller,
    this.placeholder,
    required this.label,
    this.validator,
    required this.action,
    required this.focusNode,
    this.onCountryChanged,
    this.validation = false,
    required this.hintText,
    required this.country,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onCountryChanged:widget.onCountryChanged,

      dropdownIcon:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            // _selectedCountry.code.toLowerCase()
            'assets/flags/${widget.country?.code.toLowerCase() ?? Constants.selectedCountry.code.toLowerCase()}.png',
            package: 'intl_phone_field',
            width: 32,
            height: 32,
          ),
          SizedBox(
            width: 8.w,
          ),

          Padding(
            padding:  REdgeInsets.symmetric(
                horizontal: 9
            ),
            child: Container(
              width: 2.w,
              height: 28.h,
              color: ColorsManager.greyTextScreen3,
            ),
          ),
          Text(
            widget.country?.dialCode ?? Constants.selectedCountry.dialCode,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
        ],
      ) ,
      dropdownTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400
      ),
      focusNode: widget.focusNode,

      showDropdownIcon: true,
      flagsButtonPadding: REdgeInsets.only(
        left: 16,
      ),
      textAlign: TextAlign.start,
      showCountryFlag: false,
      style:Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400
      ),
      dropdownDecoration: BoxDecoration(
        color: ColorsManager.textFormFieldColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      pickerDialogStyle: PickerDialogStyle(
        // backgroundColor: ColorsManager.primaryColor,
        countryNameStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w700,
            color: ColorsManager.black
        ),
      ),

      // controller: widget.controller,
      validator: widget.validator,
      initialCountryCode: 'EG',
      textAlignVertical: TextAlignVertical.center,
      dropdownIconPosition: IconPosition.trailing,
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.errorColor,width: 0.5.w,),
          borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
        ),
        errorBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: ColorsManager.red,width: 0.5.w,),
          borderRadius: BorderRadius.all(Radius.circular(12.0.r)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: ColorsManager.greyTextScreen3),
          borderRadius: BorderRadius.circular( 10.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color: ColorsManager.greyTextScreen3),
          borderRadius: BorderRadius.circular( 10.r),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color:widget.validation ?  ColorsManager.red: ColorsManager.greyTextScreen3),
          borderRadius: BorderRadius.circular( 10.r),
        ),
        errorMaxLines: 2,
        filled: true,
        isCollapsed: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.w, color:widget.validation ?  ColorsManager.red:ColorsManager.greyTextColor),
          borderRadius: BorderRadius.circular( 8.r),
        ),
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.sp, color: ColorsManager.red500),
        hintStyle: Theme.of(context).textTheme.displayLarge,
        isDense: true,
        counterText: '',
        hintText: widget.hintText,
        // labelText: "widget.label",
        contentPadding: REdgeInsets.only(left: 16, right: 16 ,top: 14,bottom: 14),
        fillColor:  ColorsManager.textFormFieldColor,
      ),
      textInputAction: widget.action,
    );
  }
}
