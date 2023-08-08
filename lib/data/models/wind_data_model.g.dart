// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WindDataModelAdapter extends TypeAdapter<WindDataModel> {
  @override
  final int typeId = 4;

  @override
  WindDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WindDataModel(
      speed: fields[0] as double,
      degree: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WindDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.speed)
      ..writeByte(1)
      ..write(obj.degree);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WindDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
