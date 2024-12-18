import 'get_home_response.dart';

class GetProductModelResponse {
  int? count ;
  String? next;
  String? previous;
  List<CartItemModel>? cartItemModel ;

  GetProductModelResponse({
    this.count,
    this.next,
    this.previous,
    this.cartItemModel
  });

  factory GetProductModelResponse.fromJson(Map<String, dynamic> json) => GetProductModelResponse(
    count: json["count"],
    next: json["next"],
    previous:json['previous'],
    cartItemModel: List<CartItemModel>.from(json["results"].map((x) => CartItemModel.fromJson(x))),
  );
}
