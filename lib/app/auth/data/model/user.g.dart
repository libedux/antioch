// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profession: json['profession'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      school: json['school'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'profession': instance.profession,
      'dob': instance.dob,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'school': instance.school,
    };
