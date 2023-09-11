import 'dart:convert';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:http/http.dart' as http;

part 'service_base.g.dart';

class ServiceResponse<T> {
  ServiceResponse({
    this.error,
    this.model,
    this.exception,
    this.statusCode,
    this.isCached,
  });

  ErrorResponse? error;

  T? model;

  Exception? exception;

  // HttpStatusCode? statusCode;
  int? statusCode;

  bool? isCached = false;
}

@JsonSerializable(explicitToJson: true)
class ErrorResponse {
  ErrorResponse({
    this.error,
    this.errorDescription,
    this.message,
  });

  String? message;

  String? error;

  @JsonKey(name: 'error_description')
  String? errorDescription;

  static ErrorResponse empty() {
    return ErrorResponse();
  }

  String? extractErrorMessage() {
    if (!message!.isNullOrEmpty) {
      return message;
    }

    return errorDescription;
  }

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}

class ServiceBase {
  T deserializeFromResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) {
    String jsonString = response.body;
    return deserializeFromString(jsonString, fromJson);
  }

  Future<T> deserializeFromStreamedResponse<T>(http.StreamedResponse streamedResponse, T Function(Map<String, dynamic>) fromJson) async {
    String jsonString = await streamedResponse.stream.bytesToString();
    return deserializeFromString(jsonString, fromJson);
  }

  T deserializeFromString<T>(String jsonString, T Function(Map<String, dynamic>) fromJson) {
    var jsonMap = json.decode(jsonString);
    var x = fromJson(jsonMap);
    return x;
  }

  T deserializeFromMap<T>(Map <String, dynamic> jsonMap, T Function(Map<String, dynamic>) fromJson) {
    return fromJson(jsonMap);
  }

  String serializeModel<T>(T model) {
    return jsonEncode(model);
  }

  Future<ServiceResponse<T>> getAsyncNoCache<T>(String url, T Function(Map<String, dynamic>) fromJson, {Duration? timeout}) {
    /// TODO - implement get 
    
    
    throw UnimplementedError();
  }
}
