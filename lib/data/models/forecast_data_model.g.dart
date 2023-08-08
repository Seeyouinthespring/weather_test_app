// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastDataModelAdapter extends TypeAdapter<ForecastDataModel> {
  @override
  final int typeId = 0;

  @override
  ForecastDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForecastDataModel(
      city: fields[0] as CityDataModel,
      list: (fields[1] as List).cast<WeatherInfoSectionDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ForecastDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
