import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';
import 'package:ibnelbarh/views/settings/widget/my_address_widget.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return  Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SafeArea(
            child:SettingsCubit.get(context).getAllAddressModelResponse == null ? const LoadingIndicatorWidget() : Padding(
              padding:  REdgeInsets.all(
                  24
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ArrowBack(
                          onPressed: (){
                            sl<NavigationService>().popup();
                          },
                          title: StringsManager.myAddress.tr(),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),

            SettingsCubit.get(context).getAllAddressModelResponse!.isEmpty ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(),
                SizedBox(
                  height: 150.h,
                ),
                Center(child: Image.asset(AssetsManager.emptyAddress)),
                Center(
                  child: Padding(
                    padding:  REdgeInsets.only(
                        top: 38,
                        bottom: 8
                    ),
                    child: Text(StringsManager.noAddress.tr(),style:Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600
                    )
                    ),
                  ),
                ),

                Center(
                  child: Text(StringsManager.pleaseAddAddress.tr(),style:Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w400
                  )
                  ),
                ),
                // const Spacer(),
              ],
            ) : Expanded(
              child: ListView.separated(
                itemBuilder:(context,index){
                  // final addNewAddressRequest = Constants.addNewAddressRequestBox.get(index);
                  // print("addNewAddressRequest $addNewAddressRequest");
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){

                      sl<NavigationService>().navigateTo(RoutesManager.addressDetails,arguments: {
                        "addNewAddressRequest": SettingsCubit.get(context).getAllAddressModelResponse![index],
                        "addAddress":false,
                        "index":index
                      });





                      // sl<NavigationService>().navigateTo(RoutesManager.addressDetails,arguments: {
                      //   "addNewAddressRequest":Constants.addNewAddressRequestBox.values.elementAt(index),
                      //   "addAddress":false,
                      //   "index":index
                      // });
                    },
                    child: MyAddressWidget(
                      // addNewAddressRequest: Constants.addNewAddressRequestBox.values.elementAt(index),
                      createAddressModelResponse: SettingsCubit.get(context).getAllAddressModelResponse![index],
                    ),
                  );
                },itemCount:SettingsCubit.get(context).getAllAddressModelResponse!.length  ,
                separatorBuilder: (context,index){
                  return SizedBox(
                    height: 16.h,
                  );
                },),
            )




                        // Constants.addNewAddressRequestBox.values.isEmpty ? Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     // const Spacer(),
                        //     SizedBox(
                        //       height: 150.h,
                        //     ),
                        //     Center(child: Image.asset(AssetsManager.emptyAddress)),
                        //     Center(
                        //       child: Padding(
                        //         padding:  REdgeInsets.only(
                        //             top: 38,
                        //             bottom: 8
                        //         ),
                        //         child: Text(StringsManager.noAddress.tr(),style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                        //             fontWeight: FontWeight.w600
                        //         )
                        //         ),
                        //       ),
                        //     ),
                        //
                        //     Center(
                        //       child: Text(StringsManager.pleaseAddAddress.tr(),style:Theme.of(context).textTheme.displaySmall!.copyWith(
                        //           fontWeight: FontWeight.w400
                        //       )
                        //       ),
                        //     ),
                        //     // const Spacer(),
                        //   ],
                        // ) : Expanded(
                        //   child: ListView.separated(
                        //     itemBuilder:(context,index){
                        //       // final addNewAddressRequest = Constants.addNewAddressRequestBox.get(index);
                        //       // print("addNewAddressRequest $addNewAddressRequest");
                        //       print("addNewAddressRequest ${Constants.addNewAddressRequestBox.length}");
                        //       return InkWell(
                        //         splashColor: Colors.transparent,
                        //         highlightColor: Colors.transparent,
                        //         onTap: (){
                        //            sl<NavigationService>().navigateTo(RoutesManager.addressDetails,arguments: {
                        //               "addNewAddressRequest":Constants.addNewAddressRequestBox.values.elementAt(index),
                        //              "addAddress":false,
                        //              "index":index
                        //            });
                        //         },
                        //         child: MyAddressWidget(
                        //           addNewAddressRequest: Constants.addNewAddressRequestBox.values.elementAt(index),
                        //         ),
                        //       );
                        //     },itemCount: Constants.addNewAddressRequestBox.length  ,
                        //     separatorBuilder: (context,index){
                        //       return SizedBox(
                        //         height: 16.h,
                        //       );
                        //     },),
                        // )
                      ],
                    ),
                  ),

                  Padding(
                    padding: REdgeInsets.only(
                        top: 24,
                        bottom: 100,
                        left: 28,
                        right: 28
                    ),
                    child: Center(
                      child:MainButton(
                        onPressed: (){

                          sl<NavigationService>().navigateTo(RoutesManager.googleMap,arguments: {
                            "checkOut":false,
                          });
                        },
                        title: StringsManager.addNewAddress.tr(),
                      ),
                    ),
                  ),






                ],
              ),
              // ),
              //  ),
            ),
          ),
        );
      },
    ) ;
  }


  @override
  void initState() {
    super.initState();
    SettingsCubit.get(context).getAllAddressModelResponse = null;
    SettingsCubit.get(context).getAllAddress();
    // Constants.addNewAddressRequestBox.clear();
     // onAddTask();

  }
  // void onUpdateTask(int index, AddNewAddressRequest addNewAddressRequest) {
  //  // addNewAddressRequestBox.putAt(index, AddNewAddressRequest(addNewAddressRequest.title, !addNewAddressRequest.completed));
  //   return;
  // }
  //
  // void onAddTask() {
  //     final newAddressRequest = AddNewAddressRequest(floor: 2, flatNumber: 1, label: "label12", area: "area", addressDetails: "addressDetails", deliveryInstructions: "deliveryInstructions", latlong: "latlong", address: "address");
  //     Constants.addNewAddressRequestBox.add(newAddressRequest);
  //     setState(() {});
  // }
}
