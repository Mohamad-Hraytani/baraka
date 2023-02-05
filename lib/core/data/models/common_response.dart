class BaseResponse<T> {
  late T responseObject;

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
