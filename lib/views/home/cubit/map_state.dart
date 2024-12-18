
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibnelbarh/model/responses/google_map_search_model.dart';

class MapState {
  Map<MarkerId, Marker> markers;

  CameraPosition? cameraPosition;


  MapState(
      {
        required this.markers,

        this.cameraPosition});

  MapState copyWith() => MapState(
    markers: markers,

    cameraPosition: cameraPosition,
    // estimatedTime: estimatedTime,
    // estimatedDistance: estimatedDistance,
  );
}
class MapInitial extends MapState {
  MapInitial() : super(markers: <MarkerId, Marker>{});
}

class LoadingGetMapState extends MapState {
  LoadingGetMapState() : super(markers: <MarkerId, Marker>{});
}

class SuccessGetMapState extends MapState{
  SuccessGetMapState({required this.mapModel,}): super(markers: <MarkerId, Marker>{});
  GoogleMapSearchModel mapModel ;
}

class ErrorgetHistoryState extends MapState{
  ErrorgetHistoryState({required this.message}): super(markers: <MarkerId, Marker>{});
  String message ;
}