import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibnelbarh/repository/repository.dart' ;
import 'package:ibnelbarh/shared/resources/assets_manager.dart';
import 'package:ibnelbarh/shared/resources/bitmap_descriptor_helper.dart';
import 'package:ibnelbarh/views/home/cubit/map_state.dart';
import 'package:location/location.dart';


import '../../../model/responses/google_map_search_model.dart' hide Location;




class MapCubit extends Cubit<MapState> {

  MapCubit({required this.repository})
      : super(MapState(
    markers: {},
  ));
  Repository repository;
  static MapCubit get(context) => BlocProvider.of(context);

  static Map<MarkerId, Marker> markers = {};
  LatLng? myLocation;
   static String fromLocationName = '';
  static LatLng fromLocationLatLong = const LatLng(30.0594628, 31.1760633);
  static GoogleMapController? controller;
  GoogleMapSearchModel? googleSearch;
  bool addMarkerIcon = false;





  getLocation() async {
      emit(MapInitial());
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // myLocation = LatLng(30.0594628, 31.1760633);
        emit(MapState(
            markers: markers,

            // estimatedDistance: estimatedDistance,
      //      cameraPosition: CameraPosition(target: myLocation!, zoom: 16)
        ));
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // myLocation = LatLng(30.0594628, 31.1760633);
        emit(MapState(
            markers: markers,

            // estimatedDistance: estimatedDistance,
            cameraPosition: CameraPosition(target: myLocation!, zoom: 16)));
        return;
      }
    }

    locationData = await location.getLocation();
    myLocation = LatLng(locationData.latitude!, locationData.longitude!);
    emit(MapState(
        markers: markers,

        // estimatedDistance: estimatedDistance,
        cameraPosition: CameraPosition(target: myLocation!, zoom: 16)));


      // checkCameraLocation(
      //   CameraUpdate.newLatLng(myLocation!),
      // );

  }




  addMarker(position) async {
    FocusManager.instance.primaryFocus?.unfocus();
    googleSearch = null;
    // String title = await placeNameByCoordinates(latLng: position);

    MapCubit.markers.clear();
    final marker = Marker(
      onDrag: (value) {
      },
      onDragEnd: (value) async {
        // fromLocationName = await getPlaceNameByLongLat(value,);
      },
      onDragStart: (value) {
      },
      //   draggable: true,
      markerId: const MarkerId('place_name'),
      position: position,
      icon: await getMarker(image: AssetsManager.location2),
      infoWindow: const InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
    MapCubit.markers[const MarkerId('place_name')] = marker;
     // fromLocationName = await getPlaceNameByLongLat(position);
    emit(MapState(
        markers: MapCubit.markers,
        cameraPosition: CameraPosition(target: position, zoom: 16)));
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate,
      ) async {
    debugPrint('checkCameraLocation');
    if (controller == null) return;
    controller?.animateCamera(cameraUpdate);
    debugPrint('if (controller == null) return;');
    LatLngBounds l1 = await controller!.getVisibleRegion();
    LatLngBounds l2 = await controller!.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate);
    }
  }

  getMarker({required String image}) async {
    final Uint8List markerIcon =
    await BitmapDescriptorHelper.getBytesFromAsset(image, 120);

     return BitmapDescriptor.bytes(markerIcon);
  }

  Future<String> getPlaceNameByLongLat(LatLng latLng) async {
    String placeName = '';
    try {
      String city = '';

      String street = '';
      String government = '';
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placeMarks.isNotEmpty) {
        city = placeMarks[0].locality ?? '';

        government = placeMarks[0].name ?? '';

        RegExp pattern = RegExp('^[^،]+');
        street = pattern.firstMatch(placeMarks[0].street ?? '')?.group(0) ?? '';
        placeName = '$street- $city- $government';
        return placeName;
      }
      addMarkerIcon = false;
      emit(MapState(
          markers: markers,

          // estimatedDistance: estimatedDistance,
          cameraPosition: CameraPosition(target: latLng, zoom: 16)));
      return placeName;

    } catch (error) {
      return placeName;
    }
  }

  Future<void> getMapSearch({required String keyword}) async {
    if (keyword.isNotEmpty) {
      emit(LoadingGetMapState());
      final failureOrSuccessGetMapModel =
      await repository.getMapSearch(keyword: keyword);
      failureOrSuccessGetMapModel.fold((success) {
        googleSearch = success as GoogleMapSearchModel?;
        emit(SuccessGetMapState(mapModel: success));
      }, (failure) {
        emit(ErrorgetHistoryState(message: failure));
      });
    }
  }



}
