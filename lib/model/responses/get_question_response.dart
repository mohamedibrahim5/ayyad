

import 'get_extra_response.dart';

class Questions {
  final int? id;
  final int? product;
  String? title;
  final List<Extras>? extras;
  final String? click;
  final bool? isRequired;

  Questions({
    this.id,
    this.product,
    this.title,
    this.extras,
    this.click,
    this.isRequired,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      id: json['id'],
      product: json['product'],
      title: json['title'],
      extras: json['extras'] != null
          ? (json['extras'] as List).map((i) => Extras.fromJson(i)).toList()
          : null,
      click: json['click'],
      isRequired: json['is_required'],
    );
  }

  Questions copyWith({
    int? id,
    int? product,
    String? title,
    List<Extras>? extras,
    String? click,
    bool? isRequired,
  }) {
    return Questions(
      id: id ?? this.id,
      product: product ?? this.product,
      title: title ?? this.title,
      extras: extras ?? this.extras?.map((extra) => extra.copyWith()).toList(),
      click: click ?? this.click,
      isRequired: isRequired ?? this.isRequired,
    );
  }
}
