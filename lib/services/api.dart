import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../exceptions/network_exception.dart';

abstract class Api<T> {
  final String _baseUrl;

  Api(this._baseUrl);

  Future<T> post(String url, Map<String, dynamic> body) async {
    try {
      final http.Response response = await http.post(
        _baseUrl + url,
        headers: {"Content-Type": 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      _throwException(response);

      print(response.body);
      return parsedJson(response.body);
    } on SocketException {
      throw FetchDataException('No Internet connection!');
    }
  }

  T parsedJson(String responseBody);

  void _throwException(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return;

      case 400:
        throw BadRequestException(response.body);

      case 401:
      case 403:
        throw UnauthorisedException(response.body);

      default:
        throw FetchDataException('${response.statusCode}');
    }
  }
}
