import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/colors_manager.dart';
import 'package:ibnelbarh/shared/resources/custom_back.dart';
import 'package:ibnelbarh/shared/resources/custom_button.dart';
import 'package:ibnelbarh/shared/resources/loading_indicator_widget.dart';
import 'package:ibnelbarh/shared/resources/navigation_service.dart';
import 'package:ibnelbarh/shared/resources/routes_manager.dart';
import 'package:ibnelbarh/shared/resources/service_locator.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/text_form_field_reusable.dart';
import 'package:ibnelbarh/views/home/cubit/map_cubit.dart';
import 'package:ibnelbarh/views/home/cubit/map_state.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/services.dart';

import '../../app_root/dark_mode_cubit/dark_mode_cubit.dart';

class MapBackground extends StatefulWidget {
  const MapBackground({super.key,});



  @override
  State<MapBackground> createState() => _MapBackgroundState();
}

class _MapBackgroundState extends State<MapBackground>
    with WidgetsBindingObserver {


  TextEditingController searchController2 = TextEditingController();
  late Map args;
  late bool checkOut ;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    checkOut = args['checkOut'] ?? false;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    MapCubit.get(context).googleSearch = null ;
    MapCubit.markers = {};
    addMarker();
    _loadMapStyles();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    MapCubit.controller?.dispose();
    super.dispose();

  }

  String? _darkMapStyle;
  Future _loadMapStyles() async {
    _darkMapStyle =
    await rootBundle.loadString('assets/map_theme/night_theme.json');
  }
  Future<void> addMarker() async {
    MapCubit.get(context).addMarker(MapCubit.get(context).myLocation ?? const LatLng(38.7946,106.5348));
    searchController2.text = await MapCubit.get(context).getPlaceNameByLongLat(MapCubit.get(context).myLocation ?? const LatLng(38.7946,106.5348));
    MapCubit.fromLocationName = searchController2.text;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          return
          SafeArea(
            child:MapCubit.markers == {} ?
            const LoadingIndicatorWidget() : Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(

                    onCameraIdle: () async{
                       Timer(const Duration(seconds: 1), () async {
                          searchController2.text = await MapCubit.get(context).getPlaceNameByLongLat(MapCubit.markers.entries.first.value.position);
                          MapCubit.fromLocationName = searchController2.text;
                      });
                      // setState(() {
                      //   addMarkerIcon = false;
                      // });
                    },
                    onCameraMove: (value) async {
                      setState(() {
                        MapCubit.get(context).addMarkerIcon = false;
                      });
                      MapCubit.get(context).addMarker(value.target);
                    },
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    minMaxZoomPreference: const MinMaxZoomPreference(8, 24),
                     myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onTap:(value) async {
                        MapCubit.get(context).addMarker(value);
                        searchController2.text = await MapCubit.get(context).getPlaceNameByLongLat(value);
                        MapCubit.fromLocationName = searchController2.text;
                        // addMarkerIcon = false;

                    },
                    markers:  MapCubit.markers.values.toSet(),
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target:MapCubit.get(context).myLocation ?? const LatLng(30.0594628, 31.1760633) ,
                        zoom: 16),
                    onMapCreated: (GoogleMapController controller) async {
                      MapCubit.controller = controller;
                      if (ThemeCubit.get(context).isDark) {
                        MapCubit.controller?.setMapStyle(_darkMapStyle);
                      }
                    },
                  ),
                ),
                Container(
                  height:state is LoadingGetMapState ? 560.h :state is SuccessGetMapState && searchController2.text.isNotEmpty && MapCubit.get(context).googleSearch != null
                      && MapCubit.get(context).googleSearch!.results!.isNotEmpty && MapCubit.get(context).googleSearch!.results != null ? 560.h :  160.h,
                  decoration:  BoxDecoration(
                    color:!ThemeCubit.get(context).isDark ? ColorsManager.backgroundColor:ColorsManager.backgroundColorDarkMode,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:  REdgeInsets.all(16.0),
                          child: ArrowBack(
                            onPressed: (){
                              sl<NavigationService>().popup();
                            },
                            title: StringsManager.selectDeliveryAddress.tr(),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        // Padding(
                        //   padding:  REdgeInsets.symmetric(
                        //     horizontal: 16
                        //   ),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8.r),
                        //       border: Border.all(
                        //           color: ColorsManager.greyTextScreen3,
                        //           width: 1
                        //       ),
                        //     ),
                        //     child: Padding(
                        //       padding:  REdgeInsets.all(16.0),
                        //       child: Row(
                        //         children: [
                        //           SvgPicture.asset(
                        //             AssetsManager.location,
                        //             height: 14.sp,
                        //             width: 14.sp,
                        //           ),
                        //           SizedBox(
                        //             width: 6.w,
                        //           ),
                        //           Text(
                        //             MapCubit.fromLocationName,
                        //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 10.sp
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding:  REdgeInsets.symmetric(
                            horizontal: 16
                          ),
                          child: CustomFormField(
                            submit: (value) async{
                              if(value.isNotEmpty){
                                // if (_debounce?.isActive ?? false) _debounce?.cancel();
                              //  _debounce = Timer(const Duration(seconds: 3), () async {
                                  await MapCubit.get(context).getMapSearch(keyword: searchController2.text);
                                // });
                              }else {
                                setState(() {
                                  MapCubit.get(context).googleSearch = null ;
                                });
                                // _searchController.text = '';
                                // FocusManager.instance.primaryFocus?.unfocus();

                              }
                            },
                            enabled: true,
                            //  isPassword:widget.typeOfRide == TypeOfRide.fromLocation ? true:false,
                            obscureText: false,
                            // suffixIcon:widget.typeOfRide == TypeOfRide.fromLocation ? Padding(
                            //   padding:  REdgeInsets.all(8.0),
                            //   child: InkWell(
                            //       onTap: (){
                            //         MapCubit.get(context).getLocation(true);
                            //       },
                            //       splashColor: Colors.transparent,
                            //       highlightColor: Colors.transparent,
                            //       child:state is MapInitial ? LoadingAnimationWidget.inkDrop(
                            //         color:ThemeCubit.get(context).isDark? ColorsManager.primaryColor:ColorsManager.primaryColor,
                            //         size: 20,
                            //       ) : SvgPicture.asset(AssetsManager.currentLocation,matchTextDirection: true,)),
                            // ):null,
                            hint:searchController2.text,
                            addPrefix: true,
                            // prefixIcon: Padding(
                            //   padding:  REdgeInsets.all(12.0),
                            //   child: SvgPicture.asset(
                            //     AssetsManager.location,
                            //     height: 8.h,
                            //     width: 8.w,
                            //   ),
                            // ),
                            controller: searchController2,
                            onChanged: (value) async {

                              // if(value.isNotEmpty){
                              //   if (_debounce?.isActive ?? false) _debounce?.cancel();
                              //   _debounce = Timer(const Duration(seconds: 3), () async {
                              //     await MapCubit.get(context).getMapSearch(keyword: searchController2.text);
                              //   });
                              // }else {
                              //   setState(() {
                              //     MapCubit.get(context).googleSearch = null ;
                              //   });
                              //   // _searchController.text = '';
                              //   // FocusManager.instance.primaryFocus?.unfocus();
                              //
                              // }
                            },
                            filled: true,
                            keyboard: TextInputType.name,
                            action: TextInputAction.search,
                            isPassword: true,
                            prefixIcon: UnconstrainedBox(
                              child:  Padding(
                                padding:  REdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  AssetsManager.location,
                                  height: 14.h,
                                  width: 14.w,
                                ),
                              )
                            ),
                            suffixIcon:

                            UnconstrainedBox(
                              child: InkWell(
                                onTap: (){
                                  searchController2.clear();
                                  MapCubit.fromLocationName = '';
                                  setState(() {
                                    MapCubit.get(context).googleSearch = null ;
                                    MapCubit.markers = {};
                                    MapCubit.get(context).addMarkerIcon = true;
                                  });

                                },
                                child: Padding(
                                  padding:  REdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AssetsManager.close,
                                    height: 14.h,
                                    width: 14.w,
                                  ),
                                ),
                              ),
                            )
                                ,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        if (state is SuccessGetMapState && searchController2.text.isNotEmpty)
                          if (MapCubit.get(context).googleSearch != null )
                            if (MapCubit.get(context).googleSearch!.results!.isNotEmpty)
                              if (MapCubit.get(context).googleSearch!.results != null)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    height: 400.h,
                                    child: ListView.separated(
                                        separatorBuilder: (BuildContext context, int index) {
                                          return const Divider();
                                        },
                                        itemCount:MapCubit.get(context).googleSearch!.results?.length ?? 0,
                                        itemBuilder: (BuildContext context, int index) {
                                          return InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: ()async{
                                                String name = '${MapCubit.get(context).googleSearch!.results![index].name!} ${MapCubit.get(context).googleSearch!.results![index].formattedAddress!}';
                                                if (kDebugMode) {
                                                  print(name);
                                                }
                                                if(!mounted) return ;
                    
                                                MapCubit.get(context).checkCameraLocation(
                                                    CameraUpdate.newLatLng(LatLng(MapCubit.get(context).googleSearch!.results![index].geometry!.location!.lat!, MapCubit.get(context).googleSearch!.results![index].geometry!.location!.lng!))
                                                );
                    
                                                // MapCubit.get(context).updateCameraLocation(
                                                //   LatLng(MapCubit.markers.values.first.position.latitude, MapCubit.markers.values.first.position.longitude)
                                                //   ,LatLng(MapCubit.get(context).googleSearch!.results![index].geometry!.location!.lat!, MapCubit.get(context).googleSearch!.results![index].geometry!.location!.lng!),
                                                // );
                                                 searchController2.text = MapCubit.get(context).googleSearch!.results![index].name!;
                                                MapCubit.fromLocationName = searchController2.text;
                                                MapCubit.get(context).addMarker(LatLng(MapCubit.get(context).googleSearch!.results![index].geometry!.location!.lat!, MapCubit.get(context).googleSearch!.results![index].geometry!.location!.lng!));
                                                // MapCubit.fromLocationName = name;
                                                Future.delayed(const Duration(milliseconds: 2000));
                                              },
                                              child: ListTile(
                                                title:
                                                RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(context).style,
                                                    children:  <TextSpan>[
                                                      TextSpan(
                                                        text: '${MapCubit.get(context).googleSearch!.results![index].name}',
                                                        style:Theme.of(context).textTheme.bodyLarge,
                                                      ),
                                                      TextSpan(
                                                        text: " ${MapCubit.get(context).googleSearch!.results![index].formattedAddress}",
                                                        style:  Theme.of(context).textTheme.displaySmall!.copyWith(
                                                            fontSize: 16.sp
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Text("${SearchCubit.get(context).googleSearch!.results![index].name} ${SearchCubit.get(context).googleSearch!.results![index].formattedAddress}",style: TextStyle(
                                                //     fontSize: 16.sp,
                                                //     color: ColorsManager.black,
                                                //     fontWeight : FontWeight.w400,
                                                //     fontFamily: "Montserrat"
                                                // ),maxLines: 3,overflow: TextOverflow.ellipsis,) ,
                                              ));
                                        }),
                                  ),
                                ),
                        if(state is LoadingGetMapState)
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius:
                              BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0,
                                      3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: 280.h,
                              child: Shimmer.fromColors(
                                baseColor:Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: 323.w,
                                        height: 80.h,
                                        child:  ListTile(
                                          horizontalTitleGap: 0,
                                          contentPadding: EdgeInsets.zero,
                                          minLeadingWidth: 0,
                                          title: Column(
                                            children: [
                                              SizedBox(height: 5.0.h),
                                              Container(
                                                width: 300.w,
                                                height: 15.0.h,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 12.h),
                                              Container(
                                                width: 300.w,
                                                height: 14.0.h,
                                                color: Colors.white,
                                              ),
                                              SizedBox(height: 2.h),
                                              const Divider(),
                                            ],
                                          ),
                                        )),
                    
                                  ],
                                ),
                              ),
                            ),
                          ),
                    
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: REdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 40.0
                    ),
                    child: Center(
                      child:MainButton(
                        onPressed: (){
                          if(!MapCubit.get(context).addMarkerIcon){
                            sl<NavigationService>().navigateTo(RoutesManager.addressDetails,arguments: {
                              "addAddress": true,
                              'checkOut':checkOut,
                              // "addNewAddressRequest":null
                            });
                          }
                          // sl<NavigationService>().navigateTo(RoutesManager.googleMap);
                        },
                        color: !MapCubit.get(context).addMarkerIcon ? ColorsManager.primaryColor : ColorsManager.greyTextScreen3,
                        title: StringsManager.confirmLocation.tr(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}