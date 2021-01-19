class ResponseModel {
  final bool _isError;
  final String _errorMsg;

  ResponseModel(
    this._isError,
    this._errorMsg,
  );

  bool get isError => _isError;
  String get errorMsg => _errorMsg;

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      json['error'] as bool,
      json['errorMsg'] as String,
    );
  }
}

class DataModel extends ResponseModel {
  final int _count;
  final dynamic _data;

  DataModel(
    bool _error,
    String _errorMsg,
    this._count,
    this._data,
  ) : super(_error, _errorMsg);

  int get count => _count;
  dynamic get data => _data;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      json['error'] as bool,
      json['errorMsg'].toString(),
      json['count'] as int,
      json['data'],
    );
  }
}
