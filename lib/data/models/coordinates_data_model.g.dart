// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CoordinatesDataModelAdapter extends TypeAdapter<CoordinatesDataModel> {
  @override
  final int typeId = 2;

  @override
  CoordinatesDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CoordinatesDataModel(
      lat: fields[0] as double,
      long: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CoordinatesDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.long);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoordinatesDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
