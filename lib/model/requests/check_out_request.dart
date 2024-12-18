class CheckOutRequest {
  final String? date;
  final String? time;
  final String? fullName;
  final String? phone;
  final int? promoCodeId;
  final int? addressId;
  final int? branchId;
  final String? notes ;
  final String? paymentMethod;
  final bool? isUsedPoint ;
  final String? type ;

  CheckOutRequest({required this.isUsedPoint, this.date,  this.time,required this.phone,required this.fullName,this.promoCodeId,this.addressId,this.branchId,this.notes,required this.paymentMethod,required this.type});

  Map<String, dynamic> toJson() {
    return {
      if(date != null) 'pickup_date': date,
      if(time != null) 'pickup_time': time,
      'phone_number': phone,
      'full_name': fullName,
      if(promoCodeId != null) 'promo_code': promoCodeId,
      if(addressId != null) 'address': addressId,
      if(branchId != null) 'branch': branchId,
      if(notes != null) 'notes': notes,
      'payment': paymentMethod,
      'is_used_point': isUsedPoint,
      'type': type
    };
  }
}