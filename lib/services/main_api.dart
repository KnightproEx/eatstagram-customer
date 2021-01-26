import 'dart:convert';

import '../models/response_model.dart';
import 'api.dart';

abstract class MainApi extends Api<ResponseModel> {
  MainApi() : super('https://projectsdp.000webhostapp.com/');
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
