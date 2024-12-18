import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAboveTextField extends StatelessWidget {
  const TextAboveTextField({super.key, required this.title});
  final String title ;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  REdgeInsets.only(
        bottom: 4
      ),
      child: Text(
        title,
          style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
