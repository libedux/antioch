import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  @JsonKey(defaultValue: false)
  bool success;

  @JsonKey(defaultValue: '')
  String message;

  @JsonKey(defaultValue: [])
  List? data;

  ResponseModel({
    this.success=false,
    this.message = '',
    this.data
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  /// Connect the generated [_$ResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
