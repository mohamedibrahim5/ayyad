class AddDeleteCartItemResponse{
  // final String? message;
  final num? total;
  // final String? sessionKey;
  AddDeleteCartItemResponse({this.total});

  factory AddDeleteCartItemResponse.fromJson(
      {required Map<String, dynamic> json}){
    return AddDeleteCartItemResponse(
      // message: json['message'],
        total: json['total_price'],
        // sessionKey: json['session_key']
    );
  }


}