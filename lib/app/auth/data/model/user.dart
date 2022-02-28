import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(defaultValue: '')
  String? email;

  @JsonKey(defaultValue: '')
  String? name;

  @JsonKey(defaultValue: '')
  String? profession;

  @JsonKey(defaultValue: '')
  String? dob;

  @JsonKey(defaultValue: '')
  String? gender;

  @JsonKey(defaultValue: '')
  String? nationality;

  @JsonKey(defaultValue: '')
  String? school;

  User({this.name, this.email, this.profession, this.dob, this.nationality, this.gender, this.school});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
