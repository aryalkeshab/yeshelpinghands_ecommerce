class Store {
  String? storeName;
  String? imageUrl;
  List<LongLat>? longlat;
  double? longitude;
  double? latitude;
  String? description;

  Store(
      {this.latitude,
      this.longitude,
      this.longlat,
      this.imageUrl,
      this.storeName,
      this.description});
}

class LongLat {
  double? longitude;
  double? latitude;

  LongLat({this.latitude, this.longitude});
}
