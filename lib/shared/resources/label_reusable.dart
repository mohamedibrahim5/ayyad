import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_manager.dart';

class LabelReusableWidget extends StatelessWidget {
  const LabelReusableWidget({super.key,required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      child: Container(
        padding: REdgeInsets.symmetric(
            horizontal: 2
        ),
        color: ColorsManager.backgroundColor,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
