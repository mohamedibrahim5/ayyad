


import 'get_question_response.dart';

class HomeModel {
  final List<AdsModel>? ads;
  final List<Categories>? categories;
  final List<CartItemModel>? newests;
  final List<CartItemModel>? bestSellers;

  HomeModel({this.ads, this.categories,this.newests,this.bestSellers});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      ads: json['ads'] != null
          ? (json['ads'] as List).map((i) => AdsModel.fromJson(i)).toList()
          : null,
      categories: json['categories'] != null
          ? (json['categories'] as List).map((i) => Categories.fromJson(i)).toList()
          : null,
      newests: json['newests'] != null ? (json['newests'] as List).map((i) => CartItemModel.fromJson(i)).toList() : null,
      bestSellers: json['best_sellers'] != null ? (json['best_sellers'] as List).map((i) => CartItemModel.fromJson(i)).toList() : null,
    );
  }
}


class AdsModel {
  final int? id;
  final String? description;
  final String? webImage;
  final String? mobileImage;

  AdsModel({this.id, this.description, this.webImage,this.mobileImage});

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      id: json['id'],
      description: json['description'],
      webImage: json['web_image'],
      mobileImage: json['mobile_image'],
    );
  }
}


class Categories {
  final int? id;
  final String? title;
  final String? image;

  Categories({this.id, this.title, this.image});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      title: json['title'],
      image: json['image'],
    );
  }

  Categories copyWith({
    int? id,
    String? title,
    String? image,
  }) {
    return Categories(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }
}

class CartItemModel {
  final int? id;
  final Categories? category;
  final String? title;
  final String? description;
  final String? image;
  final dynamic price;
  final dynamic point ;
  final dynamic oldPrice;
  final int? quantity ;
  final int? items ;
  final bool? isNewest;
  final bool? isBestSeller;
  final List<Questions>? questions;
   bool? isAddedToCart ;
   final String? size ;

  CartItemModel({this.id, this.category,this.title,this.description,this.image,this.price,this.oldPrice,this.quantity,this.items,this.isNewest,this.isBestSeller,this.questions,this.isAddedToCart,this.size,this.point});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
        id: json['id'],
        category: json['category'] != null ? Categories.fromJson(json['category']) : null,
        title: json['title'],
        description: json['description'],
        image: json['image'],
        price: json['price'],
        oldPrice: json['old_price'],
        quantity: json['quantity'],
        items: json['items'],
        isNewest: json['is_newest'],
        isBestSeller: json['is_best_seller'],
        isAddedToCart: json['is_added_to_cart'],
        size: json['size'],
        questions: json['questions'] != null ? (json['questions'] as List).map((i) => Questions.fromJson(i)).toList() : null,
       point: json['points'] ?? '0'
    );
  }
}

class BestSellers {
  final int? id;
  final String? category;
  final String? title;
  final String? description;
  final String? image;
  final dynamic price;
  final dynamic oldPrice;
  final int? quantity ;
  final int? items ;
  final bool? isNewest;
  final bool? isBestSeller;
  final List<Questions>? questions;

  BestSellers({this.id, this.category,this.title,this.description,this.image,this.price,this.oldPrice,this.quantity,this.items,this.isNewest,this.isBestSeller,this.questions});

  factory BestSellers.fromJson(Map<String, dynamic> json) {
    return BestSellers(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      oldPrice: json['old_price'],
      quantity: json['quantity'],
      items: json['items'],
      isNewest: json['is_newest'],
      isBestSeller: json['is_best_seller'],
      questions: json['questions'] != null ? (json['questions'] as List).map((i) => Questions.fromJson(i)).toList() : null,
    );
  }
}







