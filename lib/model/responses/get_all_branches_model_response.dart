class GetAllBranchesModelResponse {
  GetAllBranchesModelResponse({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;

  factory GetAllBranchesModelResponse.fromJson(Map<String, dynamic> json) => GetAllBranchesModelResponse(
    id: json["id"],
    name: json["name"],
  );
}