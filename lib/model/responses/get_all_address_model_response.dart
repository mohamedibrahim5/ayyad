import 'create_address_model_respose.dart';

class GetAllAddressModelResponse {
  GetAllAddressModelResponse({
    this.count,
    this.next,
    this.previous,
    this.createAddressModelResponse
  });

  int? count ;
  String? next;
  String? previous;
  List<CreateAddressModelResponse>? createAddressModelResponse ;

  factory GetAllAddressModelResponse.fromJson(Map<String, dynamic> json) => GetAllAddressModelResponse(
    count: json["count"],
    next: json["next"],
    previous:json['previous'],
    createAddressModelResponse: List<CreateAddressModelResponse>.from(json["results"].map((x) => CreateAddressModelResponse.fromJson(x))),
  );
}

