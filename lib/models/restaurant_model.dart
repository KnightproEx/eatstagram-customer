class RestaurantModel {
  final String _id;
  final String _email;
  final String _title;
  final String _desc;
  final String _imagePath;
  final int _tableCount;

  RestaurantModel(
    this._id,
    this._email,
    this._title,
    this._desc,
    this._imagePath,
    this._tableCount,
  );

  String get id => _id;
  String get email => _email;
  String get title => _title;
  String get desc => _desc;
  int get tableCount => _tableCount;
  String get imagePath => _imagePath;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      json['id'].toString(),
      json['email'].toString(),
      json['title'].toString(),
      json['desc'].toString(),
      json['image_path'].toString(),
      int.parse(json['table_count'].toString()),
    );
  }
}
