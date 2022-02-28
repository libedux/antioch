import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed  
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  // Used on failure of request such as timeout, wrong method
  const factory ApiResult.failure({required String error}) =
      Failure<T>;
}
