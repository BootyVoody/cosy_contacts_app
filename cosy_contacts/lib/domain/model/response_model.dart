class ResponseModel<T> {
  final T? data;
  final String? errorMessage;

  ResponseModel({
    this.data,
    this.errorMessage,
  });
}
