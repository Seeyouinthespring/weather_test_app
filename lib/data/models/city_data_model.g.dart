// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CityDataModelAdapter extends TypeAdapter<CityDataModel> {
  @override
  final int typeId = 1;

  @override
  CityDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityDataModel(
      id: fields[0] as int,
      name: fields[1] as String,
      country: fields[2] as String,
      coordinates: fields[3] as CoordinatesDataModel,
    );
  }

  @override
  void write(BinaryWriter writer, CityDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
