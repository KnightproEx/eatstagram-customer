import 'dart:convert';

import '../models/response_model.dart';
import 'api.dart';

abstract class MainApi extends Api<ResponseModel> {
  MainApi() : super('http://192.168.137.1/test_res/');
}

class ResponseModelApi extends MainApi {
  @override
  ResponseModel parsedJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    return ResponseModel.fromJson(parsed);
  }
}

class DataModelApi extends MainApi {
  @override
  DataModel parsedJson(String responseBody) {
    final Map<String, dynamic> parsed = jsonDecode(responseBody);
    return DataModel.fromJson(parsed);
  }
}
