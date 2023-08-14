import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;
  final String? errorMsg;
  const DataState({this.data, this.error,this.errorMsg});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioError error) : super(error: error);
}

class DataFailedErrorMsg<T> extends DataState<T> {
  const DataFailedErrorMsg(String error) : super(errorMsg: error);
}
