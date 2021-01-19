class MenuModel {
  final String _id;
  final String _name;
  final String _category;
  final String _desc;
  final double _price;
  final String _imagePath;

  MenuModel(
    this._id,
    this._name,
    this._category,
    this._desc,
    this._price,
    this._imagePath,
  );

  String get id => _id;
  String get name => _name;
  String get category => _category;
  String get desc => _desc;
  double get price => _price;
  String get imagePath => _imagePath;

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      json['id'].toString(),
      json['name'].toString(),
      json['category'].toString(),
      json['desc'].toString(),
      double.parse(json['price'].toString()),
      json['image_path'].toString(),
    );
  }
}
