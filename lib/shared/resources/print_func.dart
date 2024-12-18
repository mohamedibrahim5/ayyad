import 'package:flutter/foundation.dart';

void printFunc({
  bool printing = true,
  required String printName
}){
  if(printing){
    if (kDebugMode) {
      print(printName);
    }
  }

}