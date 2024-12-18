import 'get_extra_response.dart';
import 'get_home_response.dart';
import 'get_question_response.dart';

class GetCartModel {
  GetCartModel({
    this.id,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  final int? id;
  String? totalPrice;
  final String? createdAt;
  final String? updatedAt;
   List<Items>? items;

  factory GetCartModel.fromJson(Map<String, dynamic> json) => GetCartModel(
    id: json["id"],
    totalPrice: json["total_price"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    items: List<Items>.from(json["cart_items"].map((x) => Items.fromJson(x))),
  );

  GetCartModel copyWith({
    int? id,
    String? totalAmount,
    String? createdAt,
    String? updatedAt,
    List<Items>? items,
  }) {
    return GetCartModel(
      id: id ?? this.id,
      totalPrice: totalAmount ?? totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items?.map((item) => item.copyWith()).toList(),
    );
  }
}


class ItemsUpdate {
  ItemsUpdate({
    this.total,
    this.item,
  });

  final num? total;
  final Items? item;

  factory ItemsUpdate.fromJson(Map<String, dynamic> json) => ItemsUpdate(
    total: json["total"],
    item: Items.fromJson(json["data"]),
  );

  ItemsUpdate copyWith({
    num? total,
    Items? item,
  }) {
    return ItemsUpdate(
      total: total ?? this.total,
      item: item ?? this.item?.copyWith(),
    );
  }
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
   int? quantity;
  final String? totalAmount;
  final String? createdAt;
  final String? updatedAt;
  final Product? product;
  final List<Extras>? extras;
  final String? price;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    id: json["id"],
    quantity: json["quantity"],
    totalAmount: json["price"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    product: Product.fromJson(json["product"]),
    extras: List<Extras>.from(json["extras"].map((x) => Extras.fromJson(x))),
    price: json["price"],
  );

  Items copyWith({
    int? id,
    int? quantity,
    String? totalAmount,
    String? createdAt,
    String? updatedAt,
    Product? product,
    List<Extras>? extras,
    String? price,
  }) {
    return Items(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product?.copyWith(),
      extras: extras ?? this.extras?.map((extra) => extra.copyWith()).toList(),
      price: price ?? this.price,
    );
  }
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
    this.point,
  });

  final int? id;
  final Categories? category;
  final String? title;
  final String? description;
  final dynamic price;
  final String? size;
  final String? image;
  final dynamic oldPrice;
  final int? quantity;
  final int? items;
  final bool? isNewest;
  final bool? isBestSeller;
  final bool? isAddedToCart;
  final List<Questions>? questions;
  final String? point;

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
    point: json["point"] ?? '0',
  );

  Product copyWith({
    int? id,
    Categories? category,
    String? title,
    String? description,
    dynamic price,
    String? size,
    String? image,
    dynamic oldPrice,
    int? quantity,
    int? items,
    bool? isNewest,
    bool? isBestSeller,
    bool? isAddedToCart,
    List<Questions>? questions,
  }) {
    return Product(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      size: size ?? this.size,
      image: image ?? this.image,
      oldPrice: oldPrice ?? this.oldPrice,
      quantity: quantity ?? this.quantity,
      items: items ?? this.items,
      isNewest: isNewest ?? this.isNewest,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      questions: questions ?? this.questions?.map((q) => q.copyWith()).toList(),
    );
  }
}

