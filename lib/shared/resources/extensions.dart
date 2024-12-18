import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
extension E on String {
  String lastChars(int n) => substring(length - n);
}

extension Lang on BuildContext {
   bool  get isArabic => locale.toString()=='ar';
}


extension ToArabicNumbers on String {
  String toArabic() {
    const Map<String, String> numbers = {
      '0': '٠',
      '1': '١',
      '2': '۲',
      '3': '۳',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    return replaceAllMapped(
      RegExp('[0-9]'),
          (match) => numbers[this[match.start]]!,
    );
  }
}
extension DurationExtensions on Duration {
  String toHoursMinutesSeconds(BuildContext context) {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    String twoDigitHours = _toTwoDigits(inHours);
    return context.isArabic? "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds".toArabic():"$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}

extension ToEnglishNumbers on String {
  String toEnglish() {
    const Map<String, String> numbers = {
      '٠': '0',
      '١': '1',
      '۲': '2',
      '۳': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '۷': '7',
      '۸': '8',
      '۹': '9',
    };

    return replaceAllMapped(
      RegExp('[٠-۹]'),
          (match) => numbers[this[match.start]]!,
    );
  }
}

// extension textDirection on Image {
//   bool get match => matchTextDirection == true ;
// }