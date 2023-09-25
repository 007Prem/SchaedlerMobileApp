import 'package:json_annotation/json_annotation.dart';

part 'base_query_parameters.g.dart';

@JsonSerializable()
class BaseQueryParameters {
  BaseQueryParameters({
    this.page,
    this.pageSize,
    this.sort,
  });

  int? page;
  int? pageSize;
  String? sort;

  Map<String, dynamic> toJson() => _$BaseQueryParametersToJson(this);
}
