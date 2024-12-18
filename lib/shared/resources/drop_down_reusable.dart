import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'assets_manager.dart';
import 'colors_manager.dart';

class DropDownButtonReusable extends StatelessWidget {
  const  DropDownButtonReusable({super.key,required this.items,required this.onChanged,this.selectedValue,required this.hintText });
  final List<String> items ;
  final Function(String?) onChanged;
  final String? selectedValue ;
  final String hintText ;

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 44.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorsManager.dropDownColor,
          borderRadius: BorderRadius.circular(12.r),

      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          iconStyleData:  IconStyleData(
            icon: SvgPicture.asset(AssetsManager.arrowDownIcon,width: 16.w,height: 16.h,),
          ),
          style:Theme.of(context).textTheme.bodyLarge ,
          menuItemStyleData:  MenuItemStyleData(
            padding: REdgeInsets.symmetric(
              horizontal: 0
            ),
          ),
          buttonStyleData: ButtonStyleData(
            padding: REdgeInsets.only(
                right:context.locale.languageCode == 'en' ?  16 : 0,
                left: context.locale.languageCode == 'en' ?  0 : 16
              // right: 16
            ),
          ),

          dropdownStyleData: DropdownStyleData(

            useSafeArea: true,
            padding: REdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: ColorsManager.whiteColor,
            ),
          ),
          isExpanded: true,
          hint: Text(
              hintText,
              style: Theme.of(context).textTheme.displayLarge
          ),
          items: items.map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
                item,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                ),
            ),
          )).toList(),
          value: selectedValue,
          onChanged: onChanged,

        ),
      ),
    );
  }
}
