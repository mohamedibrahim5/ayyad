class CreateAddressRequest{
  final String? location;
  final String? label;
  final String? city;
  final String? street;
  final String? building ;
  final String? floor;
  final String? flat;
  final bool? isMain;

  CreateAddressRequest({ this.location, this.label, this.city, this.street, this.building, this.floor, this.flat,this.isMain});


  Map<String,dynamic> toJson(){
    return{
      if(location != null)
        'location':location,
      if(label != null)
        'label':label,
      if(city != null)
        'city':city,
      if(street != null)
        'street':street,
      if(building != null)
        'building':building,
      if(floor != null)
        'floor':floor,
      if(flat != null)
        'flat':flat,
      if(isMain != null)
        'is_main':isMain

    };

  }



}