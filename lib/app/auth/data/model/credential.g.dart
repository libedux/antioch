// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credential _$CredentialFromJson(Map<String, dynamic> json) => Credential(
      credentialType: $enumDecodeNullable(
              _$CredentialTypeEnumMap, json['credentialType']) ??
          CredentialType.email,
      authType: $enumDecodeNullable(_$AuthTypeEnumMap, json['authType']) ??
          AuthType.login,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      confirmPassword: json['confirm_password'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );

Map<String, dynamic> _$CredentialToJson(Credential instance) =>
    <String, dynamic>{
      'credentialType': _$CredentialTypeEnumMap[instance.credentialType],
      'authType': _$AuthTypeEnumMap[instance.authType],
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
    };

const _$CredentialTypeEnumMap = {
  CredentialType.email: 'email',
  CredentialType.facebook: 'facebook',
};

const _$AuthTypeEnumMap = {
  AuthType.login: 'login',
  AuthType.register: 'register',
  AuthType.logout: 'logout',
};
