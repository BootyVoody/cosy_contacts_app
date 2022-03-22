class ResponseModel<T> {
  final T data;
  final String errorMessage;

  ResponseModel({
    required this.data,
    required this.errorMessage,
  });
}
