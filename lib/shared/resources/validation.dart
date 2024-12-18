
import 'package:easy_localization/easy_localization.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:ibnelbarh/shared/resources/print_func.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:string_validator/string_validator.dart';

class CustomValidation  {
  static   String password ='';
  static String? passwordValidation(String? value,{String error = ''}){

    String? validationError;
    if (value?.isEmpty ?? false) {
      validationError =
          StringsManager.required.tr();
    } else if ((value?.length ?? 0) < 8) {
      validationError =
          StringsManager.passwordShort.tr();
    } else if (!RegExp(r'[A-Z]')
        .hasMatch(value ?? "")) {
      validationError =
          StringsManager.minUpperCase.tr();
    } else if (!RegExp(r'[a-z]')
        .hasMatch(value ?? "")) {
      validationError =
          StringsManager.minLowerCase.tr();
    } else if (!RegExp(r'\d')
        .hasMatch(value ?? "")) {
      validationError =
          StringsManager.minNumber.tr();
    }else if(error.isNotEmpty){
      validationError = error;
    }
    validationError==null?(password=value??''):{};
    return validationError;
  }
  static String? confirmPasswordValidation(String? confirm){

    String? validationError;
    if (confirm?.isEmpty ?? false) {
      validationError =
          StringsManager.required.tr();
    } else if (confirm.toString() != password.toString()) {
      validationError =
          StringsManager.confirmPassword2.tr();
    }  else if ((confirm?.length ?? 0) < 8) {
      validationError =
          StringsManager.passwordShort.tr();
    } else if (!RegExp(r'[A-Z]')
        .hasMatch(confirm ?? "")) {
      validationError =
          StringsManager.minUpperCase.tr();
    } else if (!RegExp(r'[a-z]')
        .hasMatch(confirm ?? "")) {
      validationError =
          StringsManager.minLowerCase.tr();
    } else if (!RegExp(r'\d')
        .hasMatch(confirm ?? "")) {
      validationError =
          StringsManager.minNumber.tr();
    }


    return validationError;
  }
  static String? nameValidation(String? value, String error){

    String? validationError;
    if (value?.isEmpty ?? false) {
      validationError =
          StringsManager.required.tr();
    } else if(isEmail(value??'')){
      StringsManager.name.tr();
    }else if(error.isNotEmpty){
      validationError = error;
    }
    return validationError;
  }
  static String? nameValidation2(String? value,){

    String? validationError;
    if (value?.isEmpty ?? false) {
      validationError =
          StringsManager.required.tr();
    } else if(isEmail(value??'')){
      StringsManager.name.tr();
    }
    return validationError;
  }

  static String? phoneValidation(String? value, String error){

    String? validationError;
    if (value?.isEmpty ?? false) {
      validationError =
          StringsManager.required.tr();
    }
    else if(value!.isNotEmpty && value.length<10){
      validationError =
          StringsManager.errorNumber.tr();
    }
    else if(isEmail(value)){
      StringsManager.phone.tr();
    }else if(error.isNotEmpty){
      validationError = error;
    }
    return validationError;
  }
  static String? emailValidation(String? value,String error){
    String? validationError;
    if (value?.isEmpty ?? false) {
      validationError =
          StringsManager.required.tr();
    } else if((isEmail(value??'')==false)){

      validationError =  StringsManager.emailValid.tr();
    }else if(error.isNotEmpty){
      validationError = error;
    }

    return validationError;
  }
  static String? phoneValidator(PhoneNumber? value) {
    printFunc(printName: 'kdsfkjk');
    if (value == null) {
      return StringsManager.addPhone.tr();
    }

    String formattedNumber =
    value.completeNumber.replaceAll(RegExp(r'[^\d+]'), '');

    String pattern = r'^\+[1-9]\d{1,14}$';
    RegExp regExp = RegExp(pattern);

    if (formattedNumber.isEmpty) {
      return StringsManager.addPhone.tr();
    } else if (!regExp.hasMatch(formattedNumber)) {
      return StringsManager.addPhoneValid.tr();
    }

    return null;
  }

  static String? invitationCodeValidation(String? value){

    return null;
  }
}