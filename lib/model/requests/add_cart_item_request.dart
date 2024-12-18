class AddCartItemRequest {
final int? productId;
final int? quantity;
final List<int?> extrasaIds ;
final Map<String, int>? quantities;

  AddCartItemRequest({required this.productId, required this.quantity,required this.extrasaIds,this.quantities});

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'extras_ids':extrasaIds,
      if(quantities!=null)
        'quantities':quantities

    };
  }
}



