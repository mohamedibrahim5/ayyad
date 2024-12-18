class GetProfileResponse {
  GetProfileResponse({
     this.phone,
    this.email,
    this.fullName,
    this.id,
    this.points,
    this.cashback
  });

   String? phone;
   String? email;
   String? fullName ;
   int? id ;
   num? points ;
    num? cashback ;

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
        phone: json['phone'],
        email: json['email'],
        id: json['id'],
          fullName: json['full_name'],
          points: json['points'],
          cashback: json['cash_back']
      );
}