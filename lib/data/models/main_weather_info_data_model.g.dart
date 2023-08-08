// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_weather_info_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MainWeatherInfoDataModelAdapter
    extends TypeAdapter<MainWeatherInfoDataModel> {
  @override
  final int typeId = 6;

  @override
  MainWeatherInfoDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MainWeatherInfoDataModel(
      t: fields[0] as double,
      tMax: fields[1] as double,
      tMin: fields[2] as double,
      humidity: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MainWeatherInfoDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.t)
      ..writeByte(1)
      ..write(obj.tMax)
      ..writeByte(2)
      ..write(obj.tMin)
      ..writeByte(3)
      ..write(obj.humidity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainWeatherInfoDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
