// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_description_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherDescriptionDataModelAdapter
    extends TypeAdapter<WeatherDescriptionDataModel> {
  @override
  final int typeId = 5;

  @override
  WeatherDescriptionDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherDescriptionDataModel(
      id: fields[0] as int,
      description: fields[1] as String,
      main: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDescriptionDataModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.main);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDescriptionDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
