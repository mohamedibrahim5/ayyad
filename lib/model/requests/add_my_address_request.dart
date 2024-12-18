import 'package:hive/hive.dart';

part 'add_my_address_request.g.dart';


@HiveType(typeId: 1)
class AddNewAddressRequest  {
  @HiveField(0)
  final int? floor;
  @HiveField(1)
  final int? flatNumber;
  @HiveField(2)
  final String? label;
  @HiveField(3)
  final String? area;
  @HiveField(4)
  final String? addressDetails;
  @HiveField(5)
  final String? deliveryInstructions;
  @HiveField(6)
  final String? latlong;
  @HiveField(7)
  final String? address;

  AddNewAddressRequest({required this.floor, required this.flatNumber,required this.label,required this.area,required this.addressDetails,required this.deliveryInstructions,required this.latlong,required this.address});

  Map<String, dynamic> toJson() {
    return {
      'floor': floor,
      'float_number': flatNumber,
      'label':label,
      'area':area,
      'address_details':addressDetails,
      if(deliveryInstructions != null && deliveryInstructions!.isNotEmpty)
        'delivery_instructions':deliveryInstructions,
      'latlong':latlong,
      'address':address

    };
  }
}



