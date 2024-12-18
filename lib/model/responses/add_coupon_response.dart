class AddCouponResponse{
  final num? discount;
  final String? coupon ;
  final String? code;
  final int? id ;

  AddCouponResponse({this.discount,this.coupon,this.code,this.id});

  factory AddCouponResponse.fromJson({
    required Map<String,dynamic>json}){
    return AddCouponResponse(
      discount : json['discount'],
      id: json['id'],
    );
  }

  factory AddCouponResponse.fromNotVerified({required Map<String, dynamic> json}) {
    return AddCouponResponse(
        code: json['code']
    );
  }

}