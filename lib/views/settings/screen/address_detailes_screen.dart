import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/dialog_reusable.dart';
import 'package:ibnelbarh/shared/resources/formatter.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/text_above_textfield.dart';
import 'package:ibnelbarh/shared/resources/text_form_field_reusable.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';
import 'package:ibnelbarh/shared/resources/validation.dart';
import 'package:ibnelbarh/views/base_button_bar/cubit/base_screen_navigation_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/map_cubit.dart';
import 'package:ibnelbarh/views/settings/cubit/settings_cubit.dart';
import 'package:ibnelbarh/views/settings/widget/delete_address_widget.dart';

import '../../../model/requests/create_address_request.dart';
import '../../../model/responses/create_address_model_respose.dart';
import '../../../shared/resources/assets_manager.dart';
import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';
import '../../cart/cubit/cart_cubit.dart';

class AddressDetails extends StatefulWidget {
  const AddressDetails({super.key,});

  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  late Map args;
  late bool addAddress ;
  late bool checkOut ;

  CreateAddressModelResponse? addNewAddressRequest ;
  int? index ;
  late TextEditingController labelController ;
  late TextEditingController cityController ;
  late TextEditingController streetDetailsController ;
  late TextEditingController floorController ;
  late TextEditingController flatNumberController ;
  late TextEditingController buildingInstructionController ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal:10,vertical: 20 ),
      //   child: MainButton(
      //     onPressed: (){
      //       // sl<NavigationService>().navigateTo(RoutesManager.googleMap);
      //     },
      //     title: StringsManager.confirmLocation,
      //   ),
      // ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if(state is AddNewAddressSuccess){
            sl<NavigationService>().popup();
            sl<NavigationService>().popup();
            if(checkOut == false){
              BaseScreenNavigationCubit.get(context).reset3();
            }else {
              CartCubit.get(context).allIndexOfChooseItem.add(false);
            }

            Utils.showSnackBar( StringsManager.addressAddedSuccessfully.tr(),context);
          }else if (state is UpdateAddressSuccess){
            // sl<NavigationService>().popup();
            sl<NavigationService>().popup();
            Utils.showSnackBar( StringsManager.updatedSuccessfully.tr(),context);
          }else if (state is AddAddressSuccess){
            SettingsCubit.get(context).getAllAddressModelResponse!.add(state.createAddressModelResponse);
            SettingsCubit.get(context).homeAddressModelResponse = state.createAddressModelResponse;
            sl<NavigationService>().popup();
            sl<NavigationService>().popup();

          }else if (state is PatchAddressSuccess){
            Utils.showSnackBar( StringsManager.updatedSuccessfully.tr(),context);
            SettingsCubit.get(context).getAllAddressModelResponse![index!] = state.createAddressModelResponse;
            sl<NavigationService>().popup();
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Padding(
                padding:  REdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ArrowBack(
                          widget:addAddress ? null : Padding(
                              padding:  REdgeInsets.only(
                                left: 16,
                          ),
                            child: GestureDetector(
                              onTap: (){
                                showReusableDialog(
                                    image: AssetsManager.deleteAccount,
                                    padding:  REdgeInsets.symmetric(
                                        horizontal: 0
                                    ),
                                    context: context,
                                    widget:  DeleteAddressWidget(
                                      addressId: addNewAddressRequest!.id!,
                                      // index: index!,
                                    )
                                );
                              },
                              child: Text(
                                StringsManager.delete.tr(),
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 12.sp
                                ),
                              ),
                            ),
                          ),
                          onPressed: (){
                            sl<NavigationService>().popup();
                          },
                          title: StringsManager.addressDetails.tr(),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.deliveryLocation.tr(),
                        ),

                        Container(
                          width: double.infinity,
                          height:110.h ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: GoogleMap(
                            style: ThemeCubit.get(context).isDark ? _darkMapStyle : null,
                            zoomControlsEnabled: false,
                            scrollGesturesEnabled:  false,
                            compassEnabled: false,
                            zoomGesturesEnabled: false,
                            tiltGesturesEnabled:  false,
                            rotateGesturesEnabled: false,
                            minMaxZoomPreference: const MinMaxZoomPreference(8, 24),
                            markers: addNewAddressRequest == null ? MapCubit.markers.values.toSet():{
                              Marker(
                                markerId: const MarkerId('place_name'),
                                position: LatLng(
                                    double.parse(addNewAddressRequest!.location!.split(',').first.split('(').last), double.parse(addNewAddressRequest!.location!.split(',').last.split(')').first.split(' ').last)
                                ),
                                icon: BitmapDescriptor.defaultMarker,
                                infoWindow: InfoWindow(
                                  title: addNewAddressRequest!.street!,
                                  snippet: addNewAddressRequest!.locationName!,
                                ),
                              )
                            },
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target:addNewAddressRequest == null ?MapCubit.markers.values.first.position:LatLng(
                                    double.parse(addNewAddressRequest!.location!.split(',').first.split('(').last), double.parse(addNewAddressRequest!.location!.split(',').last.split(')').first.split(' ').last)
                                ),
                                zoom: 16),
                            onMapCreated: (GoogleMapController controller) async {
                              MapCubit.controller = controller;
                              // if (ThemeCubit.get(context).isDark)
                              //   MapCubit.controller?.setMapStyle(_darkMapStyle);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.label.tr(),
                        ),

                        CustomFormField(
                          hint: StringsManager.label.tr(),
                          //  label: StringsManager.fullName,
                          controller: labelController,
                          // inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                          filled: true,
                          keyboard: TextInputType.text,
                          action: TextInputAction.next,
                          validator: CustomValidation.nameValidation2
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        TextAboveTextField(
                          title: StringsManager.city.tr(),
                        ),

                        CustomFormField(
                            hint: StringsManager.city.tr(),
                            //  label: StringsManager.fullName,
                            controller: cityController,
                            // inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                            filled: true,
                            keyboard: TextInputType.text,
                            action: TextInputAction.next,
                            validator: CustomValidation.nameValidation2
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        TextAboveTextField(
                          title: StringsManager.street.tr(),
                        ),

                        CustomFormField(
                            hint: StringsManager.street.tr(),
                            //  label: StringsManager.fullName,
                            controller: streetDetailsController,
                            // inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                            filled: true,
                            keyboard: TextInputType.text,
                            action: TextInputAction.next,
                            validator: CustomValidation.nameValidation2
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextAboveTextField(
                                title: StringsManager.floor.tr(),
                              ),
                            ),
                            SizedBox(
                              width: 22.w,
                            ),
                            Expanded(
                              child: TextAboveTextField(
                                title: StringsManager.flatNumber.tr(),
                              ),
                            ),
                          ],

                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomFormField(
                                  hint: StringsManager.floor.tr(),
                                  //  label: StringsManager.fullName,
                                  controller: floorController,
                                  inputFormatters:CustomTextInputFormatter.numberFormater,
                                  filled: true,
                                  keyboard: TextInputType.number,
                                  action: TextInputAction.next,
                                  validator: CustomValidation.nameValidation2
                              ),
                            ),
                            SizedBox(
                              width: 22.w,
                            ),
                            Expanded(
                              child: CustomFormField(
                                  hint: StringsManager.flatNumber.tr(),
                                  //  label: StringsManager.fullName,
                                  controller: flatNumberController,
                                   inputFormatters:CustomTextInputFormatter.numberFormater,
                                  filled: true,
                                  keyboard: TextInputType.number,
                                  action: TextInputAction.next,
                                  validator: CustomValidation.nameValidation2
                              ),
                            ),
                            const SizedBox(),
                          ],

                        ),

                        SizedBox(
                          height: 16.h,
                        ),
                        TextAboveTextField(
                          title: StringsManager.buildingNumber.tr(),
                        ),

                        CustomFormField(
                            hint: StringsManager.buildingNumber.tr(),
                            //  label: StringsManager.fullName,
                            controller: buildingInstructionController,
                           // inputFormatters:CustomTextInputFormatter.nameFormFieldFormatter2,
                            filled: true,
                            keyboard: TextInputType.text,
                            action: TextInputAction.done,
                            validator: CustomValidation.nameValidation2
                        ),
                        Padding(
                          padding: REdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 74.0
                          ),
                          child: Center(
                            child:state is SettingsLoadingAddAddress || state is SettingsLoadingPatchAddress ? const LoadingIndicatorWidget() :MainButton(
                              onPressed: () async {
                                // print('addAddress11${addNewAddressRequest}');
                                // print('aa${MapCubit.markers.values.first.position.latitude.toString()},${MapCubit.markers.values.first.position.longitude.toString()}');
                               if(_formKey.currentState!.validate()){
                                 // AddNewAddressRequest? addNewAddressRequestModel = AddNewAddressRequest(
                                 //     floor: int.parse(floorController.text), flatNumber: int.parse(flatNumberController.text), label: labelController.text, area: cityController.text, addressDetails: streetDetailsController.text, deliveryInstructions: buildingInstructionController.text, latlong:  addNewAddressRequest == null ?MapCubit.markers.values.first.position.toString():addNewAddressRequest!.latlong!, address: addNewAddressRequest == null ?MapCubit.fromLocationName:addNewAddressRequest!.address!);
                                 // save last address her to use it in the next order



                                 CreateAddressRequest createAddressModelResponse = CreateAddressRequest(
                                   city: cityController.text,
                                   label: labelController.text,
                                   street: streetDetailsController.text,
                                   floor: floorController.text,
                                   flat: flatNumberController.text,
                                   building: buildingInstructionController.text,
                                   location: addNewAddressRequest == null ?
                                   '${MapCubit.markers.values.first.position.latitude.toString()},${MapCubit.markers.values.first.position.longitude.toString()}'
                                       :addNewAddressRequest!.location!,
                                 );
                                // await Constants.myAddressRequestBox.clear();
                                //  Constants.myAddressRequestBox.add(addNewAddressRequestModel);
                                //  print('addAddress12${Constants.myAddressRequestBox.length}');

                                 if(addAddress){
                                   // SettingsCubit.get(context).onAddTask(
                                   //     addNewAddressRequest: addNewAddressRequestModel
                                   // );
                                   SettingsCubit.get(context).addAddress(createAddressRequest: createAddressModelResponse);
                                   // print('addAddress${Constants.addNewAddressRequestBox.length}');
                                 }else {
                                   SettingsCubit.get(context).patchAddress(createAddressRequest: createAddressModelResponse, id: addNewAddressRequest!.id!);
                                   // SettingsCubit.get(context).onUpdateTask(
                                   //   index: index!,
                                   //     addNewAddressRequest: addNewAddressRequestModel
                                   // );
                                 }




                               }
                              },
                              color:  ColorsManager.primaryColor ,
                              title: StringsManager.saveAddress.tr(),
                            ),
                          ),
                        )





                      ],
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
  }
  String? _darkMapStyle;
  Future _loadMapStyles() async {
    _darkMapStyle =
    await rootBundle.loadString('assets/map_theme/night_theme.json');
  }

  @override
  void didChangeDependencies() {
   // Constants.addNewAddressRequestBox.clear();
    super.didChangeDependencies();
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    addAddress = args['addAddress'] ?? false;
    checkOut = args['checkOut'] ?? false;
    index = args['index']  ;
    addNewAddressRequest = args['addNewAddressRequest']  ;

    labelController = TextEditingController(text: addNewAddressRequest?.label ?? '');
    cityController = TextEditingController(text: addNewAddressRequest?.city ?? '');
    streetDetailsController = TextEditingController(text: addNewAddressRequest?.street ?? '');
    floorController = TextEditingController(text: addNewAddressRequest?.floor.toString() ?? '');
    flatNumberController = TextEditingController(text: addNewAddressRequest?.flat.toString() ?? '');
    buildingInstructionController = TextEditingController(text: addNewAddressRequest?.building.toString() ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    labelController.dispose();
    cityController.dispose();
    streetDetailsController.dispose();
    floorController.dispose();
    flatNumberController.dispose();
    buildingInstructionController.dispose();
  }

  // void onUpdateTask(int index, AddNewAddressRequest addNewAddressRequest) {
  //   // addNewAddressRequestBox.putAt(index, AddNewAddressRequest(addNewAddressRequest.title, !addNewAddressRequest.completed));
  //   return;
  // }

  // void onAddTask() {
  //   final newAddressRequest = AddNewAddressRequest(floor: int.parse(floorController.text), flatNumber: int.parse(flatNumberController.text), label: labelController.text, area: areaController.text, addressDetails: addressDetailsController.text, deliveryInstructions: deliveryInstructionController.text,
  //       latlong: addNewAddressRequest == null ?MapCubit.markers.values.first.position.toString():addNewAddressRequest!.latlong!,
  //       address: addNewAddressRequest == null ?MapCubit.fromLocationName:addNewAddressRequest!.address!);
  //   Constants.addNewAddressRequestBox.add(newAddressRequest);
  //   sl<NavigationService>().popup();
  //   sl<NavigationService>().popup();
  //
  // }
}
