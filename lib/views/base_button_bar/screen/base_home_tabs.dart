import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: !ThemeCubit.get(context).isDark ? ColorsManager.bottomNavigationColor : ColorsManager.bottomNavigationColorDark,
          width: 1,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        color: !ThemeCubit.get(context).isDark ? ColorsManager.whiteColor : ColorsManager.backgroundColorDarkMode,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, AssetsManager.home, StringsManager.home,context),
          _buildNavItem(1, AssetsManager.cart, StringsManager.cart,context),
          _buildNavItem(2, AssetsManager.setting, StringsManager.setting,context),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String asset, String label,currentContext) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            asset,
            colorFilter: ColorFilter.mode(
              navIconColor(iconIndex: index, currentIndex: currentIndex,context: currentContext),
              BlendMode.srcIn,
            ),
            matchTextDirection: true,
          ),
          Text(
            label,
            style: TextStyle(
              color: navIconColor(iconIndex: index, currentIndex: currentIndex,context: currentContext),
            ),
          ),
        ],
      ),
    );
  }

  Color navIconColor({required int iconIndex, required int currentIndex,context}) {
    return !ThemeCubit.get(context).isDark
        ? currentIndex == iconIndex
        ? ColorsManager.primaryColor
        : ColorsManager.blackColor
        : currentIndex == iconIndex
        ? ColorsManager.primaryColor
        : ColorsManager.blackColor2DarkMode;
  }
}