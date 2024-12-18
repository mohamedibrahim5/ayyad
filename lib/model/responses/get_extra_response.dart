class Extras {
  final int? id;
  final String? title;
  final dynamic price;
  final String? click;
  bool? isSelectedCHECK;
  bool? isSelectedOPTIONAL;

  Extras({
    this.id,
    this.title,
    this.price,
    this.isSelectedCHECK = false,
    this.click,
    this.isSelectedOPTIONAL = false,
  });

  factory Extras.fromJson(Map<String, dynamic> json) {
    return Extras(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      click: json['click'],
    );
  }

  Extras copyWith({
    int? id,
    String? title,
    dynamic price,
    String? click,
    bool? isSelectedCHECK,
    bool? isSelectedOPTIONAL,
  }) {
    return Extras(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      click: click ?? this.click,
      isSelectedCHECK: isSelectedCHECK ?? this.isSelectedCHECK,
      isSelectedOPTIONAL: isSelectedOPTIONAL ?? this.isSelectedOPTIONAL,
    );
  }
}
