import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/views/app_root/dark_mode_cubit/dark_mode_cubit.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon,this.delete = false});
  final String title;
  final Function() onTap;
  final String icon;
  final bool delete ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding:  REdgeInsets.symmetric(
          vertical:8
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 16.sp,
                  width: 16.sp,
                  colorFilter:   ColorFilter.mode(
                   !ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn
                ),matchTextDirection: true ,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
             SvgPicture.asset(
              AssetsManager.arrowRight2,
              height: 16.sp,
              width: 16.sp,
               colorFilter:   ColorFilter.mode(
                   !ThemeCubit.get(context).isDark ? ColorsManager.blackColor2:ColorsManager.blackColor2DarkMode, BlendMode.srcIn
               ),matchTextDirection: true ,
            ),
          ],
        ),
      ),
    );
  }
}
