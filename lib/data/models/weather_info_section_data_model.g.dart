// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_section_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherInfoSectionDataModelAdapter
    extends TypeAdapter<WeatherInfoSectionDataModel> {
  @override
  final int typeId = 3;

  @override
  WeatherInfoSectionDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherInfoSectionDataModel(
      ticks: fields[0] as int,
      dateTime: fields[1] as String,
      wind: fields[2] as WindDataModel,
      weather: fields[3] as WeatherDescriptionDataModel,
      main: fields[4] as MainWeatherInfoDataModel,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherInfoSectionDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.ticks)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.wind)
      ..writeByte(3)
      ..write(obj.weather)
      ..writeByte(4)
      ..write(obj.main);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherInfoSectionDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
