
import 'get_extra_response.dart';
import 'get_home_response.dart';
import 'get_question_response.dart';


class GetOrderResponseModel {
  GetOrderResponseModel({
    this.count,
    this.next,
    this.previous,
    this.createAddressModelResponse
  });

  int? count ;
  String? next;
  String? previous;
  List<GetOrderResponse>? createAddressModelResponse ;

  factory GetOrderResponseModel.fromJson(Map<String, dynamic> json) => GetOrderResponseModel(
    count: json["count"],
    next: json["next"],
    previous:json['previous'],
    createAddressModelResponse: List<GetOrderResponse>.from(json["results"].map((x) => GetOrderResponse.fromJson(x))),
  );
}


class GetOrderResponse {
  GetOrderResponse({
    this.id,
    // this.user,
    this.totalAmount,
    // this.count,
    this.createdAt,
    this.updatedAt,
    this.items,
    this.orderStatus,
    this.date,
    this.time,
    this.fullName,
    this.type,
    this.address,
  });

  final int? id;
  // final dynamic user;
  String? totalAmount;
  // final int? count ;
  final String? createdAt;
  final String? updatedAt;
  final List<Items>? items ;
   String? orderStatus;
  final String? date;
  final String? time;
  final String? fullName ;
  final String? type ;
  final Address? address;

  factory GetOrderResponse.fromJson(Map<String, dynamic> json) => GetOrderResponse(
    id: json["id"],
    // user: json["user"],
    totalAmount: json["total_price"],
    // count: json["count"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    items: List<Items>.from(json["order_items"].map((x) => Items.fromJson(x))),
      orderStatus: json["status"],
      time: json["time"],
    date: json["date"],
    fullName: json["full_name"],
    type: json["type"],
      address:json["address"] == null ? null : Address.fromJson(json["address"]),
  );

}


class Items {
  Items({
    this.id,
    this.quantity,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.extras,
    this.price,
  });
  final int? id;
  final int? quantity;
  final num? totalAmount;
  final String? createdAt;
  final String? updatedAt;
  final Product? product;
  final List<Extras>? extras;
  final dynamic price ;



  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    quantity: json["quantity"],
    totalAmount: json["total_amount"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    product: Product.fromJson(json["product"]),
    extras: List<Extras>.from(json["extras"].map((x) => Extras.fromJson(x))),
    price: json["price"]

  );

}


class Product {
  Product({
    this.id,
    this.category,
    this.title,
    this.description,
    this.price,
    this.image,
    this.oldPrice,
    this.quantity,
    this.items,
    this.isNewest,
    this.isBestSeller,
    this.questions,
    this.size,
    this.isAddedToCart,
  });

  final int? id;
  final Categories? category;
  final String? title;
  final String? description;
  final dynamic price;
  final String? size ;
  final String? image;
  final dynamic oldPrice;
  final int? quantity;
  final int? items;
  final bool? isNewest;
  final bool? isBestSeller;
  final bool? isAddedToCart ;
  final List<Questions>? questions;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    category: Categories.fromJson(json["category"]),
    title: json["title"],
    description: json["description"],
    price: json["price"],
    size: json["size"],
    image: json["image"],
    oldPrice: json["old_price"],
    quantity: json["quantity"],
    items: json["items"],
    isNewest: json["is_newest"],
    isBestSeller: json["is_best_seller"],
    isAddedToCart: json["is_added_to_cart"],
    questions: List<Questions>.from(json["questions"].map((x) => Questions.fromJson(x))),
  );

}


class Address {
  Address({
    this.id,
    this.location,
    this.locationName,
    this.street,
    this.city,
    this.label,
    this.building,
    this.floor,
    this.flat,
    this.isMain,
  });

  final int? id;
  final String? location;
  final String? locationName;
  final String? street;
  final String? city;
  final String? label;
  final String? building;
  final String? floor;
  final String? flat;
  final bool? isMain;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    location: json["location"],
    locationName: json["location_name"],
    street: json["street"],
    city: json["city"],
    label: json["label"],
    building: json["building"],
    floor: json["floor"],
    flat: json["flat"],
    isMain: json["is_main"],
  );
}