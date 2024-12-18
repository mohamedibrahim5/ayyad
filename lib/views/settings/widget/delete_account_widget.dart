import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';

import '../../../shared/resources/constant.dart';
import '../../../shared/resources/custom_button.dart';
import '../../../shared/resources/loading_indicator_widget.dart';
import '../../../shared/resources/prefs_helper.dart';
import '../../../shared/resources/service_locator.dart';
import '../../../shared/resources/utils.dart';

class DeleteAccountWidget extends StatelessWidget {
  const DeleteAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SettingsCubit,SettingsState>(
      listener: (BuildContext context, state) async {
        if(state is DeleteAccountSuccess){
          Utils.showSnackBar(state.message,context);
          sl<PrefsHelper>().setData(key: Constants.guestCheck, value: true);
          await sl<PrefsHelper>().removeToken2();
        await sl<PrefsHelper>().removeSession2() ;
        sl<NavigationService>().navigatePushNamedAndRemoveUntil(RoutesManager.baseScreen,
        arguments: {
        Constants.guest:false,
        }
        //     arguments: {
        //   'loginFinish':true
        // }
        );
        }
      },
      builder: (BuildContext context, Object? state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Text(
                  StringsManager.deleteAccount.tr(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                Padding(
                  padding:  REdgeInsets.all(6.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(AssetsManager.sharkIconDialog)),
                ),

              ],
            ),
            Padding(
              padding:  REdgeInsets.only(
                  right: 50,
                  left: 50,
                  bottom:35,
                  top: 6
              ),
              child: Text(
                StringsManager.deleteAccountDes.tr(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),


            state is SettingsDeleteAccount ? const LoadingIndicatorWidget() :
            Padding(
              padding:  REdgeInsets.symmetric(
                  horizontal: 24
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MainButton(

                      colorTitle: ColorsManager.primaryColor,
                      onPressed: (){
                        sl<NavigationService>().popup();
                      },
                      title: StringsManager.no.tr(),
                      color: Colors.transparent,
                      colorBorder: ColorsManager.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Expanded(
                    child: MainButton(
                      onPressed: () async {
                        await  SettingsCubit.get(context).deleteAccount();
                      },
                      title: StringsManager.yes.tr(),
                      color: ColorsManager.primaryColor,
                    ),
                  ),
                ],
              ),
            ),




            SizedBox(
              height: 33.h,
            ),

          ],
        );
      },
    );
  }
}