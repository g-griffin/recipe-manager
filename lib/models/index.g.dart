// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Index _$IndexFromJson(Map<String, dynamic> json) => Index(
      id: json['id'] as int?,
      indexText: json['indexText'] as String,
    );

Map<String, dynamic> _$IndexToJson(Index instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['indexText'] = instance.indexText;
  return val;
}
