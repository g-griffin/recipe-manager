import 'package:json_annotation/json_annotation.dart';

part 'index.g.dart';

@JsonSerializable(includeIfNull: false)
class Index {
  final int? id;
  final String indexText;

  const Index({this.id, required this.indexText});

  factory Index.fromJson(Map<String, dynamic> json) => _$IndexFromJson(json);

  Map<String, dynamic> toJson() => _$IndexToJson(this);
}
