// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyleValue _$StyleValueFromJson(Map<String, dynamic> json) => StyleValue(
      id: json['id'] as String?,
      isDefault: json['isDefault'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      styleTraitId: json['styleTraitId'] as String?,
      styleTraitName: json['styleTraitName'] as String?,
      styleTraitValueId: json['styleTraitValueId'] as String?,
      value: json['value'] as String?,
      valueDisplay: json['valueDisplay'] as String?,
    );

Map<String, dynamic> _$StyleValueToJson(StyleValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('styleTraitName', instance.styleTraitName);
  writeNotNull('styleTraitId', instance.styleTraitId);
  writeNotNull('styleTraitValueId', instance.styleTraitValueId);
  writeNotNull('value', instance.value);
  writeNotNull('valueDisplay', instance.valueDisplay);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('id', instance.id);
  return val;
}
