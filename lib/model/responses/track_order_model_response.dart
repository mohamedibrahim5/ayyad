import 'get_order_response.dart';

class TrackOrderModelResponse {
  TrackOrderModelResponse({
    this.type,
    this.data,
  });

  final String? type;
  final TrackOrderModelData? data;

  factory TrackOrderModelResponse.fromJson(Map<String, dynamic> json) =>
      TrackOrderModelResponse(
        type: json["type"],
        data:json["data"] == null ? null : TrackOrderModelData.fromJson(json["data"]),
      );
}

class TrackOrderModelData {
  TrackOrderModelData({
    this.message,
    this.getOrderResponse,
    this.type,
  });

  final String? message;
  final GetOrderResponse? getOrderResponse;
  final String? type;

  factory TrackOrderModelData.fromJson(Map<String, dynamic> json) =>
      TrackOrderModelData(
          message: json["message"],
          getOrderResponse: GetOrderResponse.fromJson(json["order"]),
          type: json["type"]
      );

}