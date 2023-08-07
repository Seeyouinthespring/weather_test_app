class CoordinatesDataModel{
  final double lat;
  final double long;

  CoordinatesDataModel({required this.lat, required this.long});

  factory CoordinatesDataModel.fromJson(Map<String, dynamic> json) => CoordinatesDataModel(
    lat: json['lat'],
    long: json['long'],
  );

  factory CoordinatesDataModel.placeholder() => CoordinatesDataModel(lat: 0.0, long: 0.0);

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'long': long,
  };
}