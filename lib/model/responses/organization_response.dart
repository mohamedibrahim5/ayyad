class OrganizationModelResponse {
  final int? id;
  final String? name ;
  final String? logo;
  final String? domain;
  final String? createdAt;

  OrganizationModelResponse({this.id,this.name,this.logo,this.domain,this.createdAt});

  factory OrganizationModelResponse.fromJson({
    required Map<String,dynamic>json}){
    return OrganizationModelResponse(
      id : json['id'],
      name: json['name'],
      logo: json['logo'],
      domain: json['domain'],
      createdAt: json['created_at']
    );
  }
}