class AddSessionModelResponse {
  AddSessionModelResponse({
     this.id,
     this.session,
  });

  final int? id;
  final String? session;

  factory AddSessionModelResponse.fromJson(Map<String, dynamic> json) => AddSessionModelResponse(
    id: json["id"],
    session: json["session_key"],
  );
}