import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../views/app_root/dark_mode_cubit/dark_mode_cubit.dart';
import 'colors_manager.dart';
import 'package:flutter/material.dart';


class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hint;
  final String? label;
  final TextInputType keyboard;
  final bool isPassword;
  final bool isCamera ;
  final TextInputAction action;
  final String? suffixText;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? customContentPadding;
  final bool enabled;
  final Color? customColor;
  final bool? autoFocus;
  final Widget? prefix;
  final bool filled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? length;
  final Widget? prefixIcon;
  final Widget? suffixIcon ;
  final bool? obscureText ;
  final void Function(String)? submit;
  final double? border ;
  final bool addPrefix ;
  final FocusNode? focusNode ;
  final double? top ;
  const CustomFormField({
    required this.filled,
    this.prefix,
    this.autoFocus,
    this.customColor,
    this.customContentPadding,
    this.onChanged,
    this.onTap,
    super.key,
    this.inputFormatters,
    this.submit,
    required this.controller,
    this.validator,
    this.hint ,
    this.label,
    required this.keyboard,
    this.isPassword = false,
    this.suffixIcon ,
    this.isCamera = false,
    required this.action,
    this.suffixText,
    this.enabled = true,
    this.length,
    this.prefixIcon,
    this.obscureText,
    this.border,
    this.addPrefix = false,
    this.focusNode,
    this.top
  });

  @override
  State<CustomFormField> createState() => CustomFieldState();
}

class CustomFieldState extends State<CustomFormField> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  REdgeInsets.only(
        top:widget.top ??  0
      ),
      child: TextFormField(
        // expands: true,
        focusNode: widget.focusNode,
        textAlignVertical: TextAlignVertical.center,
        // cursorHeight: 30.h,
        maxLength: widget.length,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        autofocus: widget.autoFocus ?? false,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        controller: widget.controller,
        enabled: widget.enabled,
        onFieldSubmitted: widget.submit,
        style:Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: widget.enabled ? null : !ThemeCubit.get(context).isDark ? ColorsManager.blackColor2.withOpacity(0.5) : ColorsManager.blackColor2DarkMode.withOpacity(0.5),

        ),
        decoration: InputDecoration(
          //  prefixIconConstraints:widget.prefixIcon != null ? const BoxConstraints(
              // minWidth: 16,
              // maxWidth: 16,
              // maxHeight: 16,
              // minHeight: 16
            // ) : null,
            prefix: widget.prefix,
            prefixIcon:widget.addPrefix ? widget.prefixIcon ??
            SizedBox(
              width: 85.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8.w,
                  ),
                  Image.asset('assets/flags/eg.png',package: 'intl_phone_field',matchTextDirection: true,width: 24.w,height: 24.h,),
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
                    "+20",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                ],
              ),
            ) : null,
            helperStyle: const TextStyle(fontSize: 0.1),
            counterText: "",
            labelText:widget.label ,
            labelStyle:Theme.of(context).textTheme.bodySmall ,
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.displayLarge,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: ColorsManager.greyTextScreen3),
              borderRadius: BorderRadius.circular(widget.border ?? 10.r),
            ),
            errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.sp, color: ColorsManager.red500),
            errorMaxLines: 2,
            filled: true,
            isCollapsed: true,
            fillColor: widget.filled ? ColorsManager.textFormFieldColor : ColorsManager.whiteColor,
            enabled: widget.enabled,
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
              borderRadius: BorderRadius.circular(widget.border ?? 10.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: ColorsManager.greyTextScreen3),
              borderRadius: BorderRadius.circular(widget.border ?? 10.r),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1.w, color: ColorsManager.greyTextScreen3),
              borderRadius: BorderRadius.circular(widget.border ?? 10.r),
            ),
            contentPadding: widget.customContentPadding ??
                REdgeInsets.symmetric(horizontal: 12),
            suffixIcon: widget.isPassword
                ? widget.suffixIcon ??
                Padding(
              padding: REdgeInsets.only(),
              child: toggle
                  ?
              GestureDetector(
                onTap: () {
                  setState(() {
                    toggle = false;
                  });
                },
                child: Icon(Icons.visibility, color: ColorsManager.greyText, size: 16.sp,)
              )
                  : GestureDetector(
                onTap: () {
                  setState(() {
                    toggle = true;
                  });
                },
                child:Icon(Icons.visibility_off, color: ColorsManager.greyText, size: 16.sp,)
              ),
            )
                : Icon(Icons.visibility_off, color: Colors.transparent, size: 16.sp,)),
        // cursorColor: ColorsManager.blue,
        obscureText:widget.obscureText ??  widget.isPassword ? !toggle : false,
        // style: Theme.of(context)
        //     .textTheme
        //     .bodySmall,
        keyboardType: widget.keyboard,
        textInputAction: widget.action,
      ),
    );
  }
}