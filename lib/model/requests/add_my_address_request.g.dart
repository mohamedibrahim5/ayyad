// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_my_address_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddNewAddressRequestAdapter extends TypeAdapter<AddNewAddressRequest> {
  @override
  final int typeId = 1;

  @override
  AddNewAddressRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddNewAddressRequest(
      floor: fields[0] as int?,
      flatNumber: fields[1] as int?,
      label: fields[2] as String?,
      area: fields[3] as String?,
      addressDetails: fields[4] as String?,
      deliveryInstructions: fields[5] as String?,
      latlong: fields[6] as String?,
      address: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddNewAddressRequest obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.floor)
      ..writeByte(1)
      ..write(obj.flatNumber)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.area)
      ..writeByte(4)
      ..write(obj.addressDetails)
      ..writeByte(5)
      ..write(obj.deliveryInstructions)
      ..writeByte(6)
      ..write(obj.latlong)
      ..writeByte(7)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddNewAddressRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
