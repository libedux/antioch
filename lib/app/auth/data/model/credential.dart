import 'package:json_annotation/json_annotation.dart';

part 'credential.g.dart';

@JsonSerializable()
class Credential {
  @JsonKey(defaultValue: CredentialType.email)
  late CredentialType credentialType;

  @JsonKey(defaultValue: AuthType.login)
  late AuthType authType;

  @JsonKey(defaultValue: '')
  String? name;

  @JsonKey(defaultValue: '')
  String email;

  @JsonKey(defaultValue: '')
  String? password;

  @JsonKey(defaultValue: '', name: 'confirm_password')
  String? confirmPassword;

  Credential({
    required this.credentialType,
    required this.authType,
    this.name,
    this.email = '',
    this.confirmPassword,
    this.password,
  });

  factory Credential.fromJson(Map<String, dynamic> json) => _$CredentialFromJson(json);

  /// Connect the generated [_$CredentialToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CredentialToJson(this);
}

enum AuthType { login, register, logout }

enum CredentialType { email, facebook }
