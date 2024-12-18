class CreateAddressModelResponse {
  int? id;
  int? contentType;
  int? objectId;
  String? location;
  String? label;

  String? city;
  String? street;
  String? building;
  String? floor;
  String? flat;
  String? locationName;
  bool? isMain;


  CreateAddressModelResponse({this.location, this.label,this.id,this.contentType,this.objectId,this.city,this.street,this.building,this.floor,this.flat,this.locationName,this.isMain});

  CreateAddressModelResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    label = json['label'];
    id = json['id'];
    contentType = json['content_type'];
    objectId = json['object_id'];
    city = json['city'];
    street = json['street'];
    building = json['building'];
    floor = json['floor'];
    flat = json['flat'];
    locationName = json['location_name'];
    isMain = json['is_main'];
  }
}