// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseQueryParameters _$BaseQueryParametersFromJson(Map<String, dynamic> json) =>
    BaseQueryParameters(
      page: json['page'] as int?,
      pageSize: json['pageSize'] as int?,
      sort: json['sort'] as String?,
    );

Map<String, dynamic> _$BaseQueryParametersToJson(BaseQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  return val;
}
