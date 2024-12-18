class PatchCartItemRequest {
  final int? productId;
  final int? quantity;
  final List<int?> extrasaIds ;
  final Map<String, int>? quantities;

  PatchCartItemRequest({required this.productId, required this.quantity,required this.extrasaIds,this.quantities});

  Map<String, dynamic> toJson() {
    return {
      // 'cart_item_id': productId,
      'quantity': quantity,
      'extras_ids':extrasaIds,
      if(quantities!=null)
        'quantities':quantities
    };
  }
}