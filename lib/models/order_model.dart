class OrderModel {
  final String _id;
  final String _table;
  final String _time;
  final int _status;
  final double _total;

  OrderModel(
    this._id,
    this._table,
    this._time,
    this._status,
    this._total,
  );

  String get id => _id;
  String get table => _table;
  String get time => _time;
  int get status => _status;
  double get total => _total;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      json['id'].toString(),
      json['table'].toString(),
      json['time'].toString(),
      int.parse(json['status'].toString()),
      double.parse(json['total'].toString()),
    );
  }
}
