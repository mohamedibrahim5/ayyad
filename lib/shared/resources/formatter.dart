import 'package:flutter/services.dart';



class CustomTFRegex {
  static final  RegExp passwordReg = RegExp(r'[a-zA-Z0-9]');
  static final RegExp nameReg = RegExp(r'^[A-Za-z\s]+$');
  static final RegExp addressReg = RegExp(r'^[#.0-9a-zA-Z\s,-]+$');

}
class CustomTextInputFormatter {
  static List<TextInputFormatter> passwordFormatter = [
    FilteringTextInputFormatter.allow((RegExp(r'[a-zA-Z0-9]')))
  ];
  static List<TextInputFormatter> positiveNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$|^\d*$'))
  ];
  static List<TextInputFormatter> positiveIntegerNumber = [
    FilteringTextInputFormatter.allow( RegExp(r'^[0-9]$'))
  ];
  static List<TextInputFormatter> phoneFieldFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,9}$'))
  ];

  static List<TextInputFormatter> nameFormFieldFormatter = [
    CustomInputFormatter(regex:CustomTFRegex.nameReg),
    LengthLimitingTextInputFormatter(100),
  ];

  static List<TextInputFormatter> nameFormFieldFormatter2 = [
    CustomInputFormatter(regex:CustomTFRegex.nameReg),
    LengthLimitingTextInputFormatter(100),
    FilteringTextInputFormatter.singleLineFormatter,
    TextInputFormatter.withFunction((oldValue, newValue) {
      // Prevent space at the beginning
      if (newValue.text.startsWith(' ')) {
        return oldValue;
      }
      return newValue;
    }),
  ];

  static List<TextInputFormatter> numberFormater = [
    FilteringTextInputFormatter.digitsOnly,
  ];

  static List<TextInputFormatter> addressFieldFormatter = [

    CustomInputFormatter(
        regex: CustomTFRegex.addressReg),
    LengthLimitingTextInputFormatter(100),


  ];

}
class TextFieldInputHandling{
  static String cleanName(String input) {
    // Replace multiple spaces with a single space
    String cleaned = input.replaceAll(RegExp(r'\s+'), ' ');

    // Trim leading and trailing spaces
    cleaned = cleaned.trim();

    return cleaned;
  }
}

class CustomInputFormatter extends TextInputFormatter {
  final RegExp regex;

  CustomInputFormatter({required this.regex});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (regex.hasMatch(newValue.text) || newValue.text.trim().toString().isEmpty == true) {
      return newValue;
    }
    return oldValue;
  }
}



