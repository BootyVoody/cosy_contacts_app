import 'package:dio/dio.dart';

class BackedApi {
  final Dio _dio;

  BackedApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }
}
