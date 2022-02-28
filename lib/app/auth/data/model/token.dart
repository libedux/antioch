import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(defaultValue: '')
  late String value;

  Token({
    required this.value,
  });

  
  factory Token.fromJson(Map<String, dynamic> json) =>
      _$TokenFromJson(json);

  /// Connect the generated [_$TokenToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

