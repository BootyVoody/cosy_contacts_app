import 'package:dio/dio.dart';

class BackedApi {
  final String _defaultBaseUrl = 'http://192.268.';

  final Dio _dio;

  BackedApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }
}
